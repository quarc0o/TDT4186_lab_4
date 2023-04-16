
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	bge	a5,a0,48 <main+0x48>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	3fc080e7          	jalr	1020(ra) # 424 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	51e080e7          	jalr	1310(ra) # 54e <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4de080e7          	jalr	1246(ra) # 51e <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	9f858593          	addi	a1,a1,-1544 # a40 <malloc+0xea>
  50:	4509                	li	a0,2
  52:	00001097          	auipc	ra,0x1
  56:	81e080e7          	jalr	-2018(ra) # 870 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	4c2080e7          	jalr	1218(ra) # 51e <exit>

0000000000000064 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
    lk->name = name;
  6a:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  6c:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  70:	57fd                	li	a5,-1
  72:	00f50823          	sb	a5,16(a0)
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  7c:	00054783          	lbu	a5,0(a0)
  80:	e399                	bnez	a5,86 <holding+0xa>
  82:	4501                	li	a0,0
}
  84:	8082                	ret
{
  86:	1101                	addi	sp,sp,-32
  88:	ec06                	sd	ra,24(sp)
  8a:	e822                	sd	s0,16(sp)
  8c:	e426                	sd	s1,8(sp)
  8e:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  90:	01054483          	lbu	s1,16(a0)
  94:	00000097          	auipc	ra,0x0
  98:	172080e7          	jalr	370(ra) # 206 <twhoami>
  9c:	2501                	sext.w	a0,a0
  9e:	40a48533          	sub	a0,s1,a0
  a2:	00153513          	seqz	a0,a0
}
  a6:	60e2                	ld	ra,24(sp)
  a8:	6442                	ld	s0,16(sp)
  aa:	64a2                	ld	s1,8(sp)
  ac:	6105                	addi	sp,sp,32
  ae:	8082                	ret

00000000000000b0 <acquire>:

void acquire(struct lock *lk)
{
  b0:	7179                	addi	sp,sp,-48
  b2:	f406                	sd	ra,40(sp)
  b4:	f022                	sd	s0,32(sp)
  b6:	ec26                	sd	s1,24(sp)
  b8:	e84a                	sd	s2,16(sp)
  ba:	e44e                	sd	s3,8(sp)
  bc:	e052                	sd	s4,0(sp)
  be:	1800                	addi	s0,sp,48
  c0:	8a2a                	mv	s4,a0
    if (holding(lk))
  c2:	00000097          	auipc	ra,0x0
  c6:	fba080e7          	jalr	-70(ra) # 7c <holding>
  ca:	e919                	bnez	a0,e0 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  cc:	ffca7493          	andi	s1,s4,-4
  d0:	003a7913          	andi	s2,s4,3
  d4:	0039191b          	slliw	s2,s2,0x3
  d8:	4985                	li	s3,1
  da:	012999bb          	sllw	s3,s3,s2
  de:	a015                	j	102 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  e0:	00001517          	auipc	a0,0x1
  e4:	97850513          	addi	a0,a0,-1672 # a58 <malloc+0x102>
  e8:	00000097          	auipc	ra,0x0
  ec:	7b6080e7          	jalr	1974(ra) # 89e <printf>
        exit(-1);
  f0:	557d                	li	a0,-1
  f2:	00000097          	auipc	ra,0x0
  f6:	42c080e7          	jalr	1068(ra) # 51e <exit>
    {
        // give up the cpu for other threads
        tyield();
  fa:	00000097          	auipc	ra,0x0
  fe:	0f4080e7          	jalr	244(ra) # 1ee <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 102:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 106:	0127d7bb          	srlw	a5,a5,s2
 10a:	0ff7f793          	zext.b	a5,a5
 10e:	f7f5                	bnez	a5,fa <acquire+0x4a>
    }

    __sync_synchronize();
 110:	0ff0000f          	fence

    lk->tid = twhoami();
 114:	00000097          	auipc	ra,0x0
 118:	0f2080e7          	jalr	242(ra) # 206 <twhoami>
 11c:	00aa0823          	sb	a0,16(s4)
}
 120:	70a2                	ld	ra,40(sp)
 122:	7402                	ld	s0,32(sp)
 124:	64e2                	ld	s1,24(sp)
 126:	6942                	ld	s2,16(sp)
 128:	69a2                	ld	s3,8(sp)
 12a:	6a02                	ld	s4,0(sp)
 12c:	6145                	addi	sp,sp,48
 12e:	8082                	ret

0000000000000130 <release>:

