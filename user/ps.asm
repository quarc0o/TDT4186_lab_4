
user/_ps:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
    struct user_proc *procs = ps(0, 64);
   e:	04000593          	li	a1,64
  12:	4501                	li	a0,0
  14:	00000097          	auipc	ra,0x0
  18:	5a0080e7          	jalr	1440(ra) # 5b4 <ps>

    for (int i = 0; i < 64; i++)
  1c:	01450493          	addi	s1,a0,20
  20:	6785                	lui	a5,0x1
  22:	91478793          	addi	a5,a5,-1772 # 914 <free+0x4a>
  26:	00f50933          	add	s2,a0,a5
    {
        if (procs[i].state == UNUSED)
            break;
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  2a:	00001997          	auipc	s3,0x1
  2e:	a1698993          	addi	s3,s3,-1514 # a40 <malloc+0xf4>
        if (procs[i].state == UNUSED)
  32:	fec4a683          	lw	a3,-20(s1)
  36:	ce89                	beqz	a3,50 <main+0x50>
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  38:	ff84a603          	lw	a2,-8(s1)
  3c:	85a6                	mv	a1,s1
  3e:	854e                	mv	a0,s3
  40:	00001097          	auipc	ra,0x1
  44:	854080e7          	jalr	-1964(ra) # 894 <printf>
    for (int i = 0; i < 64; i++)
  48:	02448493          	addi	s1,s1,36
  4c:	ff2493e3          	bne	s1,s2,32 <main+0x32>
    }
    exit(0);
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	4c2080e7          	jalr	1218(ra) # 514 <exit>

000000000000005a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e422                	sd	s0,8(sp)
  5e:	0800                	addi	s0,sp,16
    lk->name = name;
  60:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  62:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  66:	57fd                	li	a5,-1
  68:	00f50823          	sb	a5,16(a0)
}
  6c:	6422                	ld	s0,8(sp)
  6e:	0141                	addi	sp,sp,16
  70:	8082                	ret

