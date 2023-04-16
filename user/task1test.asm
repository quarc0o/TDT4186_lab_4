
user/_task1test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <hello_world>:
#include "kernel/types.h"
#include "user.h"

void *hello_world(void *arg)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    printf("Hello World\n");
   8:	00001517          	auipc	a0,0x1
   c:	a2850513          	addi	a0,a0,-1496 # a30 <malloc+0xec>
  10:	00001097          	auipc	ra,0x1
  14:	87c080e7          	jalr	-1924(ra) # 88c <printf>
    return 0; // will be ignored, but just to make the compiler happy
}
  18:	4501                	li	a0,0
  1a:	60a2                	ld	ra,8(sp)
  1c:	6402                	ld	s0,0(sp)
  1e:	0141                	addi	sp,sp,16
  20:	8082                	ret

0000000000000022 <main>:

void main()
{
  22:	1101                	addi	sp,sp,-32
  24:	ec06                	sd	ra,24(sp)
  26:	e822                	sd	s0,16(sp)
  28:	1000                	addi	s0,sp,32
    // t not initialized
    struct thread *t;

    // passing &t (taking the address of the pointer value)
    tcreate(&t, 0, &hello_world, 0);
  2a:	4681                	li	a3,0
  2c:	00000617          	auipc	a2,0x0
  30:	fd460613          	addi	a2,a2,-44 # 0 <hello_world>
  34:	4581                	li	a1,0
  36:	fe840513          	addi	a0,s0,-24
  3a:	00000097          	auipc	ra,0x0
  3e:	154080e7          	jalr	340(ra) # 18e <tcreate>
    // Now, t points to an initialized thread struct

    tyield();
  42:	00000097          	auipc	ra,0x0
  46:	19a080e7          	jalr	410(ra) # 1dc <tyield>
  4a:	60e2                	ld	ra,24(sp)
  4c:	6442                	ld	s0,16(sp)
  4e:	6105                	addi	sp,sp,32
  50:	8082                	ret

0000000000000052 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  52:	1141                	addi	sp,sp,-16
  54:	e422                	sd	s0,8(sp)
  56:	0800                	addi	s0,sp,16
    lk->name = name;
  58:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  5a:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  5e:	57fd                	li	a5,-1
  60:	00f50823          	sb	a5,16(a0)
}
  64:	6422                	ld	s0,8(sp)
  66:	0141                	addi	sp,sp,16
  68:	8082                	ret

000000000000006a <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  6a:	00054783          	lbu	a5,0(a0)
  6e:	e399                	bnez	a5,74 <holding+0xa>
  70:	4501                	li	a0,0
}
  72:	8082                	ret
{
  74:	1101                	addi	sp,sp,-32
  76:	ec06                	sd	ra,24(sp)
  78:	e822                	sd	s0,16(sp)
  7a:	e426                	sd	s1,8(sp)
  7c:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  7e:	01054483          	lbu	s1,16(a0)
  82:	00000097          	auipc	ra,0x0
  86:	172080e7          	jalr	370(ra) # 1f4 <twhoami>
  8a:	2501                	sext.w	a0,a0
  8c:	40a48533          	sub	a0,s1,a0
  90:	00153513          	seqz	a0,a0
}
  94:	60e2                	ld	ra,24(sp)
  96:	6442                	ld	s0,16(sp)
  98:	64a2                	ld	s1,8(sp)
  9a:	6105                	addi	sp,sp,32
  9c:	8082                	ret

000000000000009e <acquire>:

void acquire(struct lock *lk)
{
  9e:	7179                	addi	sp,sp,-48
  a0:	f406                	sd	ra,40(sp)
  a2:	f022                	sd	s0,32(sp)
  a4:	ec26                	sd	s1,24(sp)
  a6:	e84a                	sd	s2,16(sp)
  a8:	e44e                	sd	s3,8(sp)
  aa:	e052                	sd	s4,0(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	8a2a                	mv	s4,a0
    if (holding(lk))
  b0:	00000097          	auipc	ra,0x0
  b4:	fba080e7          	jalr	-70(ra) # 6a <holding>
  b8:	e919                	bnez	a0,ce <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  ba:	ffca7493          	andi	s1,s4,-4
  be:	003a7913          	andi	s2,s4,3
  c2:	0039191b          	slliw	s2,s2,0x3
  c6:	4985                	li	s3,1
  c8:	012999bb          	sllw	s3,s3,s2
  cc:	a015                	j	f0 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  ce:	00001517          	auipc	a0,0x1
  d2:	97250513          	addi	a0,a0,-1678 # a40 <malloc+0xfc>
  d6:	00000097          	auipc	ra,0x0
  da:	7b6080e7          	jalr	1974(ra) # 88c <printf>
        exit(-1);
  de:	557d                	li	a0,-1
  e0:	00000097          	auipc	ra,0x0
  e4:	42c080e7          	jalr	1068(ra) # 50c <exit>
    {
        // give up the cpu for other threads
        tyield();
  e8:	00000097          	auipc	ra,0x0
  ec:	0f4080e7          	jalr	244(ra) # 1dc <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f0:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  f4:	0127d7bb          	srlw	a5,a5,s2
  f8:	0ff7f793          	zext.b	a5,a5
  fc:	f7f5                	bnez	a5,e8 <acquire+0x4a>
    }

    __sync_synchronize();
  fe:	0ff0000f          	fence

    lk->tid = twhoami();
 102:	00000097          	auipc	ra,0x0
 106:	0f2080e7          	jalr	242(ra) # 1f4 <twhoami>
 10a:	00aa0823          	sb	a0,16(s4)
}
 10e:	70a2                	ld	ra,40(sp)
 110:	7402                	ld	s0,32(sp)
 112:	64e2                	ld	s1,24(sp)
 114:	6942                	ld	s2,16(sp)
 116:	69a2                	ld	s3,8(sp)
 118:	6a02                	ld	s4,0(sp)
 11a:	6145                	addi	sp,sp,48
 11c:	8082                	ret

000000000000011e <release>:

void release(struct lock *lk)
{
 11e:	1101                	addi	sp,sp,-32
 120:	ec06                	sd	ra,24(sp)
 122:	e822                	sd	s0,16(sp)
 124:	e426                	sd	s1,8(sp)
 126:	1000                	addi	s0,sp,32
 128:	84aa                	mv	s1,a0
    if (!holding(lk))
 12a:	00000097          	auipc	ra,0x0
 12e:	f40080e7          	jalr	-192(ra) # 6a <holding>
 132:	c11d                	beqz	a0,158 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 134:	57fd                	li	a5,-1
 136:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 13a:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 13e:	0ff0000f          	fence
 142:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 146:	00000097          	auipc	ra,0x0
 14a:	096080e7          	jalr	150(ra) # 1dc <tyield>
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret
        printf("releasing lock we are not holding");
 158:	00001517          	auipc	a0,0x1
 15c:	91050513          	addi	a0,a0,-1776 # a68 <malloc+0x124>
 160:	00000097          	auipc	ra,0x0
 164:	72c080e7          	jalr	1836(ra) # 88c <printf>
        exit(-1);
 168:	557d                	li	a0,-1
 16a:	00000097          	auipc	ra,0x0
 16e:	3a2080e7          	jalr	930(ra) # 50c <exit>

0000000000000172 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 172:	1141                	addi	sp,sp,-16
 174:	e422                	sd	s0,8(sp)
 176:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 178:	00001717          	auipc	a4,0x1
 17c:	e8873703          	ld	a4,-376(a4) # 1000 <current_thread>
 180:	47c1                	li	a5,16
 182:	c319                	beqz	a4,188 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 184:	37fd                	addiw	a5,a5,-1
 186:	fff5                	bnez	a5,182 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 18e:	7179                	addi	sp,sp,-48
 190:	f406                	sd	ra,40(sp)
 192:	f022                	sd	s0,32(sp)
 194:	ec26                	sd	s1,24(sp)
 196:	e84a                	sd	s2,16(sp)
 198:	e44e                	sd	s3,8(sp)
 19a:	1800                	addi	s0,sp,48
 19c:	84aa                	mv	s1,a0
 19e:	89b2                	mv	s3,a2
 1a0:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1a2:	09000513          	li	a0,144
 1a6:	00000097          	auipc	ra,0x0
 1aa:	79e080e7          	jalr	1950(ra) # 944 <malloc>
 1ae:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1b0:	478d                	li	a5,3
 1b2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1b4:	609c                	ld	a5,0(s1)
 1b6:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1ba:	609c                	ld	a5,0(s1)
 1bc:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1c0:	70a2                	ld	ra,40(sp)
 1c2:	7402                	ld	s0,32(sp)
 1c4:	64e2                	ld	s1,24(sp)
 1c6:	6942                	ld	s2,16(sp)
 1c8:	69a2                	ld	s3,8(sp)
 1ca:	6145                	addi	sp,sp,48
 1cc:	8082                	ret

00000000000001ce <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1d4:	4501                	li	a0,0
 1d6:	6422                	ld	s0,8(sp)
 1d8:	0141                	addi	sp,sp,16
 1da:	8082                	ret

00000000000001dc <tyield>:

void tyield()
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1e2:	00001797          	auipc	a5,0x1
 1e6:	e1e7b783          	ld	a5,-482(a5) # 1000 <current_thread>
 1ea:	470d                	li	a4,3
 1ec:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1ee:	6422                	ld	s0,8(sp)
 1f0:	0141                	addi	sp,sp,16
 1f2:	8082                	ret

00000000000001f4 <twhoami>:

uint8 twhoami()
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 1fa:	4501                	li	a0,0
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <tswtch>:
 202:	00153023          	sd	ra,0(a0)
 206:	00253423          	sd	sp,8(a0)
 20a:	e900                	sd	s0,16(a0)
 20c:	ed04                	sd	s1,24(a0)
 20e:	03253023          	sd	s2,32(a0)
 212:	03353423          	sd	s3,40(a0)
 216:	03453823          	sd	s4,48(a0)
 21a:	03553c23          	sd	s5,56(a0)
 21e:	05653023          	sd	s6,64(a0)
 222:	05753423          	sd	s7,72(a0)
 226:	05853823          	sd	s8,80(a0)
 22a:	05953c23          	sd	s9,88(a0)
 22e:	07a53023          	sd	s10,96(a0)
 232:	07b53423          	sd	s11,104(a0)
 236:	0005b083          	ld	ra,0(a1)
 23a:	0085b103          	ld	sp,8(a1)
 23e:	6980                	ld	s0,16(a1)
 240:	6d84                	ld	s1,24(a1)
 242:	0205b903          	ld	s2,32(a1)
 246:	0285b983          	ld	s3,40(a1)
 24a:	0305ba03          	ld	s4,48(a1)
 24e:	0385ba83          	ld	s5,56(a1)
 252:	0405bb03          	ld	s6,64(a1)
 256:	0485bb83          	ld	s7,72(a1)
 25a:	0505bc03          	ld	s8,80(a1)
 25e:	0585bc83          	ld	s9,88(a1)
 262:	0605bd03          	ld	s10,96(a1)
 266:	0685bd83          	ld	s11,104(a1)
 26a:	8082                	ret

000000000000026c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 26c:	1101                	addi	sp,sp,-32
 26e:	ec06                	sd	ra,24(sp)
 270:	e822                	sd	s0,16(sp)
 272:	e426                	sd	s1,8(sp)
 274:	e04a                	sd	s2,0(sp)
 276:	1000                	addi	s0,sp,32
 278:	84aa                	mv	s1,a0
 27a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 27c:	09000513          	li	a0,144
 280:	00000097          	auipc	ra,0x0
 284:	6c4080e7          	jalr	1732(ra) # 944 <malloc>

    main_thread->tid = 0;
 288:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 28c:	85ca                	mv	a1,s2
 28e:	8526                	mv	a0,s1
 290:	00000097          	auipc	ra,0x0
 294:	d92080e7          	jalr	-622(ra) # 22 <main>
    exit(res);
 298:	00000097          	auipc	ra,0x0
 29c:	274080e7          	jalr	628(ra) # 50c <exit>

00000000000002a0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e422                	sd	s0,8(sp)
 2a4:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2a6:	87aa                	mv	a5,a0
 2a8:	0585                	addi	a1,a1,1
 2aa:	0785                	addi	a5,a5,1
 2ac:	fff5c703          	lbu	a4,-1(a1)
 2b0:	fee78fa3          	sb	a4,-1(a5)
 2b4:	fb75                	bnez	a4,2a8 <strcpy+0x8>
        ;
    return os;
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strcmp>:

int strcmp(const char *p, const char *q)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cb91                	beqz	a5,2da <strcmp+0x1e>
 2c8:	0005c703          	lbu	a4,0(a1)
 2cc:	00f71763          	bne	a4,a5,2da <strcmp+0x1e>
        p++, q++;
 2d0:	0505                	addi	a0,a0,1
 2d2:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	fbe5                	bnez	a5,2c8 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2da:	0005c503          	lbu	a0,0(a1)
}
 2de:	40a7853b          	subw	a0,a5,a0
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <strlen>:

uint strlen(const char *s)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	cf91                	beqz	a5,30e <strlen+0x26>
 2f4:	0505                	addi	a0,a0,1
 2f6:	87aa                	mv	a5,a0
 2f8:	86be                	mv	a3,a5
 2fa:	0785                	addi	a5,a5,1
 2fc:	fff7c703          	lbu	a4,-1(a5)
 300:	ff65                	bnez	a4,2f8 <strlen+0x10>
 302:	40a6853b          	subw	a0,a3,a0
 306:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret
    for (n = 0; s[n]; n++)
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <strlen+0x20>

0000000000000312 <memset>:

void *
memset(void *dst, int c, uint n)
{
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 318:	ca19                	beqz	a2,32e <memset+0x1c>
 31a:	87aa                	mv	a5,a0
 31c:	1602                	slli	a2,a2,0x20
 31e:	9201                	srli	a2,a2,0x20
 320:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 324:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 328:	0785                	addi	a5,a5,1
 32a:	fee79de3          	bne	a5,a4,324 <memset+0x12>
    }
    return dst;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret

0000000000000334 <strchr>:

char *
strchr(const char *s, char c)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
    for (; *s; s++)
 33a:	00054783          	lbu	a5,0(a0)
 33e:	cb99                	beqz	a5,354 <strchr+0x20>
        if (*s == c)
 340:	00f58763          	beq	a1,a5,34e <strchr+0x1a>
    for (; *s; s++)
 344:	0505                	addi	a0,a0,1
 346:	00054783          	lbu	a5,0(a0)
 34a:	fbfd                	bnez	a5,340 <strchr+0xc>
            return (char *)s;
    return 0;
 34c:	4501                	li	a0,0
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret
    return 0;
 354:	4501                	li	a0,0
 356:	bfe5                	j	34e <strchr+0x1a>

0000000000000358 <gets>:

char *
gets(char *buf, int max)
{
 358:	711d                	addi	sp,sp,-96
 35a:	ec86                	sd	ra,88(sp)
 35c:	e8a2                	sd	s0,80(sp)
 35e:	e4a6                	sd	s1,72(sp)
 360:	e0ca                	sd	s2,64(sp)
 362:	fc4e                	sd	s3,56(sp)
 364:	f852                	sd	s4,48(sp)
 366:	f456                	sd	s5,40(sp)
 368:	f05a                	sd	s6,32(sp)
 36a:	ec5e                	sd	s7,24(sp)
 36c:	1080                	addi	s0,sp,96
 36e:	8baa                	mv	s7,a0
 370:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 372:	892a                	mv	s2,a0
 374:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 376:	4aa9                	li	s5,10
 378:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 37a:	89a6                	mv	s3,s1
 37c:	2485                	addiw	s1,s1,1
 37e:	0344d863          	bge	s1,s4,3ae <gets+0x56>
        cc = read(0, &c, 1);
 382:	4605                	li	a2,1
 384:	faf40593          	addi	a1,s0,-81
 388:	4501                	li	a0,0
 38a:	00000097          	auipc	ra,0x0
 38e:	19a080e7          	jalr	410(ra) # 524 <read>
        if (cc < 1)
 392:	00a05e63          	blez	a0,3ae <gets+0x56>
        buf[i++] = c;
 396:	faf44783          	lbu	a5,-81(s0)
 39a:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 39e:	01578763          	beq	a5,s5,3ac <gets+0x54>
 3a2:	0905                	addi	s2,s2,1
 3a4:	fd679be3          	bne	a5,s6,37a <gets+0x22>
    for (i = 0; i + 1 < max;)
 3a8:	89a6                	mv	s3,s1
 3aa:	a011                	j	3ae <gets+0x56>
 3ac:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3ae:	99de                	add	s3,s3,s7
 3b0:	00098023          	sb	zero,0(s3)
    return buf;
}
 3b4:	855e                	mv	a0,s7
 3b6:	60e6                	ld	ra,88(sp)
 3b8:	6446                	ld	s0,80(sp)
 3ba:	64a6                	ld	s1,72(sp)
 3bc:	6906                	ld	s2,64(sp)
 3be:	79e2                	ld	s3,56(sp)
 3c0:	7a42                	ld	s4,48(sp)
 3c2:	7aa2                	ld	s5,40(sp)
 3c4:	7b02                	ld	s6,32(sp)
 3c6:	6be2                	ld	s7,24(sp)
 3c8:	6125                	addi	sp,sp,96
 3ca:	8082                	ret

00000000000003cc <stat>:

int stat(const char *n, struct stat *st)
{
 3cc:	1101                	addi	sp,sp,-32
 3ce:	ec06                	sd	ra,24(sp)
 3d0:	e822                	sd	s0,16(sp)
 3d2:	e426                	sd	s1,8(sp)
 3d4:	e04a                	sd	s2,0(sp)
 3d6:	1000                	addi	s0,sp,32
 3d8:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3da:	4581                	li	a1,0
 3dc:	00000097          	auipc	ra,0x0
 3e0:	170080e7          	jalr	368(ra) # 54c <open>
    if (fd < 0)
 3e4:	02054563          	bltz	a0,40e <stat+0x42>
 3e8:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3ea:	85ca                	mv	a1,s2
 3ec:	00000097          	auipc	ra,0x0
 3f0:	178080e7          	jalr	376(ra) # 564 <fstat>
 3f4:	892a                	mv	s2,a0
    close(fd);
 3f6:	8526                	mv	a0,s1
 3f8:	00000097          	auipc	ra,0x0
 3fc:	13c080e7          	jalr	316(ra) # 534 <close>
    return r;
}
 400:	854a                	mv	a0,s2
 402:	60e2                	ld	ra,24(sp)
 404:	6442                	ld	s0,16(sp)
 406:	64a2                	ld	s1,8(sp)
 408:	6902                	ld	s2,0(sp)
 40a:	6105                	addi	sp,sp,32
 40c:	8082                	ret
        return -1;
 40e:	597d                	li	s2,-1
 410:	bfc5                	j	400 <stat+0x34>

0000000000000412 <atoi>:

int atoi(const char *s)
{
 412:	1141                	addi	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 418:	00054683          	lbu	a3,0(a0)
 41c:	fd06879b          	addiw	a5,a3,-48
 420:	0ff7f793          	zext.b	a5,a5
 424:	4625                	li	a2,9
 426:	02f66863          	bltu	a2,a5,456 <atoi+0x44>
 42a:	872a                	mv	a4,a0
    n = 0;
 42c:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 42e:	0705                	addi	a4,a4,1
 430:	0025179b          	slliw	a5,a0,0x2
 434:	9fa9                	addw	a5,a5,a0
 436:	0017979b          	slliw	a5,a5,0x1
 43a:	9fb5                	addw	a5,a5,a3
 43c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 440:	00074683          	lbu	a3,0(a4)
 444:	fd06879b          	addiw	a5,a3,-48
 448:	0ff7f793          	zext.b	a5,a5
 44c:	fef671e3          	bgeu	a2,a5,42e <atoi+0x1c>
    return n;
}
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret
    n = 0;
 456:	4501                	li	a0,0
 458:	bfe5                	j	450 <atoi+0x3e>

000000000000045a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 45a:	1141                	addi	sp,sp,-16
 45c:	e422                	sd	s0,8(sp)
 45e:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 460:	02b57463          	bgeu	a0,a1,488 <memmove+0x2e>
    {
        while (n-- > 0)
 464:	00c05f63          	blez	a2,482 <memmove+0x28>
 468:	1602                	slli	a2,a2,0x20
 46a:	9201                	srli	a2,a2,0x20
 46c:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 470:	872a                	mv	a4,a0
            *dst++ = *src++;
 472:	0585                	addi	a1,a1,1
 474:	0705                	addi	a4,a4,1
 476:	fff5c683          	lbu	a3,-1(a1)
 47a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 47e:	fee79ae3          	bne	a5,a4,472 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret
        dst += n;
 488:	00c50733          	add	a4,a0,a2
        src += n;
 48c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 48e:	fec05ae3          	blez	a2,482 <memmove+0x28>
 492:	fff6079b          	addiw	a5,a2,-1
 496:	1782                	slli	a5,a5,0x20
 498:	9381                	srli	a5,a5,0x20
 49a:	fff7c793          	not	a5,a5
 49e:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4a0:	15fd                	addi	a1,a1,-1
 4a2:	177d                	addi	a4,a4,-1
 4a4:	0005c683          	lbu	a3,0(a1)
 4a8:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4ac:	fee79ae3          	bne	a5,a4,4a0 <memmove+0x46>
 4b0:	bfc9                	j	482 <memmove+0x28>

00000000000004b2 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4b2:	1141                	addi	sp,sp,-16
 4b4:	e422                	sd	s0,8(sp)
 4b6:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4b8:	ca05                	beqz	a2,4e8 <memcmp+0x36>
 4ba:	fff6069b          	addiw	a3,a2,-1
 4be:	1682                	slli	a3,a3,0x20
 4c0:	9281                	srli	a3,a3,0x20
 4c2:	0685                	addi	a3,a3,1
 4c4:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	0005c703          	lbu	a4,0(a1)
 4ce:	00e79863          	bne	a5,a4,4de <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4d2:	0505                	addi	a0,a0,1
        p2++;
 4d4:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4d6:	fed518e3          	bne	a0,a3,4c6 <memcmp+0x14>
    }
    return 0;
 4da:	4501                	li	a0,0
 4dc:	a019                	j	4e2 <memcmp+0x30>
            return *p1 - *p2;
 4de:	40e7853b          	subw	a0,a5,a4
}
 4e2:	6422                	ld	s0,8(sp)
 4e4:	0141                	addi	sp,sp,16
 4e6:	8082                	ret
    return 0;
 4e8:	4501                	li	a0,0
 4ea:	bfe5                	j	4e2 <memcmp+0x30>