void release(struct lock *lk)
{
 130:	1101                	addi	sp,sp,-32
 132:	ec06                	sd	ra,24(sp)
 134:	e822                	sd	s0,16(sp)
 136:	e426                	sd	s1,8(sp)
 138:	1000                	addi	s0,sp,32
 13a:	84aa                	mv	s1,a0
    if (!holding(lk))
 13c:	00000097          	auipc	ra,0x0
 140:	f40080e7          	jalr	-192(ra) # 7c <holding>
 144:	c11d                	beqz	a0,16a <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 146:	57fd                	li	a5,-1
 148:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 14c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 150:	0ff0000f          	fence
 154:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 158:	00000097          	auipc	ra,0x0
 15c:	096080e7          	jalr	150(ra) # 1ee <tyield>
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret
        printf("releasing lock we are not holding");
 16a:	00001517          	auipc	a0,0x1
 16e:	91650513          	addi	a0,a0,-1770 # a80 <malloc+0x12a>
 172:	00000097          	auipc	ra,0x0
 176:	72c080e7          	jalr	1836(ra) # 89e <printf>
        exit(-1);
 17a:	557d                	li	a0,-1
 17c:	00000097          	auipc	ra,0x0
 180:	3a2080e7          	jalr	930(ra) # 51e <exit>

0000000000000184 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 18a:	00001717          	auipc	a4,0x1
 18e:	e7673703          	ld	a4,-394(a4) # 1000 <current_thread>
 192:	47c1                	li	a5,16
 194:	c319                	beqz	a4,19a <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 196:	37fd                	addiw	a5,a5,-1
 198:	fff5                	bnez	a5,194 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 19a:	6422                	ld	s0,8(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret

00000000000001a0 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1a0:	7179                	addi	sp,sp,-48
 1a2:	f406                	sd	ra,40(sp)
 1a4:	f022                	sd	s0,32(sp)
 1a6:	ec26                	sd	s1,24(sp)
 1a8:	e84a                	sd	s2,16(sp)
 1aa:	e44e                	sd	s3,8(sp)
 1ac:	1800                	addi	s0,sp,48
 1ae:	84aa                	mv	s1,a0
 1b0:	89b2                	mv	s3,a2
 1b2:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1b4:	09000513          	li	a0,144
 1b8:	00000097          	auipc	ra,0x0
 1bc:	79e080e7          	jalr	1950(ra) # 956 <malloc>
 1c0:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1c2:	478d                	li	a5,3
 1c4:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1c6:	609c                	ld	a5,0(s1)
 1c8:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1cc:	609c                	ld	a5,0(s1)
 1ce:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1d2:	70a2                	ld	ra,40(sp)
 1d4:	7402                	ld	s0,32(sp)
 1d6:	64e2                	ld	s1,24(sp)
 1d8:	6942                	ld	s2,16(sp)
 1da:	69a2                	ld	s3,8(sp)
 1dc:	6145                	addi	sp,sp,48
 1de:	8082                	ret

00000000000001e0 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e422                	sd	s0,8(sp)
 1e4:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1e6:	4501                	li	a0,0
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret

00000000000001ee <tyield>:

void tyield()
{
 1ee:	1141                	addi	sp,sp,-16
 1f0:	e422                	sd	s0,8(sp)
 1f2:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1f4:	00001797          	auipc	a5,0x1
 1f8:	e0c7b783          	ld	a5,-500(a5) # 1000 <current_thread>
 1fc:	470d                	li	a4,3
 1fe:	dfb8                	sw	a4,120(a5)
    tsched();
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret

0000000000000206 <twhoami>:

uint8 twhoami()
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 20c:	4501                	li	a0,0
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret

0000000000000214 <tswtch>:
 214:	00153023          	sd	ra,0(a0)
 218:	00253423          	sd	sp,8(a0)
 21c:	e900                	sd	s0,16(a0)
 21e:	ed04                	sd	s1,24(a0)
 220:	03253023          	sd	s2,32(a0)
 224:	03353423          	sd	s3,40(a0)
 228:	03453823          	sd	s4,48(a0)
 22c:	03553c23          	sd	s5,56(a0)
 230:	05653023          	sd	s6,64(a0)
 234:	05753423          	sd	s7,72(a0)
 238:	05853823          	sd	s8,80(a0)
 23c:	05953c23          	sd	s9,88(a0)
 240:	07a53023          	sd	s10,96(a0)
 244:	07b53423          	sd	s11,104(a0)
 248:	0005b083          	ld	ra,0(a1)
 24c:	0085b103          	ld	sp,8(a1)
 250:	6980                	ld	s0,16(a1)
 252:	6d84                	ld	s1,24(a1)
 254:	0205b903          	ld	s2,32(a1)
 258:	0285b983          	ld	s3,40(a1)
 25c:	0305ba03          	ld	s4,48(a1)
 260:	0385ba83          	ld	s5,56(a1)
 264:	0405bb03          	ld	s6,64(a1)
 268:	0485bb83          	ld	s7,72(a1)
 26c:	0505bc03          	ld	s8,80(a1)
 270:	0585bc83          	ld	s9,88(a1)
 274:	0605bd03          	ld	s10,96(a1)
 278:	0685bd83          	ld	s11,104(a1)
 27c:	8082                	ret

000000000000027e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 27e:	1101                	addi	sp,sp,-32
 280:	ec06                	sd	ra,24(sp)
 282:	e822                	sd	s0,16(sp)
 284:	e426                	sd	s1,8(sp)
 286:	e04a                	sd	s2,0(sp)
 288:	1000                	addi	s0,sp,32
 28a:	84aa                	mv	s1,a0
 28c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 28e:	09000513          	li	a0,144
 292:	00000097          	auipc	ra,0x0
 296:	6c4080e7          	jalr	1732(ra) # 956 <malloc>

    main_thread->tid = 0;
 29a:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 29e:	85ca                	mv	a1,s2
 2a0:	8526                	mv	a0,s1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	d5e080e7          	jalr	-674(ra) # 0 <main>
    exit(res);
 2aa:	00000097          	auipc	ra,0x0
 2ae:	274080e7          	jalr	628(ra) # 51e <exit>

00000000000002b2 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2b8:	87aa                	mv	a5,a0
 2ba:	0585                	addi	a1,a1,1
 2bc:	0785                	addi	a5,a5,1
 2be:	fff5c703          	lbu	a4,-1(a1)
 2c2:	fee78fa3          	sb	a4,-1(a5)
 2c6:	fb75                	bnez	a4,2ba <strcpy+0x8>
        ;
    return os;
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <strcmp>:

int strcmp(const char *p, const char *q)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	cb91                	beqz	a5,2ec <strcmp+0x1e>
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00f71763          	bne	a4,a5,2ec <strcmp+0x1e>
        p++, q++;
 2e2:	0505                	addi	a0,a0,1
 2e4:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	fbe5                	bnez	a5,2da <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2ec:	0005c503          	lbu	a0,0(a1)
}
 2f0:	40a7853b          	subw	a0,a5,a0
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strlen>:

uint strlen(const char *s)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 300:	00054783          	lbu	a5,0(a0)
 304:	cf91                	beqz	a5,320 <strlen+0x26>
 306:	0505                	addi	a0,a0,1
 308:	87aa                	mv	a5,a0
 30a:	86be                	mv	a3,a5
 30c:	0785                	addi	a5,a5,1
 30e:	fff7c703          	lbu	a4,-1(a5)
 312:	ff65                	bnez	a4,30a <strlen+0x10>
 314:	40a6853b          	subw	a0,a3,a0
 318:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
    for (n = 0; s[n]; n++)
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strlen+0x20>

0000000000000324 <memset>:

void *
memset(void *dst, int c, uint n)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 32a:	ca19                	beqz	a2,340 <memset+0x1c>
 32c:	87aa                	mv	a5,a0
 32e:	1602                	slli	a2,a2,0x20
 330:	9201                	srli	a2,a2,0x20
 332:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 336:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 33a:	0785                	addi	a5,a5,1
 33c:	fee79de3          	bne	a5,a4,336 <memset+0x12>
    }
    return dst;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret

0000000000000346 <strchr>:

char *
strchr(const char *s, char c)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 34c:	00054783          	lbu	a5,0(a0)
 350:	cb99                	beqz	a5,366 <strchr+0x20>
        if (*s == c)
 352:	00f58763          	beq	a1,a5,360 <strchr+0x1a>
    for (; *s; s++)
 356:	0505                	addi	a0,a0,1
 358:	00054783          	lbu	a5,0(a0)
 35c:	fbfd                	bnez	a5,352 <strchr+0xc>
            return (char *)s;
    return 0;
 35e:	4501                	li	a0,0
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
    return 0;
 366:	4501                	li	a0,0
 368:	bfe5                	j	360 <strchr+0x1a>

000000000000036a <gets>:

char *
gets(char *buf, int max)
{
 36a:	711d                	addi	sp,sp,-96
 36c:	ec86                	sd	ra,88(sp)
 36e:	e8a2                	sd	s0,80(sp)
 370:	e4a6                	sd	s1,72(sp)
 372:	e0ca                	sd	s2,64(sp)
 374:	fc4e                	sd	s3,56(sp)
 376:	f852                	sd	s4,48(sp)
 378:	f456                	sd	s5,40(sp)
 37a:	f05a                	sd	s6,32(sp)
 37c:	ec5e                	sd	s7,24(sp)
 37e:	1080                	addi	s0,sp,96
 380:	8baa                	mv	s7,a0
 382:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 384:	892a                	mv	s2,a0
 386:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 388:	4aa9                	li	s5,10
 38a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 38c:	89a6                	mv	s3,s1
 38e:	2485                	addiw	s1,s1,1
 390:	0344d863          	bge	s1,s4,3c0 <gets+0x56>
        cc = read(0, &c, 1);
 394:	4605                	li	a2,1
 396:	faf40593          	addi	a1,s0,-81
 39a:	4501                	li	a0,0
 39c:	00000097          	auipc	ra,0x0
 3a0:	19a080e7          	jalr	410(ra) # 536 <read>
        if (cc < 1)
 3a4:	00a05e63          	blez	a0,3c0 <gets+0x56>
        buf[i++] = c;
 3a8:	faf44783          	lbu	a5,-81(s0)
 3ac:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3b0:	01578763          	beq	a5,s5,3be <gets+0x54>
 3b4:	0905                	addi	s2,s2,1
 3b6:	fd679be3          	bne	a5,s6,38c <gets+0x22>
    for (i = 0; i + 1 < max;)
 3ba:	89a6                	mv	s3,s1
 3bc:	a011                	j	3c0 <gets+0x56>
 3be:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3c0:	99de                	add	s3,s3,s7
 3c2:	00098023          	sb	zero,0(s3)
    return buf;
}
 3c6:	855e                	mv	a0,s7
 3c8:	60e6                	ld	ra,88(sp)
 3ca:	6446                	ld	s0,80(sp)
 3cc:	64a6                	ld	s1,72(sp)
 3ce:	6906                	ld	s2,64(sp)
 3d0:	79e2                	ld	s3,56(sp)
 3d2:	7a42                	ld	s4,48(sp)
 3d4:	7aa2                	ld	s5,40(sp)
 3d6:	7b02                	ld	s6,32(sp)
 3d8:	6be2                	ld	s7,24(sp)
 3da:	6125                	addi	sp,sp,96
 3dc:	8082                	ret

00000000000003de <stat>:

int stat(const char *n, struct stat *st)
{
 3de:	1101                	addi	sp,sp,-32
 3e0:	ec06                	sd	ra,24(sp)
 3e2:	e822                	sd	s0,16(sp)
 3e4:	e426                	sd	s1,8(sp)
 3e6:	e04a                	sd	s2,0(sp)
 3e8:	1000                	addi	s0,sp,32
 3ea:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3ec:	4581                	li	a1,0
 3ee:	00000097          	auipc	ra,0x0
 3f2:	170080e7          	jalr	368(ra) # 55e <open>
    if (fd < 0)
 3f6:	02054563          	bltz	a0,420 <stat+0x42>
 3fa:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3fc:	85ca                	mv	a1,s2
 3fe:	00000097          	auipc	ra,0x0
 402:	178080e7          	jalr	376(ra) # 576 <fstat>
 406:	892a                	mv	s2,a0
    close(fd);
 408:	8526                	mv	a0,s1
 40a:	00000097          	auipc	ra,0x0
 40e:	13c080e7          	jalr	316(ra) # 546 <close>
    return r;
}
 412:	854a                	mv	a0,s2
 414:	60e2                	ld	ra,24(sp)
 416:	6442                	ld	s0,16(sp)
 418:	64a2                	ld	s1,8(sp)
 41a:	6902                	ld	s2,0(sp)
 41c:	6105                	addi	sp,sp,32
 41e:	8082                	ret
        return -1;
 420:	597d                	li	s2,-1
 422:	bfc5                	j	412 <stat+0x34>

0000000000000424 <atoi>:

int atoi(const char *s)
{
 424:	1141                	addi	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 42a:	00054683          	lbu	a3,0(a0)
 42e:	fd06879b          	addiw	a5,a3,-48
 432:	0ff7f793          	zext.b	a5,a5
 436:	4625                	li	a2,9
 438:	02f66863          	bltu	a2,a5,468 <atoi+0x44>
 43c:	872a                	mv	a4,a0
    n = 0;
 43e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 440:	0705                	addi	a4,a4,1
 442:	0025179b          	slliw	a5,a0,0x2
 446:	9fa9                	addw	a5,a5,a0
 448:	0017979b          	slliw	a5,a5,0x1
 44c:	9fb5                	addw	a5,a5,a3
 44e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 452:	00074683          	lbu	a3,0(a4)
 456:	fd06879b          	addiw	a5,a3,-48
 45a:	0ff7f793          	zext.b	a5,a5
 45e:	fef671e3          	bgeu	a2,a5,440 <atoi+0x1c>
    return n;
}
 462:	6422                	ld	s0,8(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
    n = 0;
 468:	4501                	li	a0,0
 46a:	bfe5                	j	462 <atoi+0x3e>

000000000000046c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 472:	02b57463          	bgeu	a0,a1,49a <memmove+0x2e>
    {
        while (n-- > 0)
 476:	00c05f63          	blez	a2,494 <memmove+0x28>
 47a:	1602                	slli	a2,a2,0x20
 47c:	9201                	srli	a2,a2,0x20
 47e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 482:	872a                	mv	a4,a0
            *dst++ = *src++;
 484:	0585                	addi	a1,a1,1
 486:	0705                	addi	a4,a4,1
 488:	fff5c683          	lbu	a3,-1(a1)
 48c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 490:	fee79ae3          	bne	a5,a4,484 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
        dst += n;
 49a:	00c50733          	add	a4,a0,a2
        src += n;
 49e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 4a0:	fec05ae3          	blez	a2,494 <memmove+0x28>
 4a4:	fff6079b          	addiw	a5,a2,-1
 4a8:	1782                	slli	a5,a5,0x20
 4aa:	9381                	srli	a5,a5,0x20
 4ac:	fff7c793          	not	a5,a5
 4b0:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4b2:	15fd                	addi	a1,a1,-1
 4b4:	177d                	addi	a4,a4,-1
 4b6:	0005c683          	lbu	a3,0(a1)
 4ba:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4be:	fee79ae3          	bne	a5,a4,4b2 <memmove+0x46>
 4c2:	bfc9                	j	494 <memmove+0x28>

00000000000004c4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e422                	sd	s0,8(sp)
 4c8:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4ca:	ca05                	beqz	a2,4fa <memcmp+0x36>
 4cc:	fff6069b          	addiw	a3,a2,-1
 4d0:	1682                	slli	a3,a3,0x20
 4d2:	9281                	srli	a3,a3,0x20
 4d4:	0685                	addi	a3,a3,1
 4d6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4d8:	00054783          	lbu	a5,0(a0)
 4dc:	0005c703          	lbu	a4,0(a1)
 4e0:	00e79863          	bne	a5,a4,4f0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4e4:	0505                	addi	a0,a0,1
        p2++;
 4e6:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4e8:	fed518e3          	bne	a0,a3,4d8 <memcmp+0x14>
    }
    return 0;
 4ec:	4501                	li	a0,0
 4ee:	a019                	j	4f4 <memcmp+0x30>
            return *p1 - *p2;
 4f0:	40e7853b          	subw	a0,a5,a4
}
 4f4:	6422                	ld	s0,8(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret
    return 0;
 4fa:	4501                	li	a0,0
 4fc:	bfe5                	j	4f4 <memcmp+0x30>

00000000000004fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fe:	1141                	addi	sp,sp,-16
 500:	e406                	sd	ra,8(sp)
 502:	e022                	sd	s0,0(sp)
 504:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 506:	00000097          	auipc	ra,0x0
 50a:	f66080e7          	jalr	-154(ra) # 46c <memmove>
}
 50e:	60a2                	ld	ra,8(sp)
 510:	6402                	ld	s0,0(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret

0000000000000516 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 516:	4885                	li	a7,1
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <exit>:
.global exit
exit:
 li a7, SYS_exit
 51e:	4889                	li	a7,2
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <wait>:
.global wait
wait:
 li a7, SYS_wait
 526:	488d                	li	a7,3
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52e:	4891                	li	a7,4
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <read>:
.global read
read:
 li a7, SYS_read
 536:	4895                	li	a7,5
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <write>:
.global write
write:
 li a7, SYS_write
 53e:	48c1                	li	a7,16
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <close>:
.global close
close:
 li a7, SYS_close
 546:	48d5                	li	a7,21
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <kill>:
.global kill
kill:
 li a7, SYS_kill
 54e:	4899                	li	a7,6
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <exec>:
.global exec
exec:
 li a7, SYS_exec
 556:	489d                	li	a7,7
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <open>:
.global open
open:
 li a7, SYS_open
 55e:	48bd                	li	a7,15
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 566:	48c5                	li	a7,17
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56e:	48c9                	li	a7,18
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 576:	48a1                	li	a7,8
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <link>:
.global link
link:
 li a7, SYS_link
 57e:	48cd                	li	a7,19
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 586:	48d1                	li	a7,20
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58e:	48a5                	li	a7,9
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <dup>:
.global dup
dup:
 li a7, SYS_dup
 596:	48a9                	li	a7,10
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59e:	48ad                	li	a7,11
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a6:	48b1                	li	a7,12
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ae:	48b5                	li	a7,13
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b6:	48b9                	li	a7,14
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <ps>:
.global ps
ps:
 li a7, SYS_ps
 5be:	48d9                	li	a7,22
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5c6:	48dd                	li	a7,23
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5ce:	48e1                	li	a7,24
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d6:	1101                	addi	sp,sp,-32
 5d8:	ec06                	sd	ra,24(sp)
 5da:	e822                	sd	s0,16(sp)
 5dc:	1000                	addi	s0,sp,32
 5de:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e2:	4605                	li	a2,1
 5e4:	fef40593          	addi	a1,s0,-17
 5e8:	00000097          	auipc	ra,0x0
 5ec:	f56080e7          	jalr	-170(ra) # 53e <write>
}
 5f0:	60e2                	ld	ra,24(sp)
 5f2:	6442                	ld	s0,16(sp)
 5f4:	6105                	addi	sp,sp,32
 5f6:	8082                	ret

00000000000005f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f8:	7139                	addi	sp,sp,-64
 5fa:	fc06                	sd	ra,56(sp)
 5fc:	f822                	sd	s0,48(sp)
 5fe:	f426                	sd	s1,40(sp)
 600:	f04a                	sd	s2,32(sp)
 602:	ec4e                	sd	s3,24(sp)
 604:	0080                	addi	s0,sp,64
 606:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 608:	c299                	beqz	a3,60e <printint+0x16>
 60a:	0805c963          	bltz	a1,69c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 60e:	2581                	sext.w	a1,a1
  neg = 0;
 610:	4881                	li	a7,0
 612:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 616:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 618:	2601                	sext.w	a2,a2
 61a:	00000517          	auipc	a0,0x0
 61e:	4ee50513          	addi	a0,a0,1262 # b08 <digits>
 622:	883a                	mv	a6,a4
 624:	2705                	addiw	a4,a4,1
 626:	02c5f7bb          	remuw	a5,a1,a2
 62a:	1782                	slli	a5,a5,0x20
 62c:	9381                	srli	a5,a5,0x20
 62e:	97aa                	add	a5,a5,a0
 630:	0007c783          	lbu	a5,0(a5)
 634:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 638:	0005879b          	sext.w	a5,a1
 63c:	02c5d5bb          	divuw	a1,a1,a2
 640:	0685                	addi	a3,a3,1
 642:	fec7f0e3          	bgeu	a5,a2,622 <printint+0x2a>
  if(neg)
 646:	00088c63          	beqz	a7,65e <printint+0x66>
    buf[i++] = '-';
 64a:	fd070793          	addi	a5,a4,-48
 64e:	00878733          	add	a4,a5,s0
 652:	02d00793          	li	a5,45
 656:	fef70823          	sb	a5,-16(a4)
 65a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 65e:	02e05863          	blez	a4,68e <printint+0x96>
 662:	fc040793          	addi	a5,s0,-64
 666:	00e78933          	add	s2,a5,a4
 66a:	fff78993          	addi	s3,a5,-1
 66e:	99ba                	add	s3,s3,a4
 670:	377d                	addiw	a4,a4,-1
 672:	1702                	slli	a4,a4,0x20
 674:	9301                	srli	a4,a4,0x20
 676:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67a:	fff94583          	lbu	a1,-1(s2)
 67e:	8526                	mv	a0,s1
 680:	00000097          	auipc	ra,0x0
 684:	f56080e7          	jalr	-170(ra) # 5d6 <putc>
  while(--i >= 0)
 688:	197d                	addi	s2,s2,-1
 68a:	ff3918e3          	bne	s2,s3,67a <printint+0x82>
}
 68e:	70e2                	ld	ra,56(sp)
 690:	7442                	ld	s0,48(sp)
 692:	74a2                	ld	s1,40(sp)
 694:	7902                	ld	s2,32(sp)
 696:	69e2                	ld	s3,24(sp)
 698:	6121                	addi	sp,sp,64
 69a:	8082                	ret
    x = -xx;
 69c:	40b005bb          	negw	a1,a1
    neg = 1;
 6a0:	4885                	li	a7,1
    x = -xx;
 6a2:	bf85                	j	612 <printint+0x1a>