0000000000000072 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  72:	00054783          	lbu	a5,0(a0)
  76:	e399                	bnez	a5,7c <holding+0xa>
  78:	4501                	li	a0,0
}
  7a:	8082                	ret
{
  7c:	1101                	addi	sp,sp,-32
  7e:	ec06                	sd	ra,24(sp)
  80:	e822                	sd	s0,16(sp)
  82:	e426                	sd	s1,8(sp)
  84:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  86:	01054483          	lbu	s1,16(a0)
  8a:	00000097          	auipc	ra,0x0
  8e:	172080e7          	jalr	370(ra) # 1fc <twhoami>
  92:	2501                	sext.w	a0,a0
  94:	40a48533          	sub	a0,s1,a0
  98:	00153513          	seqz	a0,a0
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6105                	addi	sp,sp,32
  a4:	8082                	ret

00000000000000a6 <acquire>:

void acquire(struct lock *lk)
{
  a6:	7179                	addi	sp,sp,-48
  a8:	f406                	sd	ra,40(sp)
  aa:	f022                	sd	s0,32(sp)
  ac:	ec26                	sd	s1,24(sp)
  ae:	e84a                	sd	s2,16(sp)
  b0:	e44e                	sd	s3,8(sp)
  b2:	e052                	sd	s4,0(sp)
  b4:	1800                	addi	s0,sp,48
  b6:	8a2a                	mv	s4,a0
    if (holding(lk))
  b8:	00000097          	auipc	ra,0x0
  bc:	fba080e7          	jalr	-70(ra) # 72 <holding>
  c0:	e919                	bnez	a0,d6 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c2:	ffca7493          	andi	s1,s4,-4
  c6:	003a7913          	andi	s2,s4,3
  ca:	0039191b          	slliw	s2,s2,0x3
  ce:	4985                	li	s3,1
  d0:	012999bb          	sllw	s3,s3,s2
  d4:	a015                	j	f8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  d6:	00001517          	auipc	a0,0x1
  da:	97a50513          	addi	a0,a0,-1670 # a50 <malloc+0x104>
  de:	00000097          	auipc	ra,0x0
  e2:	7b6080e7          	jalr	1974(ra) # 894 <printf>
        exit(-1);
  e6:	557d                	li	a0,-1
  e8:	00000097          	auipc	ra,0x0
  ec:	42c080e7          	jalr	1068(ra) # 514 <exit>
    {
        // give up the cpu for other threads
        tyield();
  f0:	00000097          	auipc	ra,0x0
  f4:	0f4080e7          	jalr	244(ra) # 1e4 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  fc:	0127d7bb          	srlw	a5,a5,s2
 100:	0ff7f793          	zext.b	a5,a5
 104:	f7f5                	bnez	a5,f0 <acquire+0x4a>
    }

    __sync_synchronize();
 106:	0ff0000f          	fence

    lk->tid = twhoami();
 10a:	00000097          	auipc	ra,0x0
 10e:	0f2080e7          	jalr	242(ra) # 1fc <twhoami>
 112:	00aa0823          	sb	a0,16(s4)
}
 116:	70a2                	ld	ra,40(sp)
 118:	7402                	ld	s0,32(sp)
 11a:	64e2                	ld	s1,24(sp)
 11c:	6942                	ld	s2,16(sp)
 11e:	69a2                	ld	s3,8(sp)
 120:	6a02                	ld	s4,0(sp)
 122:	6145                	addi	sp,sp,48
 124:	8082                	ret

0000000000000126 <release>:

void release(struct lock *lk)
{
 126:	1101                	addi	sp,sp,-32
 128:	ec06                	sd	ra,24(sp)
 12a:	e822                	sd	s0,16(sp)
 12c:	e426                	sd	s1,8(sp)
 12e:	1000                	addi	s0,sp,32
 130:	84aa                	mv	s1,a0
    if (!holding(lk))
 132:	00000097          	auipc	ra,0x0
 136:	f40080e7          	jalr	-192(ra) # 72 <holding>
 13a:	c11d                	beqz	a0,160 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 13c:	57fd                	li	a5,-1
 13e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 142:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 146:	0ff0000f          	fence
 14a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 14e:	00000097          	auipc	ra,0x0
 152:	096080e7          	jalr	150(ra) # 1e4 <tyield>
}
 156:	60e2                	ld	ra,24(sp)
 158:	6442                	ld	s0,16(sp)
 15a:	64a2                	ld	s1,8(sp)
 15c:	6105                	addi	sp,sp,32
 15e:	8082                	ret
        printf("releasing lock we are not holding");
 160:	00001517          	auipc	a0,0x1
 164:	91850513          	addi	a0,a0,-1768 # a78 <malloc+0x12c>
 168:	00000097          	auipc	ra,0x0
 16c:	72c080e7          	jalr	1836(ra) # 894 <printf>
        exit(-1);
 170:	557d                	li	a0,-1
 172:	00000097          	auipc	ra,0x0
 176:	3a2080e7          	jalr	930(ra) # 514 <exit>

000000000000017a <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 180:	00001717          	auipc	a4,0x1
 184:	e8073703          	ld	a4,-384(a4) # 1000 <current_thread>
 188:	47c1                	li	a5,16
 18a:	c319                	beqz	a4,190 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 18c:	37fd                	addiw	a5,a5,-1
 18e:	fff5                	bnez	a5,18a <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 190:	6422                	ld	s0,8(sp)
 192:	0141                	addi	sp,sp,16
 194:	8082                	ret

0000000000000196 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 196:	7179                	addi	sp,sp,-48
 198:	f406                	sd	ra,40(sp)
 19a:	f022                	sd	s0,32(sp)
 19c:	ec26                	sd	s1,24(sp)
 19e:	e84a                	sd	s2,16(sp)
 1a0:	e44e                	sd	s3,8(sp)
 1a2:	1800                	addi	s0,sp,48
 1a4:	84aa                	mv	s1,a0
 1a6:	89b2                	mv	s3,a2
 1a8:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1aa:	09000513          	li	a0,144
 1ae:	00000097          	auipc	ra,0x0
 1b2:	79e080e7          	jalr	1950(ra) # 94c <malloc>
 1b6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1b8:	478d                	li	a5,3
 1ba:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1bc:	609c                	ld	a5,0(s1)
 1be:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1c2:	609c                	ld	a5,0(s1)
 1c4:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1c8:	70a2                	ld	ra,40(sp)
 1ca:	7402                	ld	s0,32(sp)
 1cc:	64e2                	ld	s1,24(sp)
 1ce:	6942                	ld	s2,16(sp)
 1d0:	69a2                	ld	s3,8(sp)
 1d2:	6145                	addi	sp,sp,48
 1d4:	8082                	ret

00000000000001d6 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1dc:	4501                	li	a0,0
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret

00000000000001e4 <tyield>:

void tyield()
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1ea:	00001797          	auipc	a5,0x1
 1ee:	e167b783          	ld	a5,-490(a5) # 1000 <current_thread>
 1f2:	470d                	li	a4,3
 1f4:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <twhoami>:

uint8 twhoami()
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 202:	4501                	li	a0,0
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <tswtch>:
 20a:	00153023          	sd	ra,0(a0)
 20e:	00253423          	sd	sp,8(a0)
 212:	e900                	sd	s0,16(a0)
 214:	ed04                	sd	s1,24(a0)
 216:	03253023          	sd	s2,32(a0)
 21a:	03353423          	sd	s3,40(a0)
 21e:	03453823          	sd	s4,48(a0)
 222:	03553c23          	sd	s5,56(a0)
 226:	05653023          	sd	s6,64(a0)
 22a:	05753423          	sd	s7,72(a0)
 22e:	05853823          	sd	s8,80(a0)
 232:	05953c23          	sd	s9,88(a0)
 236:	07a53023          	sd	s10,96(a0)
 23a:	07b53423          	sd	s11,104(a0)
 23e:	0005b083          	ld	ra,0(a1)
 242:	0085b103          	ld	sp,8(a1)
 246:	6980                	ld	s0,16(a1)
 248:	6d84                	ld	s1,24(a1)
 24a:	0205b903          	ld	s2,32(a1)
 24e:	0285b983          	ld	s3,40(a1)
 252:	0305ba03          	ld	s4,48(a1)
 256:	0385ba83          	ld	s5,56(a1)
 25a:	0405bb03          	ld	s6,64(a1)
 25e:	0485bb83          	ld	s7,72(a1)
 262:	0505bc03          	ld	s8,80(a1)
 266:	0585bc83          	ld	s9,88(a1)
 26a:	0605bd03          	ld	s10,96(a1)
 26e:	0685bd83          	ld	s11,104(a1)
 272:	8082                	ret

0000000000000274 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 274:	1101                	addi	sp,sp,-32
 276:	ec06                	sd	ra,24(sp)
 278:	e822                	sd	s0,16(sp)
 27a:	e426                	sd	s1,8(sp)
 27c:	e04a                	sd	s2,0(sp)
 27e:	1000                	addi	s0,sp,32
 280:	84aa                	mv	s1,a0
 282:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 284:	09000513          	li	a0,144
 288:	00000097          	auipc	ra,0x0
 28c:	6c4080e7          	jalr	1732(ra) # 94c <malloc>

    main_thread->tid = 0;
 290:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 294:	85ca                	mv	a1,s2
 296:	8526                	mv	a0,s1
 298:	00000097          	auipc	ra,0x0
 29c:	d68080e7          	jalr	-664(ra) # 0 <main>
    exit(res);
 2a0:	00000097          	auipc	ra,0x0
 2a4:	274080e7          	jalr	628(ra) # 514 <exit>

00000000000002a8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2ae:	87aa                	mv	a5,a0
 2b0:	0585                	addi	a1,a1,1
 2b2:	0785                	addi	a5,a5,1
 2b4:	fff5c703          	lbu	a4,-1(a1)
 2b8:	fee78fa3          	sb	a4,-1(a5)
 2bc:	fb75                	bnez	a4,2b0 <strcpy+0x8>
        ;
    return os;
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <strcmp>:

int strcmp(const char *p, const char *q)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2ca:	00054783          	lbu	a5,0(a0)
 2ce:	cb91                	beqz	a5,2e2 <strcmp+0x1e>
 2d0:	0005c703          	lbu	a4,0(a1)
 2d4:	00f71763          	bne	a4,a5,2e2 <strcmp+0x1e>
        p++, q++;
 2d8:	0505                	addi	a0,a0,1
 2da:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2dc:	00054783          	lbu	a5,0(a0)
 2e0:	fbe5                	bnez	a5,2d0 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2e2:	0005c503          	lbu	a0,0(a1)
}
 2e6:	40a7853b          	subw	a0,a5,a0
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret

00000000000002f0 <strlen>:

uint strlen(const char *s)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2f6:	00054783          	lbu	a5,0(a0)
 2fa:	cf91                	beqz	a5,316 <strlen+0x26>
 2fc:	0505                	addi	a0,a0,1
 2fe:	87aa                	mv	a5,a0
 300:	86be                	mv	a3,a5
 302:	0785                	addi	a5,a5,1
 304:	fff7c703          	lbu	a4,-1(a5)
 308:	ff65                	bnez	a4,300 <strlen+0x10>
 30a:	40a6853b          	subw	a0,a3,a0
 30e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
    for (n = 0; s[n]; n++)
 316:	4501                	li	a0,0
 318:	bfe5                	j	310 <strlen+0x20>

000000000000031a <memset>:

void *
memset(void *dst, int c, uint n)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 320:	ca19                	beqz	a2,336 <memset+0x1c>
 322:	87aa                	mv	a5,a0
 324:	1602                	slli	a2,a2,0x20
 326:	9201                	srli	a2,a2,0x20
 328:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 32c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 330:	0785                	addi	a5,a5,1
 332:	fee79de3          	bne	a5,a4,32c <memset+0x12>
    }
    return dst;
}
 336:	6422                	ld	s0,8(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <strchr>:

char *
strchr(const char *s, char c)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	addi	s0,sp,16
    for (; *s; s++)
 342:	00054783          	lbu	a5,0(a0)
 346:	cb99                	beqz	a5,35c <strchr+0x20>
        if (*s == c)
 348:	00f58763          	beq	a1,a5,356 <strchr+0x1a>
    for (; *s; s++)
 34c:	0505                	addi	a0,a0,1
 34e:	00054783          	lbu	a5,0(a0)
 352:	fbfd                	bnez	a5,348 <strchr+0xc>
            return (char *)s;
    return 0;
 354:	4501                	li	a0,0
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret
    return 0;
 35c:	4501                	li	a0,0
 35e:	bfe5                	j	356 <strchr+0x1a>

0000000000000360 <gets>:

char *
gets(char *buf, int max)
{
 360:	711d                	addi	sp,sp,-96
 362:	ec86                	sd	ra,88(sp)
 364:	e8a2                	sd	s0,80(sp)
 366:	e4a6                	sd	s1,72(sp)
 368:	e0ca                	sd	s2,64(sp)
 36a:	fc4e                	sd	s3,56(sp)
 36c:	f852                	sd	s4,48(sp)
 36e:	f456                	sd	s5,40(sp)
 370:	f05a                	sd	s6,32(sp)
 372:	ec5e                	sd	s7,24(sp)
 374:	1080                	addi	s0,sp,96
 376:	8baa                	mv	s7,a0
 378:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 37a:	892a                	mv	s2,a0
 37c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 37e:	4aa9                	li	s5,10
 380:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 382:	89a6                	mv	s3,s1
 384:	2485                	addiw	s1,s1,1
 386:	0344d863          	bge	s1,s4,3b6 <gets+0x56>
        cc = read(0, &c, 1);
 38a:	4605                	li	a2,1
 38c:	faf40593          	addi	a1,s0,-81
 390:	4501                	li	a0,0
 392:	00000097          	auipc	ra,0x0
 396:	19a080e7          	jalr	410(ra) # 52c <read>
        if (cc < 1)
 39a:	00a05e63          	blez	a0,3b6 <gets+0x56>
        buf[i++] = c;
 39e:	faf44783          	lbu	a5,-81(s0)
 3a2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3a6:	01578763          	beq	a5,s5,3b4 <gets+0x54>
 3aa:	0905                	addi	s2,s2,1
 3ac:	fd679be3          	bne	a5,s6,382 <gets+0x22>
    for (i = 0; i + 1 < max;)
 3b0:	89a6                	mv	s3,s1
 3b2:	a011                	j	3b6 <gets+0x56>
 3b4:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3b6:	99de                	add	s3,s3,s7
 3b8:	00098023          	sb	zero,0(s3)
    return buf;
}
 3bc:	855e                	mv	a0,s7
 3be:	60e6                	ld	ra,88(sp)
 3c0:	6446                	ld	s0,80(sp)
 3c2:	64a6                	ld	s1,72(sp)
 3c4:	6906                	ld	s2,64(sp)
 3c6:	79e2                	ld	s3,56(sp)
 3c8:	7a42                	ld	s4,48(sp)
 3ca:	7aa2                	ld	s5,40(sp)
 3cc:	7b02                	ld	s6,32(sp)
 3ce:	6be2                	ld	s7,24(sp)
 3d0:	6125                	addi	sp,sp,96
 3d2:	8082                	ret

00000000000003d4 <stat>:

int stat(const char *n, struct stat *st)
{
 3d4:	1101                	addi	sp,sp,-32
 3d6:	ec06                	sd	ra,24(sp)
 3d8:	e822                	sd	s0,16(sp)
 3da:	e426                	sd	s1,8(sp)
 3dc:	e04a                	sd	s2,0(sp)
 3de:	1000                	addi	s0,sp,32
 3e0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3e2:	4581                	li	a1,0
 3e4:	00000097          	auipc	ra,0x0
 3e8:	170080e7          	jalr	368(ra) # 554 <open>
    if (fd < 0)
 3ec:	02054563          	bltz	a0,416 <stat+0x42>
 3f0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3f2:	85ca                	mv	a1,s2
 3f4:	00000097          	auipc	ra,0x0
 3f8:	178080e7          	jalr	376(ra) # 56c <fstat>
 3fc:	892a                	mv	s2,a0
    close(fd);
 3fe:	8526                	mv	a0,s1
 400:	00000097          	auipc	ra,0x0
 404:	13c080e7          	jalr	316(ra) # 53c <close>
    return r;
}
 408:	854a                	mv	a0,s2
 40a:	60e2                	ld	ra,24(sp)
 40c:	6442                	ld	s0,16(sp)
 40e:	64a2                	ld	s1,8(sp)
 410:	6902                	ld	s2,0(sp)
 412:	6105                	addi	sp,sp,32
 414:	8082                	ret
        return -1;
 416:	597d                	li	s2,-1
 418:	bfc5                	j	408 <stat+0x34>

000000000000041a <atoi>:

int atoi(const char *s)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 420:	00054683          	lbu	a3,0(a0)
 424:	fd06879b          	addiw	a5,a3,-48
 428:	0ff7f793          	zext.b	a5,a5
 42c:	4625                	li	a2,9
 42e:	02f66863          	bltu	a2,a5,45e <atoi+0x44>
 432:	872a                	mv	a4,a0
    n = 0;
 434:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 436:	0705                	addi	a4,a4,1
 438:	0025179b          	slliw	a5,a0,0x2
 43c:	9fa9                	addw	a5,a5,a0
 43e:	0017979b          	slliw	a5,a5,0x1
 442:	9fb5                	addw	a5,a5,a3
 444:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 448:	00074683          	lbu	a3,0(a4)
 44c:	fd06879b          	addiw	a5,a3,-48
 450:	0ff7f793          	zext.b	a5,a5
 454:	fef671e3          	bgeu	a2,a5,436 <atoi+0x1c>
    return n;
}
 458:	6422                	ld	s0,8(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret
    n = 0;
 45e:	4501                	li	a0,0
 460:	bfe5                	j	458 <atoi+0x3e>

0000000000000462 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 462:	1141                	addi	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 468:	02b57463          	bgeu	a0,a1,490 <memmove+0x2e>
    {
        while (n-- > 0)
 46c:	00c05f63          	blez	a2,48a <memmove+0x28>
 470:	1602                	slli	a2,a2,0x20
 472:	9201                	srli	a2,a2,0x20
 474:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 478:	872a                	mv	a4,a0
            *dst++ = *src++;
 47a:	0585                	addi	a1,a1,1
 47c:	0705                	addi	a4,a4,1
 47e:	fff5c683          	lbu	a3,-1(a1)
 482:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 486:	fee79ae3          	bne	a5,a4,47a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret
        dst += n;
 490:	00c50733          	add	a4,a0,a2
        src += n;
 494:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 496:	fec05ae3          	blez	a2,48a <memmove+0x28>
 49a:	fff6079b          	addiw	a5,a2,-1
 49e:	1782                	slli	a5,a5,0x20
 4a0:	9381                	srli	a5,a5,0x20
 4a2:	fff7c793          	not	a5,a5
 4a6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4a8:	15fd                	addi	a1,a1,-1
 4aa:	177d                	addi	a4,a4,-1
 4ac:	0005c683          	lbu	a3,0(a1)
 4b0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4b4:	fee79ae3          	bne	a5,a4,4a8 <memmove+0x46>
 4b8:	bfc9                	j	48a <memmove+0x28>

00000000000004ba <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4c0:	ca05                	beqz	a2,4f0 <memcmp+0x36>
 4c2:	fff6069b          	addiw	a3,a2,-1
 4c6:	1682                	slli	a3,a3,0x20
 4c8:	9281                	srli	a3,a3,0x20
 4ca:	0685                	addi	a3,a3,1
 4cc:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4ce:	00054783          	lbu	a5,0(a0)
 4d2:	0005c703          	lbu	a4,0(a1)
 4d6:	00e79863          	bne	a5,a4,4e6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4da:	0505                	addi	a0,a0,1
        p2++;
 4dc:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4de:	fed518e3          	bne	a0,a3,4ce <memcmp+0x14>
    }
    return 0;
 4e2:	4501                	li	a0,0
 4e4:	a019                	j	4ea <memcmp+0x30>
            return *p1 - *p2;
 4e6:	40e7853b          	subw	a0,a5,a4
}
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
    return 0;
 4f0:	4501                	li	a0,0
 4f2:	bfe5                	j	4ea <memcmp+0x30>