00000000000004ec <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ec:	1141                	addi	sp,sp,-16
 4ee:	e406                	sd	ra,8(sp)
 4f0:	e022                	sd	s0,0(sp)
 4f2:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4f4:	00000097          	auipc	ra,0x0
 4f8:	f66080e7          	jalr	-154(ra) # 45a <memmove>
}
 4fc:	60a2                	ld	ra,8(sp)
 4fe:	6402                	ld	s0,0(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret

0000000000000504 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 504:	4885                	li	a7,1
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <exit>:
.global exit
exit:
 li a7, SYS_exit
 50c:	4889                	li	a7,2
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <wait>:
.global wait
wait:
 li a7, SYS_wait
 514:	488d                	li	a7,3
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 51c:	4891                	li	a7,4
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <read>:
.global read
read:
 li a7, SYS_read
 524:	4895                	li	a7,5
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <write>:
.global write
write:
 li a7, SYS_write
 52c:	48c1                	li	a7,16
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <close>:
.global close
close:
 li a7, SYS_close
 534:	48d5                	li	a7,21
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <kill>:
.global kill
kill:
 li a7, SYS_kill
 53c:	4899                	li	a7,6
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <exec>:
.global exec
exec:
 li a7, SYS_exec
 544:	489d                	li	a7,7
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <open>:
.global open
open:
 li a7, SYS_open
 54c:	48bd                	li	a7,15
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 554:	48c5                	li	a7,17
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 55c:	48c9                	li	a7,18
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 564:	48a1                	li	a7,8
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <link>:
.global link
link:
 li a7, SYS_link
 56c:	48cd                	li	a7,19
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 574:	48d1                	li	a7,20
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 57c:	48a5                	li	a7,9
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <dup>:
.global dup
dup:
 li a7, SYS_dup
 584:	48a9                	li	a7,10
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 58c:	48ad                	li	a7,11
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 594:	48b1                	li	a7,12
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 59c:	48b5                	li	a7,13
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a4:	48b9                	li	a7,14
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <ps>:
.global ps
ps:
 li a7, SYS_ps
 5ac:	48d9                	li	a7,22
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5b4:	48dd                	li	a7,23
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5bc:	48e1                	li	a7,24
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c4:	1101                	addi	sp,sp,-32
 5c6:	ec06                	sd	ra,24(sp)
 5c8:	e822                	sd	s0,16(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d0:	4605                	li	a2,1
 5d2:	fef40593          	addi	a1,s0,-17
 5d6:	00000097          	auipc	ra,0x0
 5da:	f56080e7          	jalr	-170(ra) # 52c <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e6:	7139                	addi	sp,sp,-64
 5e8:	fc06                	sd	ra,56(sp)
 5ea:	f822                	sd	s0,48(sp)
 5ec:	f426                	sd	s1,40(sp)
 5ee:	f04a                	sd	s2,32(sp)
 5f0:	ec4e                	sd	s3,24(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f6:	c299                	beqz	a3,5fc <printint+0x16>
 5f8:	0805c963          	bltz	a1,68a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fc:	2581                	sext.w	a1,a1
  neg = 0;
 5fe:	4881                	li	a7,0
 600:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 604:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 606:	2601                	sext.w	a2,a2
 608:	00000517          	auipc	a0,0x0
 60c:	4e850513          	addi	a0,a0,1256 # af0 <digits>
 610:	883a                	mv	a6,a4
 612:	2705                	addiw	a4,a4,1
 614:	02c5f7bb          	remuw	a5,a1,a2
 618:	1782                	slli	a5,a5,0x20
 61a:	9381                	srli	a5,a5,0x20
 61c:	97aa                	add	a5,a5,a0
 61e:	0007c783          	lbu	a5,0(a5)
 622:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 626:	0005879b          	sext.w	a5,a1
 62a:	02c5d5bb          	divuw	a1,a1,a2
 62e:	0685                	addi	a3,a3,1
 630:	fec7f0e3          	bgeu	a5,a2,610 <printint+0x2a>
  if(neg)
 634:	00088c63          	beqz	a7,64c <printint+0x66>
    buf[i++] = '-';
 638:	fd070793          	addi	a5,a4,-48
 63c:	00878733          	add	a4,a5,s0
 640:	02d00793          	li	a5,45
 644:	fef70823          	sb	a5,-16(a4)
 648:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 64c:	02e05863          	blez	a4,67c <printint+0x96>
 650:	fc040793          	addi	a5,s0,-64
 654:	00e78933          	add	s2,a5,a4
 658:	fff78993          	addi	s3,a5,-1
 65c:	99ba                	add	s3,s3,a4
 65e:	377d                	addiw	a4,a4,-1
 660:	1702                	slli	a4,a4,0x20
 662:	9301                	srli	a4,a4,0x20
 664:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 668:	fff94583          	lbu	a1,-1(s2)
 66c:	8526                	mv	a0,s1
 66e:	00000097          	auipc	ra,0x0
 672:	f56080e7          	jalr	-170(ra) # 5c4 <putc>
  while(--i >= 0)
 676:	197d                	addi	s2,s2,-1
 678:	ff3918e3          	bne	s2,s3,668 <printint+0x82>
}
 67c:	70e2                	ld	ra,56(sp)
 67e:	7442                	ld	s0,48(sp)
 680:	74a2                	ld	s1,40(sp)
 682:	7902                	ld	s2,32(sp)
 684:	69e2                	ld	s3,24(sp)
 686:	6121                	addi	sp,sp,64
 688:	8082                	ret
    x = -xx;
 68a:	40b005bb          	negw	a1,a1
    neg = 1;
 68e:	4885                	li	a7,1
    x = -xx;
 690:	bf85                	j	600 <printint+0x1a>

0000000000000692 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 692:	715d                	addi	sp,sp,-80
 694:	e486                	sd	ra,72(sp)
 696:	e0a2                	sd	s0,64(sp)
 698:	fc26                	sd	s1,56(sp)
 69a:	f84a                	sd	s2,48(sp)
 69c:	f44e                	sd	s3,40(sp)
 69e:	f052                	sd	s4,32(sp)
 6a0:	ec56                	sd	s5,24(sp)
 6a2:	e85a                	sd	s6,16(sp)
 6a4:	e45e                	sd	s7,8(sp)
 6a6:	e062                	sd	s8,0(sp)
 6a8:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6aa:	0005c903          	lbu	s2,0(a1)
 6ae:	18090c63          	beqz	s2,846 <vprintf+0x1b4>
 6b2:	8aaa                	mv	s5,a0
 6b4:	8bb2                	mv	s7,a2
 6b6:	00158493          	addi	s1,a1,1
  state = 0;
 6ba:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6bc:	02500a13          	li	s4,37
 6c0:	4b55                	li	s6,21
 6c2:	a839                	j	6e0 <vprintf+0x4e>
        putc(fd, c);
 6c4:	85ca                	mv	a1,s2
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	efc080e7          	jalr	-260(ra) # 5c4 <putc>
 6d0:	a019                	j	6d6 <vprintf+0x44>
    } else if(state == '%'){
 6d2:	01498d63          	beq	s3,s4,6ec <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6d6:	0485                	addi	s1,s1,1
 6d8:	fff4c903          	lbu	s2,-1(s1)
 6dc:	16090563          	beqz	s2,846 <vprintf+0x1b4>
    if(state == 0){
 6e0:	fe0999e3          	bnez	s3,6d2 <vprintf+0x40>
      if(c == '%'){
 6e4:	ff4910e3          	bne	s2,s4,6c4 <vprintf+0x32>
        state = '%';
 6e8:	89d2                	mv	s3,s4
 6ea:	b7f5                	j	6d6 <vprintf+0x44>
      if(c == 'd'){
 6ec:	13490263          	beq	s2,s4,810 <vprintf+0x17e>
 6f0:	f9d9079b          	addiw	a5,s2,-99
 6f4:	0ff7f793          	zext.b	a5,a5
 6f8:	12fb6563          	bltu	s6,a5,822 <vprintf+0x190>
 6fc:	f9d9079b          	addiw	a5,s2,-99
 700:	0ff7f713          	zext.b	a4,a5
 704:	10eb6f63          	bltu	s6,a4,822 <vprintf+0x190>
 708:	00271793          	slli	a5,a4,0x2
 70c:	00000717          	auipc	a4,0x0
 710:	38c70713          	addi	a4,a4,908 # a98 <malloc+0x154>
 714:	97ba                	add	a5,a5,a4
 716:	439c                	lw	a5,0(a5)
 718:	97ba                	add	a5,a5,a4
 71a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 71c:	008b8913          	addi	s2,s7,8
 720:	4685                	li	a3,1
 722:	4629                	li	a2,10
 724:	000ba583          	lw	a1,0(s7)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	ebc080e7          	jalr	-324(ra) # 5e6 <printint>
 732:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 734:	4981                	li	s3,0
 736:	b745                	j	6d6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 738:	008b8913          	addi	s2,s7,8
 73c:	4681                	li	a3,0
 73e:	4629                	li	a2,10
 740:	000ba583          	lw	a1,0(s7)
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	ea0080e7          	jalr	-352(ra) # 5e6 <printint>
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
 752:	b751                	j	6d6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4641                	li	a2,16
 75c:	000ba583          	lw	a1,0(s7)
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e84080e7          	jalr	-380(ra) # 5e6 <printint>
 76a:	8bca                	mv	s7,s2
      state = 0;
 76c:	4981                	li	s3,0
 76e:	b7a5                	j	6d6 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 770:	008b8c13          	addi	s8,s7,8
 774:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 778:	03000593          	li	a1,48
 77c:	8556                	mv	a0,s5
 77e:	00000097          	auipc	ra,0x0
 782:	e46080e7          	jalr	-442(ra) # 5c4 <putc>
  putc(fd, 'x');
 786:	07800593          	li	a1,120
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e38080e7          	jalr	-456(ra) # 5c4 <putc>
 794:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	00000b97          	auipc	s7,0x0
 79a:	35ab8b93          	addi	s7,s7,858 # af0 <digits>
 79e:	03c9d793          	srli	a5,s3,0x3c
 7a2:	97de                	add	a5,a5,s7
 7a4:	0007c583          	lbu	a1,0(a5)
 7a8:	8556                	mv	a0,s5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	e1a080e7          	jalr	-486(ra) # 5c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b2:	0992                	slli	s3,s3,0x4
 7b4:	397d                	addiw	s2,s2,-1
 7b6:	fe0914e3          	bnez	s2,79e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7ba:	8be2                	mv	s7,s8
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bf21                	j	6d6 <vprintf+0x44>
        s = va_arg(ap, char*);
 7c0:	008b8993          	addi	s3,s7,8
 7c4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7c8:	02090163          	beqz	s2,7ea <vprintf+0x158>
        while(*s != 0){
 7cc:	00094583          	lbu	a1,0(s2)
 7d0:	c9a5                	beqz	a1,840 <vprintf+0x1ae>
          putc(fd, *s);
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	df0080e7          	jalr	-528(ra) # 5c4 <putc>
          s++;
 7dc:	0905                	addi	s2,s2,1
        while(*s != 0){
 7de:	00094583          	lbu	a1,0(s2)
 7e2:	f9e5                	bnez	a1,7d2 <vprintf+0x140>
        s = va_arg(ap, char*);
 7e4:	8bce                	mv	s7,s3
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b5fd                	j	6d6 <vprintf+0x44>
          s = "(null)";
 7ea:	00000917          	auipc	s2,0x0
 7ee:	2a690913          	addi	s2,s2,678 # a90 <malloc+0x14c>
        while(*s != 0){
 7f2:	02800593          	li	a1,40
 7f6:	bff1                	j	7d2 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 7f8:	008b8913          	addi	s2,s7,8
 7fc:	000bc583          	lbu	a1,0(s7)
 800:	8556                	mv	a0,s5
 802:	00000097          	auipc	ra,0x0
 806:	dc2080e7          	jalr	-574(ra) # 5c4 <putc>
 80a:	8bca                	mv	s7,s2
      state = 0;
 80c:	4981                	li	s3,0
 80e:	b5e1                	j	6d6 <vprintf+0x44>
        putc(fd, c);
 810:	02500593          	li	a1,37
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	dae080e7          	jalr	-594(ra) # 5c4 <putc>
      state = 0;
 81e:	4981                	li	s3,0
 820:	bd5d                	j	6d6 <vprintf+0x44>
        putc(fd, '%');
 822:	02500593          	li	a1,37
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	d9c080e7          	jalr	-612(ra) # 5c4 <putc>
        putc(fd, c);
 830:	85ca                	mv	a1,s2
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	d90080e7          	jalr	-624(ra) # 5c4 <putc>
      state = 0;
 83c:	4981                	li	s3,0
 83e:	bd61                	j	6d6 <vprintf+0x44>
        s = va_arg(ap, char*);
 840:	8bce                	mv	s7,s3
      state = 0;
 842:	4981                	li	s3,0
 844:	bd49                	j	6d6 <vprintf+0x44>
    }
  }
}
 846:	60a6                	ld	ra,72(sp)
 848:	6406                	ld	s0,64(sp)
 84a:	74e2                	ld	s1,56(sp)
 84c:	7942                	ld	s2,48(sp)
 84e:	79a2                	ld	s3,40(sp)
 850:	7a02                	ld	s4,32(sp)
 852:	6ae2                	ld	s5,24(sp)
 854:	6b42                	ld	s6,16(sp)
 856:	6ba2                	ld	s7,8(sp)
 858:	6c02                	ld	s8,0(sp)
 85a:	6161                	addi	sp,sp,80
 85c:	8082                	ret

000000000000085e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 85e:	715d                	addi	sp,sp,-80
 860:	ec06                	sd	ra,24(sp)
 862:	e822                	sd	s0,16(sp)
 864:	1000                	addi	s0,sp,32
 866:	e010                	sd	a2,0(s0)
 868:	e414                	sd	a3,8(s0)
 86a:	e818                	sd	a4,16(s0)
 86c:	ec1c                	sd	a5,24(s0)
 86e:	03043023          	sd	a6,32(s0)
 872:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 87a:	8622                	mv	a2,s0
 87c:	00000097          	auipc	ra,0x0
 880:	e16080e7          	jalr	-490(ra) # 692 <vprintf>
}
 884:	60e2                	ld	ra,24(sp)
 886:	6442                	ld	s0,16(sp)
 888:	6161                	addi	sp,sp,80
 88a:	8082                	ret

000000000000088c <printf>:

void
printf(const char *fmt, ...)
{
 88c:	711d                	addi	sp,sp,-96
 88e:	ec06                	sd	ra,24(sp)
 890:	e822                	sd	s0,16(sp)
 892:	1000                	addi	s0,sp,32
 894:	e40c                	sd	a1,8(s0)
 896:	e810                	sd	a2,16(s0)
 898:	ec14                	sd	a3,24(s0)
 89a:	f018                	sd	a4,32(s0)
 89c:	f41c                	sd	a5,40(s0)
 89e:	03043823          	sd	a6,48(s0)
 8a2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8a6:	00840613          	addi	a2,s0,8
 8aa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ae:	85aa                	mv	a1,a0
 8b0:	4505                	li	a0,1
 8b2:	00000097          	auipc	ra,0x0
 8b6:	de0080e7          	jalr	-544(ra) # 692 <vprintf>
}
 8ba:	60e2                	ld	ra,24(sp)
 8bc:	6442                	ld	s0,16(sp)
 8be:	6125                	addi	sp,sp,96
 8c0:	8082                	ret

00000000000008c2 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8c2:	1141                	addi	sp,sp,-16
 8c4:	e422                	sd	s0,8(sp)
 8c6:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8c8:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	00000797          	auipc	a5,0x0
 8d0:	73c7b783          	ld	a5,1852(a5) # 1008 <freep>
 8d4:	a02d                	j	8fe <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8d6:	4618                	lw	a4,8(a2)
 8d8:	9f2d                	addw	a4,a4,a1
 8da:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8de:	6398                	ld	a4,0(a5)
 8e0:	6310                	ld	a2,0(a4)
 8e2:	a83d                	j	920 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8e4:	ff852703          	lw	a4,-8(a0)
 8e8:	9f31                	addw	a4,a4,a2
 8ea:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8ec:	ff053683          	ld	a3,-16(a0)
 8f0:	a091                	j	934 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f2:	6398                	ld	a4,0(a5)
 8f4:	00e7e463          	bltu	a5,a4,8fc <free+0x3a>
 8f8:	00e6ea63          	bltu	a3,a4,90c <free+0x4a>
{
 8fc:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fe:	fed7fae3          	bgeu	a5,a3,8f2 <free+0x30>
 902:	6398                	ld	a4,0(a5)
 904:	00e6e463          	bltu	a3,a4,90c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 908:	fee7eae3          	bltu	a5,a4,8fc <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 90c:	ff852583          	lw	a1,-8(a0)
 910:	6390                	ld	a2,0(a5)
 912:	02059813          	slli	a6,a1,0x20
 916:	01c85713          	srli	a4,a6,0x1c
 91a:	9736                	add	a4,a4,a3
 91c:	fae60de3          	beq	a2,a4,8d6 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 920:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 924:	4790                	lw	a2,8(a5)
 926:	02061593          	slli	a1,a2,0x20
 92a:	01c5d713          	srli	a4,a1,0x1c
 92e:	973e                	add	a4,a4,a5
 930:	fae68ae3          	beq	a3,a4,8e4 <free+0x22>
        p->s.ptr = bp->s.ptr;
 934:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 936:	00000717          	auipc	a4,0x0
 93a:	6cf73923          	sd	a5,1746(a4) # 1008 <freep>
}
 93e:	6422                	ld	s0,8(sp)
 940:	0141                	addi	sp,sp,16
 942:	8082                	ret

0000000000000944 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 944:	7139                	addi	sp,sp,-64
 946:	fc06                	sd	ra,56(sp)
 948:	f822                	sd	s0,48(sp)
 94a:	f426                	sd	s1,40(sp)
 94c:	f04a                	sd	s2,32(sp)
 94e:	ec4e                	sd	s3,24(sp)
 950:	e852                	sd	s4,16(sp)
 952:	e456                	sd	s5,8(sp)
 954:	e05a                	sd	s6,0(sp)
 956:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 958:	02051493          	slli	s1,a0,0x20
 95c:	9081                	srli	s1,s1,0x20
 95e:	04bd                	addi	s1,s1,15
 960:	8091                	srli	s1,s1,0x4
 962:	0014899b          	addiw	s3,s1,1
 966:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 968:	00000517          	auipc	a0,0x0
 96c:	6a053503          	ld	a0,1696(a0) # 1008 <freep>
 970:	c515                	beqz	a0,99c <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 972:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 974:	4798                	lw	a4,8(a5)
 976:	02977f63          	bgeu	a4,s1,9b4 <malloc+0x70>
    if (nu < 4096)
 97a:	8a4e                	mv	s4,s3
 97c:	0009871b          	sext.w	a4,s3
 980:	6685                	lui	a3,0x1
 982:	00d77363          	bgeu	a4,a3,988 <malloc+0x44>
 986:	6a05                	lui	s4,0x1
 988:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 98c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 990:	00000917          	auipc	s2,0x0
 994:	67890913          	addi	s2,s2,1656 # 1008 <freep>
    if (p == (char *)-1)
 998:	5afd                	li	s5,-1
 99a:	a895                	j	a0e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 99c:	00000797          	auipc	a5,0x0
 9a0:	67478793          	addi	a5,a5,1652 # 1010 <base>
 9a4:	00000717          	auipc	a4,0x0
 9a8:	66f73223          	sd	a5,1636(a4) # 1008 <freep>
 9ac:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9ae:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9b2:	b7e1                	j	97a <malloc+0x36>
            if (p->s.size == nunits)
 9b4:	02e48c63          	beq	s1,a4,9ec <malloc+0xa8>
                p->s.size -= nunits;
 9b8:	4137073b          	subw	a4,a4,s3
 9bc:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9be:	02071693          	slli	a3,a4,0x20
 9c2:	01c6d713          	srli	a4,a3,0x1c
 9c6:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9c8:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9cc:	00000717          	auipc	a4,0x0
 9d0:	62a73e23          	sd	a0,1596(a4) # 1008 <freep>
            return (void *)(p + 1);
 9d4:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9d8:	70e2                	ld	ra,56(sp)
 9da:	7442                	ld	s0,48(sp)
 9dc:	74a2                	ld	s1,40(sp)
 9de:	7902                	ld	s2,32(sp)
 9e0:	69e2                	ld	s3,24(sp)
 9e2:	6a42                	ld	s4,16(sp)
 9e4:	6aa2                	ld	s5,8(sp)
 9e6:	6b02                	ld	s6,0(sp)
 9e8:	6121                	addi	sp,sp,64
 9ea:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9ec:	6398                	ld	a4,0(a5)
 9ee:	e118                	sd	a4,0(a0)
 9f0:	bff1                	j	9cc <malloc+0x88>
    hp->s.size = nu;
 9f2:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9f6:	0541                	addi	a0,a0,16
 9f8:	00000097          	auipc	ra,0x0
 9fc:	eca080e7          	jalr	-310(ra) # 8c2 <free>
    return freep;
 a00:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a04:	d971                	beqz	a0,9d8 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a06:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a08:	4798                	lw	a4,8(a5)
 a0a:	fa9775e3          	bgeu	a4,s1,9b4 <malloc+0x70>
        if (p == freep)
 a0e:	00093703          	ld	a4,0(s2)
 a12:	853e                	mv	a0,a5
 a14:	fef719e3          	bne	a4,a5,a06 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a18:	8552                	mv	a0,s4
 a1a:	00000097          	auipc	ra,0x0
 a1e:	b7a080e7          	jalr	-1158(ra) # 594 <sbrk>
    if (p == (char *)-1)
 a22:	fd5518e3          	bne	a0,s5,9f2 <malloc+0xae>
                return 0;
 a26:	4501                	li	a0,0
 a28:	bf45                	j	9d8 <malloc+0x94>