00000000000006a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a4:	715d                	addi	sp,sp,-80
 6a6:	e486                	sd	ra,72(sp)
 6a8:	e0a2                	sd	s0,64(sp)
 6aa:	fc26                	sd	s1,56(sp)
 6ac:	f84a                	sd	s2,48(sp)
 6ae:	f44e                	sd	s3,40(sp)
 6b0:	f052                	sd	s4,32(sp)
 6b2:	ec56                	sd	s5,24(sp)
 6b4:	e85a                	sd	s6,16(sp)
 6b6:	e45e                	sd	s7,8(sp)
 6b8:	e062                	sd	s8,0(sp)
 6ba:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6bc:	0005c903          	lbu	s2,0(a1)
 6c0:	18090c63          	beqz	s2,858 <vprintf+0x1b4>
 6c4:	8aaa                	mv	s5,a0
 6c6:	8bb2                	mv	s7,a2
 6c8:	00158493          	addi	s1,a1,1
  state = 0;
 6cc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ce:	02500a13          	li	s4,37
 6d2:	4b55                	li	s6,21
 6d4:	a839                	j	6f2 <vprintf+0x4e>
        putc(fd, c);
 6d6:	85ca                	mv	a1,s2
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	efc080e7          	jalr	-260(ra) # 5d6 <putc>
 6e2:	a019                	j	6e8 <vprintf+0x44>
    } else if(state == '%'){
 6e4:	01498d63          	beq	s3,s4,6fe <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6e8:	0485                	addi	s1,s1,1
 6ea:	fff4c903          	lbu	s2,-1(s1)
 6ee:	16090563          	beqz	s2,858 <vprintf+0x1b4>
    if(state == 0){
 6f2:	fe0999e3          	bnez	s3,6e4 <vprintf+0x40>
      if(c == '%'){
 6f6:	ff4910e3          	bne	s2,s4,6d6 <vprintf+0x32>
        state = '%';
 6fa:	89d2                	mv	s3,s4
 6fc:	b7f5                	j	6e8 <vprintf+0x44>
      if(c == 'd'){
 6fe:	13490263          	beq	s2,s4,822 <vprintf+0x17e>
 702:	f9d9079b          	addiw	a5,s2,-99
 706:	0ff7f793          	zext.b	a5,a5
 70a:	12fb6563          	bltu	s6,a5,834 <vprintf+0x190>
 70e:	f9d9079b          	addiw	a5,s2,-99
 712:	0ff7f713          	zext.b	a4,a5
 716:	10eb6f63          	bltu	s6,a4,834 <vprintf+0x190>
 71a:	00271793          	slli	a5,a4,0x2
 71e:	00000717          	auipc	a4,0x0
 722:	39270713          	addi	a4,a4,914 # ab0 <malloc+0x15a>
 726:	97ba                	add	a5,a5,a4
 728:	439c                	lw	a5,0(a5)
 72a:	97ba                	add	a5,a5,a4
 72c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 72e:	008b8913          	addi	s2,s7,8
 732:	4685                	li	a3,1
 734:	4629                	li	a2,10
 736:	000ba583          	lw	a1,0(s7)
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	ebc080e7          	jalr	-324(ra) # 5f8 <printint>
 744:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 746:	4981                	li	s3,0
 748:	b745                	j	6e8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	008b8913          	addi	s2,s7,8
 74e:	4681                	li	a3,0
 750:	4629                	li	a2,10
 752:	000ba583          	lw	a1,0(s7)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	ea0080e7          	jalr	-352(ra) # 5f8 <printint>
 760:	8bca                	mv	s7,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	b751                	j	6e8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 766:	008b8913          	addi	s2,s7,8
 76a:	4681                	li	a3,0
 76c:	4641                	li	a2,16
 76e:	000ba583          	lw	a1,0(s7)
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e84080e7          	jalr	-380(ra) # 5f8 <printint>
 77c:	8bca                	mv	s7,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	b7a5                	j	6e8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 782:	008b8c13          	addi	s8,s7,8
 786:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 78a:	03000593          	li	a1,48
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e46080e7          	jalr	-442(ra) # 5d6 <putc>
  putc(fd, 'x');
 798:	07800593          	li	a1,120
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	e38080e7          	jalr	-456(ra) # 5d6 <putc>
 7a6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a8:	00000b97          	auipc	s7,0x0
 7ac:	360b8b93          	addi	s7,s7,864 # b08 <digits>
 7b0:	03c9d793          	srli	a5,s3,0x3c
 7b4:	97de                	add	a5,a5,s7
 7b6:	0007c583          	lbu	a1,0(a5)
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e1a080e7          	jalr	-486(ra) # 5d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c4:	0992                	slli	s3,s3,0x4
 7c6:	397d                	addiw	s2,s2,-1
 7c8:	fe0914e3          	bnez	s2,7b0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7cc:	8be2                	mv	s7,s8
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bf21                	j	6e8 <vprintf+0x44>
        s = va_arg(ap, char*);
 7d2:	008b8993          	addi	s3,s7,8
 7d6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7da:	02090163          	beqz	s2,7fc <vprintf+0x158>
        while(*s != 0){
 7de:	00094583          	lbu	a1,0(s2)
 7e2:	c9a5                	beqz	a1,852 <vprintf+0x1ae>
          putc(fd, *s);
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	df0080e7          	jalr	-528(ra) # 5d6 <putc>
          s++;
 7ee:	0905                	addi	s2,s2,1
        while(*s != 0){
 7f0:	00094583          	lbu	a1,0(s2)
 7f4:	f9e5                	bnez	a1,7e4 <vprintf+0x140>
        s = va_arg(ap, char*);
 7f6:	8bce                	mv	s7,s3
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b5fd                	j	6e8 <vprintf+0x44>
          s = "(null)";
 7fc:	00000917          	auipc	s2,0x0
 800:	2ac90913          	addi	s2,s2,684 # aa8 <malloc+0x152>
        while(*s != 0){
 804:	02800593          	li	a1,40
 808:	bff1                	j	7e4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 80a:	008b8913          	addi	s2,s7,8
 80e:	000bc583          	lbu	a1,0(s7)
 812:	8556                	mv	a0,s5
 814:	00000097          	auipc	ra,0x0
 818:	dc2080e7          	jalr	-574(ra) # 5d6 <putc>
 81c:	8bca                	mv	s7,s2
      state = 0;
 81e:	4981                	li	s3,0
 820:	b5e1                	j	6e8 <vprintf+0x44>
        putc(fd, c);
 822:	02500593          	li	a1,37
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	dae080e7          	jalr	-594(ra) # 5d6 <putc>
      state = 0;
 830:	4981                	li	s3,0
 832:	bd5d                	j	6e8 <vprintf+0x44>
        putc(fd, '%');
 834:	02500593          	li	a1,37
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	d9c080e7          	jalr	-612(ra) # 5d6 <putc>
        putc(fd, c);
 842:	85ca                	mv	a1,s2
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	d90080e7          	jalr	-624(ra) # 5d6 <putc>
      state = 0;
 84e:	4981                	li	s3,0
 850:	bd61                	j	6e8 <vprintf+0x44>
        s = va_arg(ap, char*);
 852:	8bce                	mv	s7,s3
      state = 0;
 854:	4981                	li	s3,0
 856:	bd49                	j	6e8 <vprintf+0x44>
    }
  }
}
 858:	60a6                	ld	ra,72(sp)
 85a:	6406                	ld	s0,64(sp)
 85c:	74e2                	ld	s1,56(sp)
 85e:	7942                	ld	s2,48(sp)
 860:	79a2                	ld	s3,40(sp)
 862:	7a02                	ld	s4,32(sp)
 864:	6ae2                	ld	s5,24(sp)
 866:	6b42                	ld	s6,16(sp)
 868:	6ba2                	ld	s7,8(sp)
 86a:	6c02                	ld	s8,0(sp)
 86c:	6161                	addi	sp,sp,80
 86e:	8082                	ret

0000000000000870 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 870:	715d                	addi	sp,sp,-80
 872:	ec06                	sd	ra,24(sp)
 874:	e822                	sd	s0,16(sp)
 876:	1000                	addi	s0,sp,32
 878:	e010                	sd	a2,0(s0)
 87a:	e414                	sd	a3,8(s0)
 87c:	e818                	sd	a4,16(s0)
 87e:	ec1c                	sd	a5,24(s0)
 880:	03043023          	sd	a6,32(s0)
 884:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 888:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88c:	8622                	mv	a2,s0
 88e:	00000097          	auipc	ra,0x0
 892:	e16080e7          	jalr	-490(ra) # 6a4 <vprintf>
}
 896:	60e2                	ld	ra,24(sp)
 898:	6442                	ld	s0,16(sp)
 89a:	6161                	addi	sp,sp,80
 89c:	8082                	ret

000000000000089e <printf>:

void
printf(const char *fmt, ...)
{
 89e:	711d                	addi	sp,sp,-96
 8a0:	ec06                	sd	ra,24(sp)
 8a2:	e822                	sd	s0,16(sp)
 8a4:	1000                	addi	s0,sp,32
 8a6:	e40c                	sd	a1,8(s0)
 8a8:	e810                	sd	a2,16(s0)
 8aa:	ec14                	sd	a3,24(s0)
 8ac:	f018                	sd	a4,32(s0)
 8ae:	f41c                	sd	a5,40(s0)
 8b0:	03043823          	sd	a6,48(s0)
 8b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b8:	00840613          	addi	a2,s0,8
 8bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8c0:	85aa                	mv	a1,a0
 8c2:	4505                	li	a0,1
 8c4:	00000097          	auipc	ra,0x0
 8c8:	de0080e7          	jalr	-544(ra) # 6a4 <vprintf>
}
 8cc:	60e2                	ld	ra,24(sp)
 8ce:	6442                	ld	s0,16(sp)
 8d0:	6125                	addi	sp,sp,96
 8d2:	8082                	ret

00000000000008d4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8d4:	1141                	addi	sp,sp,-16
 8d6:	e422                	sd	s0,8(sp)
 8d8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8da:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8de:	00000797          	auipc	a5,0x0
 8e2:	72a7b783          	ld	a5,1834(a5) # 1008 <freep>
 8e6:	a02d                	j	910 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8e8:	4618                	lw	a4,8(a2)
 8ea:	9f2d                	addw	a4,a4,a1
 8ec:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	6310                	ld	a2,0(a4)
 8f4:	a83d                	j	932 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8f6:	ff852703          	lw	a4,-8(a0)
 8fa:	9f31                	addw	a4,a4,a2
 8fc:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8fe:	ff053683          	ld	a3,-16(a0)
 902:	a091                	j	946 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 904:	6398                	ld	a4,0(a5)
 906:	00e7e463          	bltu	a5,a4,90e <free+0x3a>
 90a:	00e6ea63          	bltu	a3,a4,91e <free+0x4a>
{
 90e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 910:	fed7fae3          	bgeu	a5,a3,904 <free+0x30>
 914:	6398                	ld	a4,0(a5)
 916:	00e6e463          	bltu	a3,a4,91e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91a:	fee7eae3          	bltu	a5,a4,90e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 91e:	ff852583          	lw	a1,-8(a0)
 922:	6390                	ld	a2,0(a5)
 924:	02059813          	slli	a6,a1,0x20
 928:	01c85713          	srli	a4,a6,0x1c
 92c:	9736                	add	a4,a4,a3
 92e:	fae60de3          	beq	a2,a4,8e8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 932:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 936:	4790                	lw	a2,8(a5)
 938:	02061593          	slli	a1,a2,0x20
 93c:	01c5d713          	srli	a4,a1,0x1c
 940:	973e                	add	a4,a4,a5
 942:	fae68ae3          	beq	a3,a4,8f6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 946:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 948:	00000717          	auipc	a4,0x0
 94c:	6cf73023          	sd	a5,1728(a4) # 1008 <freep>
}
 950:	6422                	ld	s0,8(sp)
 952:	0141                	addi	sp,sp,16
 954:	8082                	ret

0000000000000956 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 956:	7139                	addi	sp,sp,-64
 958:	fc06                	sd	ra,56(sp)
 95a:	f822                	sd	s0,48(sp)
 95c:	f426                	sd	s1,40(sp)
 95e:	f04a                	sd	s2,32(sp)
 960:	ec4e                	sd	s3,24(sp)
 962:	e852                	sd	s4,16(sp)
 964:	e456                	sd	s5,8(sp)
 966:	e05a                	sd	s6,0(sp)
 968:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 96a:	02051493          	slli	s1,a0,0x20
 96e:	9081                	srli	s1,s1,0x20
 970:	04bd                	addi	s1,s1,15
 972:	8091                	srli	s1,s1,0x4
 974:	0014899b          	addiw	s3,s1,1
 978:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 97a:	00000517          	auipc	a0,0x0
 97e:	68e53503          	ld	a0,1678(a0) # 1008 <freep>
 982:	c515                	beqz	a0,9ae <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 984:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 986:	4798                	lw	a4,8(a5)
 988:	02977f63          	bgeu	a4,s1,9c6 <malloc+0x70>
    if (nu < 4096)
 98c:	8a4e                	mv	s4,s3
 98e:	0009871b          	sext.w	a4,s3
 992:	6685                	lui	a3,0x1
 994:	00d77363          	bgeu	a4,a3,99a <malloc+0x44>
 998:	6a05                	lui	s4,0x1
 99a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 99e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 9a2:	00000917          	auipc	s2,0x0
 9a6:	66690913          	addi	s2,s2,1638 # 1008 <freep>
    if (p == (char *)-1)
 9aa:	5afd                	li	s5,-1
 9ac:	a895                	j	a20 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9ae:	00000797          	auipc	a5,0x0
 9b2:	66278793          	addi	a5,a5,1634 # 1010 <base>
 9b6:	00000717          	auipc	a4,0x0
 9ba:	64f73923          	sd	a5,1618(a4) # 1008 <freep>
 9be:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9c0:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9c4:	b7e1                	j	98c <malloc+0x36>
            if (p->s.size == nunits)
 9c6:	02e48c63          	beq	s1,a4,9fe <malloc+0xa8>
                p->s.size -= nunits;
 9ca:	4137073b          	subw	a4,a4,s3
 9ce:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9d0:	02071693          	slli	a3,a4,0x20
 9d4:	01c6d713          	srli	a4,a3,0x1c
 9d8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9da:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9de:	00000717          	auipc	a4,0x0
 9e2:	62a73523          	sd	a0,1578(a4) # 1008 <freep>
            return (void *)(p + 1);
 9e6:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9ea:	70e2                	ld	ra,56(sp)
 9ec:	7442                	ld	s0,48(sp)
 9ee:	74a2                	ld	s1,40(sp)
 9f0:	7902                	ld	s2,32(sp)
 9f2:	69e2                	ld	s3,24(sp)
 9f4:	6a42                	ld	s4,16(sp)
 9f6:	6aa2                	ld	s5,8(sp)
 9f8:	6b02                	ld	s6,0(sp)
 9fa:	6121                	addi	sp,sp,64
 9fc:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9fe:	6398                	ld	a4,0(a5)
 a00:	e118                	sd	a4,0(a0)
 a02:	bff1                	j	9de <malloc+0x88>
    hp->s.size = nu;
 a04:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a08:	0541                	addi	a0,a0,16
 a0a:	00000097          	auipc	ra,0x0
 a0e:	eca080e7          	jalr	-310(ra) # 8d4 <free>
    return freep;
 a12:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a16:	d971                	beqz	a0,9ea <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a18:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a1a:	4798                	lw	a4,8(a5)
 a1c:	fa9775e3          	bgeu	a4,s1,9c6 <malloc+0x70>
        if (p == freep)
 a20:	00093703          	ld	a4,0(s2)
 a24:	853e                	mv	a0,a5
 a26:	fef719e3          	bne	a4,a5,a18 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a2a:	8552                	mv	a0,s4
 a2c:	00000097          	auipc	ra,0x0
 a30:	b7a080e7          	jalr	-1158(ra) # 5a6 <sbrk>
    if (p == (char *)-1)
 a34:	fd5518e3          	bne	a0,s5,a04 <malloc+0xae>
                return 0;
 a38:	4501                	li	a0,0
 a3a:	bf45                	j	9ea <malloc+0x94>