00000000000004f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e406                	sd	ra,8(sp)
 4f8:	e022                	sd	s0,0(sp)
 4fa:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4fc:	00000097          	auipc	ra,0x0
 500:	f66080e7          	jalr	-154(ra) # 462 <memmove>
}
 504:	60a2                	ld	ra,8(sp)
 506:	6402                	ld	s0,0(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret

000000000000050c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 50c:	4885                	li	a7,1
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <exit>:
.global exit
exit:
 li a7, SYS_exit
 514:	4889                	li	a7,2
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <wait>:
.global wait
wait:
 li a7, SYS_wait
 51c:	488d                	li	a7,3
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 524:	4891                	li	a7,4
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <read>:
.global read
read:
 li a7, SYS_read
 52c:	4895                	li	a7,5
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <write>:
.global write
write:
 li a7, SYS_write
 534:	48c1                	li	a7,16
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <close>:
.global close
close:
 li a7, SYS_close
 53c:	48d5                	li	a7,21
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <kill>:
.global kill
kill:
 li a7, SYS_kill
 544:	4899                	li	a7,6
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exec>:
.global exec
exec:
 li a7, SYS_exec
 54c:	489d                	li	a7,7
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <open>:
.global open
open:
 li a7, SYS_open
 554:	48bd                	li	a7,15
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 55c:	48c5                	li	a7,17
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 564:	48c9                	li	a7,18
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 56c:	48a1                	li	a7,8
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <link>:
.global link
link:
 li a7, SYS_link
 574:	48cd                	li	a7,19
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 57c:	48d1                	li	a7,20
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 584:	48a5                	li	a7,9
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <dup>:
.global dup
dup:
 li a7, SYS_dup
 58c:	48a9                	li	a7,10
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 594:	48ad                	li	a7,11
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 59c:	48b1                	li	a7,12
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a4:	48b5                	li	a7,13
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ac:	48b9                	li	a7,14
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <ps>:
.global ps
ps:
 li a7, SYS_ps
 5b4:	48d9                	li	a7,22
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5bc:	48dd                	li	a7,23
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5c4:	48e1                	li	a7,24
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	1000                	addi	s0,sp,32
 5d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d8:	4605                	li	a2,1
 5da:	fef40593          	addi	a1,s0,-17
 5de:	00000097          	auipc	ra,0x0
 5e2:	f56080e7          	jalr	-170(ra) # 534 <write>
}
 5e6:	60e2                	ld	ra,24(sp)
 5e8:	6442                	ld	s0,16(sp)
 5ea:	6105                	addi	sp,sp,32
 5ec:	8082                	ret

00000000000005ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ee:	7139                	addi	sp,sp,-64
 5f0:	fc06                	sd	ra,56(sp)
 5f2:	f822                	sd	s0,48(sp)
 5f4:	f426                	sd	s1,40(sp)
 5f6:	f04a                	sd	s2,32(sp)
 5f8:	ec4e                	sd	s3,24(sp)
 5fa:	0080                	addi	s0,sp,64
 5fc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fe:	c299                	beqz	a3,604 <printint+0x16>
 600:	0805c963          	bltz	a1,692 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 604:	2581                	sext.w	a1,a1
  neg = 0;
 606:	4881                	li	a7,0
 608:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 60c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 60e:	2601                	sext.w	a2,a2
 610:	00000517          	auipc	a0,0x0
 614:	4f050513          	addi	a0,a0,1264 # b00 <digits>
 618:	883a                	mv	a6,a4
 61a:	2705                	addiw	a4,a4,1
 61c:	02c5f7bb          	remuw	a5,a1,a2
 620:	1782                	slli	a5,a5,0x20
 622:	9381                	srli	a5,a5,0x20
 624:	97aa                	add	a5,a5,a0
 626:	0007c783          	lbu	a5,0(a5)
 62a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 62e:	0005879b          	sext.w	a5,a1
 632:	02c5d5bb          	divuw	a1,a1,a2
 636:	0685                	addi	a3,a3,1
 638:	fec7f0e3          	bgeu	a5,a2,618 <printint+0x2a>
  if(neg)
 63c:	00088c63          	beqz	a7,654 <printint+0x66>
    buf[i++] = '-';
 640:	fd070793          	addi	a5,a4,-48
 644:	00878733          	add	a4,a5,s0
 648:	02d00793          	li	a5,45
 64c:	fef70823          	sb	a5,-16(a4)
 650:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 654:	02e05863          	blez	a4,684 <printint+0x96>
 658:	fc040793          	addi	a5,s0,-64
 65c:	00e78933          	add	s2,a5,a4
 660:	fff78993          	addi	s3,a5,-1
 664:	99ba                	add	s3,s3,a4
 666:	377d                	addiw	a4,a4,-1
 668:	1702                	slli	a4,a4,0x20
 66a:	9301                	srli	a4,a4,0x20
 66c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 670:	fff94583          	lbu	a1,-1(s2)
 674:	8526                	mv	a0,s1
 676:	00000097          	auipc	ra,0x0
 67a:	f56080e7          	jalr	-170(ra) # 5cc <putc>
  while(--i >= 0)
 67e:	197d                	addi	s2,s2,-1
 680:	ff3918e3          	bne	s2,s3,670 <printint+0x82>
}
 684:	70e2                	ld	ra,56(sp)
 686:	7442                	ld	s0,48(sp)
 688:	74a2                	ld	s1,40(sp)
 68a:	7902                	ld	s2,32(sp)
 68c:	69e2                	ld	s3,24(sp)
 68e:	6121                	addi	sp,sp,64
 690:	8082                	ret
    x = -xx;
 692:	40b005bb          	negw	a1,a1
    neg = 1;
 696:	4885                	li	a7,1
    x = -xx;
 698:	bf85                	j	608 <printint+0x1a>

000000000000069a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 69a:	715d                	addi	sp,sp,-80
 69c:	e486                	sd	ra,72(sp)
 69e:	e0a2                	sd	s0,64(sp)
 6a0:	fc26                	sd	s1,56(sp)
 6a2:	f84a                	sd	s2,48(sp)
 6a4:	f44e                	sd	s3,40(sp)
 6a6:	f052                	sd	s4,32(sp)
 6a8:	ec56                	sd	s5,24(sp)
 6aa:	e85a                	sd	s6,16(sp)
 6ac:	e45e                	sd	s7,8(sp)
 6ae:	e062                	sd	s8,0(sp)
 6b0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6b2:	0005c903          	lbu	s2,0(a1)
 6b6:	18090c63          	beqz	s2,84e <vprintf+0x1b4>
 6ba:	8aaa                	mv	s5,a0
 6bc:	8bb2                	mv	s7,a2
 6be:	00158493          	addi	s1,a1,1
  state = 0;
 6c2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c4:	02500a13          	li	s4,37
 6c8:	4b55                	li	s6,21
 6ca:	a839                	j	6e8 <vprintf+0x4e>
        putc(fd, c);
 6cc:	85ca                	mv	a1,s2
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	efc080e7          	jalr	-260(ra) # 5cc <putc>
 6d8:	a019                	j	6de <vprintf+0x44>
    } else if(state == '%'){
 6da:	01498d63          	beq	s3,s4,6f4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6de:	0485                	addi	s1,s1,1
 6e0:	fff4c903          	lbu	s2,-1(s1)
 6e4:	16090563          	beqz	s2,84e <vprintf+0x1b4>
    if(state == 0){
 6e8:	fe0999e3          	bnez	s3,6da <vprintf+0x40>
      if(c == '%'){
 6ec:	ff4910e3          	bne	s2,s4,6cc <vprintf+0x32>
        state = '%';
 6f0:	89d2                	mv	s3,s4
 6f2:	b7f5                	j	6de <vprintf+0x44>
      if(c == 'd'){
 6f4:	13490263          	beq	s2,s4,818 <vprintf+0x17e>
 6f8:	f9d9079b          	addiw	a5,s2,-99
 6fc:	0ff7f793          	zext.b	a5,a5
 700:	12fb6563          	bltu	s6,a5,82a <vprintf+0x190>
 704:	f9d9079b          	addiw	a5,s2,-99
 708:	0ff7f713          	zext.b	a4,a5
 70c:	10eb6f63          	bltu	s6,a4,82a <vprintf+0x190>
 710:	00271793          	slli	a5,a4,0x2
 714:	00000717          	auipc	a4,0x0
 718:	39470713          	addi	a4,a4,916 # aa8 <malloc+0x15c>
 71c:	97ba                	add	a5,a5,a4
 71e:	439c                	lw	a5,0(a5)
 720:	97ba                	add	a5,a5,a4
 722:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 724:	008b8913          	addi	s2,s7,8
 728:	4685                	li	a3,1
 72a:	4629                	li	a2,10
 72c:	000ba583          	lw	a1,0(s7)
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	ebc080e7          	jalr	-324(ra) # 5ee <printint>
 73a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 73c:	4981                	li	s3,0
 73e:	b745                	j	6de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 740:	008b8913          	addi	s2,s7,8
 744:	4681                	li	a3,0
 746:	4629                	li	a2,10
 748:	000ba583          	lw	a1,0(s7)
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	ea0080e7          	jalr	-352(ra) # 5ee <printint>
 756:	8bca                	mv	s7,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	b751                	j	6de <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 75c:	008b8913          	addi	s2,s7,8
 760:	4681                	li	a3,0
 762:	4641                	li	a2,16
 764:	000ba583          	lw	a1,0(s7)
 768:	8556                	mv	a0,s5
 76a:	00000097          	auipc	ra,0x0
 76e:	e84080e7          	jalr	-380(ra) # 5ee <printint>
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
 776:	b7a5                	j	6de <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 778:	008b8c13          	addi	s8,s7,8
 77c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 780:	03000593          	li	a1,48
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	e46080e7          	jalr	-442(ra) # 5cc <putc>
  putc(fd, 'x');
 78e:	07800593          	li	a1,120
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	e38080e7          	jalr	-456(ra) # 5cc <putc>
 79c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79e:	00000b97          	auipc	s7,0x0
 7a2:	362b8b93          	addi	s7,s7,866 # b00 <digits>
 7a6:	03c9d793          	srli	a5,s3,0x3c
 7aa:	97de                	add	a5,a5,s7
 7ac:	0007c583          	lbu	a1,0(a5)
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	e1a080e7          	jalr	-486(ra) # 5cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	0992                	slli	s3,s3,0x4
 7bc:	397d                	addiw	s2,s2,-1
 7be:	fe0914e3          	bnez	s2,7a6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7c2:	8be2                	mv	s7,s8
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bf21                	j	6de <vprintf+0x44>
        s = va_arg(ap, char*);
 7c8:	008b8993          	addi	s3,s7,8
 7cc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7d0:	02090163          	beqz	s2,7f2 <vprintf+0x158>
        while(*s != 0){
 7d4:	00094583          	lbu	a1,0(s2)
 7d8:	c9a5                	beqz	a1,848 <vprintf+0x1ae>
          putc(fd, *s);
 7da:	8556                	mv	a0,s5
 7dc:	00000097          	auipc	ra,0x0
 7e0:	df0080e7          	jalr	-528(ra) # 5cc <putc>
          s++;
 7e4:	0905                	addi	s2,s2,1
        while(*s != 0){
 7e6:	00094583          	lbu	a1,0(s2)
 7ea:	f9e5                	bnez	a1,7da <vprintf+0x140>
        s = va_arg(ap, char*);
 7ec:	8bce                	mv	s7,s3
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b5fd                	j	6de <vprintf+0x44>
          s = "(null)";
 7f2:	00000917          	auipc	s2,0x0
 7f6:	2ae90913          	addi	s2,s2,686 # aa0 <malloc+0x154>
        while(*s != 0){
 7fa:	02800593          	li	a1,40
 7fe:	bff1                	j	7da <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 800:	008b8913          	addi	s2,s7,8
 804:	000bc583          	lbu	a1,0(s7)
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	dc2080e7          	jalr	-574(ra) # 5cc <putc>
 812:	8bca                	mv	s7,s2
      state = 0;
 814:	4981                	li	s3,0
 816:	b5e1                	j	6de <vprintf+0x44>
        putc(fd, c);
 818:	02500593          	li	a1,37
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	dae080e7          	jalr	-594(ra) # 5cc <putc>
      state = 0;
 826:	4981                	li	s3,0
 828:	bd5d                	j	6de <vprintf+0x44>
        putc(fd, '%');
 82a:	02500593          	li	a1,37
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	d9c080e7          	jalr	-612(ra) # 5cc <putc>
        putc(fd, c);
 838:	85ca                	mv	a1,s2
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	d90080e7          	jalr	-624(ra) # 5cc <putc>
      state = 0;
 844:	4981                	li	s3,0
 846:	bd61                	j	6de <vprintf+0x44>
        s = va_arg(ap, char*);
 848:	8bce                	mv	s7,s3
      state = 0;
 84a:	4981                	li	s3,0
 84c:	bd49                	j	6de <vprintf+0x44>
    }
  }
}
 84e:	60a6                	ld	ra,72(sp)
 850:	6406                	ld	s0,64(sp)
 852:	74e2                	ld	s1,56(sp)
 854:	7942                	ld	s2,48(sp)
 856:	79a2                	ld	s3,40(sp)
 858:	7a02                	ld	s4,32(sp)
 85a:	6ae2                	ld	s5,24(sp)
 85c:	6b42                	ld	s6,16(sp)
 85e:	6ba2                	ld	s7,8(sp)
 860:	6c02                	ld	s8,0(sp)
 862:	6161                	addi	sp,sp,80
 864:	8082                	ret

0000000000000866 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 866:	715d                	addi	sp,sp,-80
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e010                	sd	a2,0(s0)
 870:	e414                	sd	a3,8(s0)
 872:	e818                	sd	a4,16(s0)
 874:	ec1c                	sd	a5,24(s0)
 876:	03043023          	sd	a6,32(s0)
 87a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 882:	8622                	mv	a2,s0
 884:	00000097          	auipc	ra,0x0
 888:	e16080e7          	jalr	-490(ra) # 69a <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6161                	addi	sp,sp,80
 892:	8082                	ret

0000000000000894 <printf>:

void
printf(const char *fmt, ...)
{
 894:	711d                	addi	sp,sp,-96
 896:	ec06                	sd	ra,24(sp)
 898:	e822                	sd	s0,16(sp)
 89a:	1000                	addi	s0,sp,32
 89c:	e40c                	sd	a1,8(s0)
 89e:	e810                	sd	a2,16(s0)
 8a0:	ec14                	sd	a3,24(s0)
 8a2:	f018                	sd	a4,32(s0)
 8a4:	f41c                	sd	a5,40(s0)
 8a6:	03043823          	sd	a6,48(s0)
 8aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ae:	00840613          	addi	a2,s0,8
 8b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b6:	85aa                	mv	a1,a0
 8b8:	4505                	li	a0,1
 8ba:	00000097          	auipc	ra,0x0
 8be:	de0080e7          	jalr	-544(ra) # 69a <vprintf>
}
 8c2:	60e2                	ld	ra,24(sp)
 8c4:	6442                	ld	s0,16(sp)
 8c6:	6125                	addi	sp,sp,96
 8c8:	8082                	ret

00000000000008ca <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8ca:	1141                	addi	sp,sp,-16
 8cc:	e422                	sd	s0,8(sp)
 8ce:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8d0:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	00000797          	auipc	a5,0x0
 8d8:	7347b783          	ld	a5,1844(a5) # 1008 <freep>
 8dc:	a02d                	j	906 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8de:	4618                	lw	a4,8(a2)
 8e0:	9f2d                	addw	a4,a4,a1
 8e2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	6398                	ld	a4,0(a5)
 8e8:	6310                	ld	a2,0(a4)
 8ea:	a83d                	j	928 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8ec:	ff852703          	lw	a4,-8(a0)
 8f0:	9f31                	addw	a4,a4,a2
 8f2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8f4:	ff053683          	ld	a3,-16(a0)
 8f8:	a091                	j	93c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fa:	6398                	ld	a4,0(a5)
 8fc:	00e7e463          	bltu	a5,a4,904 <free+0x3a>
 900:	00e6ea63          	bltu	a3,a4,914 <free+0x4a>
{
 904:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 906:	fed7fae3          	bgeu	a5,a3,8fa <free+0x30>
 90a:	6398                	ld	a4,0(a5)
 90c:	00e6e463          	bltu	a3,a4,914 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 910:	fee7eae3          	bltu	a5,a4,904 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 914:	ff852583          	lw	a1,-8(a0)
 918:	6390                	ld	a2,0(a5)
 91a:	02059813          	slli	a6,a1,0x20
 91e:	01c85713          	srli	a4,a6,0x1c
 922:	9736                	add	a4,a4,a3
 924:	fae60de3          	beq	a2,a4,8de <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 928:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 92c:	4790                	lw	a2,8(a5)
 92e:	02061593          	slli	a1,a2,0x20
 932:	01c5d713          	srli	a4,a1,0x1c
 936:	973e                	add	a4,a4,a5
 938:	fae68ae3          	beq	a3,a4,8ec <free+0x22>
        p->s.ptr = bp->s.ptr;
 93c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 93e:	00000717          	auipc	a4,0x0
 942:	6cf73523          	sd	a5,1738(a4) # 1008 <freep>
}
 946:	6422                	ld	s0,8(sp)
 948:	0141                	addi	sp,sp,16
 94a:	8082                	ret

000000000000094c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 94c:	7139                	addi	sp,sp,-64
 94e:	fc06                	sd	ra,56(sp)
 950:	f822                	sd	s0,48(sp)
 952:	f426                	sd	s1,40(sp)
 954:	f04a                	sd	s2,32(sp)
 956:	ec4e                	sd	s3,24(sp)
 958:	e852                	sd	s4,16(sp)
 95a:	e456                	sd	s5,8(sp)
 95c:	e05a                	sd	s6,0(sp)
 95e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 960:	02051493          	slli	s1,a0,0x20
 964:	9081                	srli	s1,s1,0x20
 966:	04bd                	addi	s1,s1,15
 968:	8091                	srli	s1,s1,0x4
 96a:	0014899b          	addiw	s3,s1,1
 96e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 970:	00000517          	auipc	a0,0x0
 974:	69853503          	ld	a0,1688(a0) # 1008 <freep>
 978:	c515                	beqz	a0,9a4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 97a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 97c:	4798                	lw	a4,8(a5)
 97e:	02977f63          	bgeu	a4,s1,9bc <malloc+0x70>
    if (nu < 4096)
 982:	8a4e                	mv	s4,s3
 984:	0009871b          	sext.w	a4,s3
 988:	6685                	lui	a3,0x1
 98a:	00d77363          	bgeu	a4,a3,990 <malloc+0x44>
 98e:	6a05                	lui	s4,0x1
 990:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 994:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 998:	00000917          	auipc	s2,0x0
 99c:	67090913          	addi	s2,s2,1648 # 1008 <freep>
    if (p == (char *)-1)
 9a0:	5afd                	li	s5,-1
 9a2:	a895                	j	a16 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9a4:	00000797          	auipc	a5,0x0
 9a8:	66c78793          	addi	a5,a5,1644 # 1010 <base>
 9ac:	00000717          	auipc	a4,0x0
 9b0:	64f73e23          	sd	a5,1628(a4) # 1008 <freep>
 9b4:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9b6:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9ba:	b7e1                	j	982 <malloc+0x36>
            if (p->s.size == nunits)
 9bc:	02e48c63          	beq	s1,a4,9f4 <malloc+0xa8>
                p->s.size -= nunits;
 9c0:	4137073b          	subw	a4,a4,s3
 9c4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9c6:	02071693          	slli	a3,a4,0x20
 9ca:	01c6d713          	srli	a4,a3,0x1c
 9ce:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9d0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9d4:	00000717          	auipc	a4,0x0
 9d8:	62a73a23          	sd	a0,1588(a4) # 1008 <freep>
            return (void *)(p + 1);
 9dc:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9e0:	70e2                	ld	ra,56(sp)
 9e2:	7442                	ld	s0,48(sp)
 9e4:	74a2                	ld	s1,40(sp)
 9e6:	7902                	ld	s2,32(sp)
 9e8:	69e2                	ld	s3,24(sp)
 9ea:	6a42                	ld	s4,16(sp)
 9ec:	6aa2                	ld	s5,8(sp)
 9ee:	6b02                	ld	s6,0(sp)
 9f0:	6121                	addi	sp,sp,64
 9f2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9f4:	6398                	ld	a4,0(a5)
 9f6:	e118                	sd	a4,0(a0)
 9f8:	bff1                	j	9d4 <malloc+0x88>
    hp->s.size = nu;
 9fa:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9fe:	0541                	addi	a0,a0,16
 a00:	00000097          	auipc	ra,0x0
 a04:	eca080e7          	jalr	-310(ra) # 8ca <free>
    return freep;
 a08:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a0c:	d971                	beqz	a0,9e0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a0e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a10:	4798                	lw	a4,8(a5)
 a12:	fa9775e3          	bgeu	a4,s1,9bc <malloc+0x70>
        if (p == freep)
 a16:	00093703          	ld	a4,0(s2)
 a1a:	853e                	mv	a0,a5
 a1c:	fef719e3          	bne	a4,a5,a0e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a20:	8552                	mv	a0,s4
 a22:	00000097          	auipc	ra,0x0
 a26:	b7a080e7          	jalr	-1158(ra) # 59c <sbrk>
    if (p == (char *)-1)
 a2a:	fd5518e3          	bne	a0,s5,9fa <malloc+0xae>
                return 0;
 a2e:	4501                	li	a0,0
 a30:	bf45                	j	9e0 <malloc+0x94>
