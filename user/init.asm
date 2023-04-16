
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"

char *argv[] = {"sh", 0};

int main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    int pid, wpid;

    if (open("console", O_RDWR) < 0)
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	ac250513          	addi	a0,a0,-1342 # ad0 <malloc+0xe6>
  16:	00000097          	auipc	ra,0x0
  1a:	5dc080e7          	jalr	1500(ra) # 5f2 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    {
        mknod("console", CONSOLE, 0);
        open("console", O_RDWR);
    }
    dup(0); // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	606080e7          	jalr	1542(ra) # 62a <dup>
    dup(0); // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	5fc080e7          	jalr	1532(ra) # 62a <dup>

    for (;;)
    {
        printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	aa290913          	addi	s2,s2,-1374 # ad8 <malloc+0xee>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	8f2080e7          	jalr	-1806(ra) # 932 <printf>
        pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	562080e7          	jalr	1378(ra) # 5aa <fork>
  50:	84aa                	mv	s1,a0
        if (pid < 0)
  52:	04054d63          	bltz	a0,ac <main+0xac>
        {
            printf("init: fork failed\n");
            exit(1);
        }
        if (pid == 0)
  56:	c925                	beqz	a0,c6 <main+0xc6>

        for (;;)
        {
            // this call to wait() returns if the shell exits,
            // or if a parentless process exits.
            wpid = wait((int *)0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	560080e7          	jalr	1376(ra) # 5ba <wait>
            if (wpid == pid)
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
            {
                // the shell exited; restart it.
                break;
            }
            else if (wpid < 0)
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
            {
                printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	abe50513          	addi	a0,a0,-1346 # b28 <malloc+0x13e>
  72:	00001097          	auipc	ra,0x1
  76:	8c0080e7          	jalr	-1856(ra) # 932 <printf>
                exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	536080e7          	jalr	1334(ra) # 5b2 <exit>
        mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	a4850513          	addi	a0,a0,-1464 # ad0 <malloc+0xe6>
  90:	00000097          	auipc	ra,0x0
  94:	56a080e7          	jalr	1386(ra) # 5fa <mknod>
        open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	a3650513          	addi	a0,a0,-1482 # ad0 <malloc+0xe6>
  a2:	00000097          	auipc	ra,0x0
  a6:	550080e7          	jalr	1360(ra) # 5f2 <open>
  aa:	bfa5                	j	22 <main+0x22>
            printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	a4450513          	addi	a0,a0,-1468 # af0 <malloc+0x106>
  b4:	00001097          	auipc	ra,0x1
  b8:	87e080e7          	jalr	-1922(ra) # 932 <printf>
            exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	4f4080e7          	jalr	1268(ra) # 5b2 <exit>
            exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	addi	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	a3a50513          	addi	a0,a0,-1478 # b08 <malloc+0x11e>
  d6:	00000097          	auipc	ra,0x0
  da:	514080e7          	jalr	1300(ra) # 5ea <exec>
            printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	a3250513          	addi	a0,a0,-1486 # b10 <malloc+0x126>
  e6:	00001097          	auipc	ra,0x1
  ea:	84c080e7          	jalr	-1972(ra) # 932 <printf>
            exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	4c2080e7          	jalr	1218(ra) # 5b2 <exit>

00000000000000f8 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
    lk->name = name;
  fe:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 100:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 104:	57fd                	li	a5,-1
 106:	00f50823          	sb	a5,16(a0)
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 110:	00054783          	lbu	a5,0(a0)
 114:	e399                	bnez	a5,11a <holding+0xa>
 116:	4501                	li	a0,0
}
 118:	8082                	ret
{
 11a:	1101                	addi	sp,sp,-32
 11c:	ec06                	sd	ra,24(sp)
 11e:	e822                	sd	s0,16(sp)
 120:	e426                	sd	s1,8(sp)
 122:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 124:	01054483          	lbu	s1,16(a0)
 128:	00000097          	auipc	ra,0x0
 12c:	172080e7          	jalr	370(ra) # 29a <twhoami>
 130:	2501                	sext.w	a0,a0
 132:	40a48533          	sub	a0,s1,a0
 136:	00153513          	seqz	a0,a0
}
 13a:	60e2                	ld	ra,24(sp)
 13c:	6442                	ld	s0,16(sp)
 13e:	64a2                	ld	s1,8(sp)
 140:	6105                	addi	sp,sp,32
 142:	8082                	ret

0000000000000144 <acquire>:

void acquire(struct lock *lk)
{
 144:	7179                	addi	sp,sp,-48
 146:	f406                	sd	ra,40(sp)
 148:	f022                	sd	s0,32(sp)
 14a:	ec26                	sd	s1,24(sp)
 14c:	e84a                	sd	s2,16(sp)
 14e:	e44e                	sd	s3,8(sp)
 150:	e052                	sd	s4,0(sp)
 152:	1800                	addi	s0,sp,48
 154:	8a2a                	mv	s4,a0
    if (holding(lk))
 156:	00000097          	auipc	ra,0x0
 15a:	fba080e7          	jalr	-70(ra) # 110 <holding>
 15e:	e919                	bnez	a0,174 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 160:	ffca7493          	andi	s1,s4,-4
 164:	003a7913          	andi	s2,s4,3
 168:	0039191b          	slliw	s2,s2,0x3
 16c:	4985                	li	s3,1
 16e:	012999bb          	sllw	s3,s3,s2
 172:	a015                	j	196 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 174:	00001517          	auipc	a0,0x1
 178:	9d450513          	addi	a0,a0,-1580 # b48 <malloc+0x15e>
 17c:	00000097          	auipc	ra,0x0
 180:	7b6080e7          	jalr	1974(ra) # 932 <printf>
        exit(-1);
 184:	557d                	li	a0,-1
 186:	00000097          	auipc	ra,0x0
 18a:	42c080e7          	jalr	1068(ra) # 5b2 <exit>
    {
        // give up the cpu for other threads
        tyield();
 18e:	00000097          	auipc	ra,0x0
 192:	0f4080e7          	jalr	244(ra) # 282 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 196:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 19a:	0127d7bb          	srlw	a5,a5,s2
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	f7f5                	bnez	a5,18e <acquire+0x4a>
    }

    __sync_synchronize();
 1a4:	0ff0000f          	fence

    lk->tid = twhoami();
 1a8:	00000097          	auipc	ra,0x0
 1ac:	0f2080e7          	jalr	242(ra) # 29a <twhoami>
 1b0:	00aa0823          	sb	a0,16(s4)
}
 1b4:	70a2                	ld	ra,40(sp)
 1b6:	7402                	ld	s0,32(sp)
 1b8:	64e2                	ld	s1,24(sp)
 1ba:	6942                	ld	s2,16(sp)
 1bc:	69a2                	ld	s3,8(sp)
 1be:	6a02                	ld	s4,0(sp)
 1c0:	6145                	addi	sp,sp,48
 1c2:	8082                	ret

00000000000001c4 <release>:

void release(struct lock *lk)
{
 1c4:	1101                	addi	sp,sp,-32
 1c6:	ec06                	sd	ra,24(sp)
 1c8:	e822                	sd	s0,16(sp)
 1ca:	e426                	sd	s1,8(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	84aa                	mv	s1,a0
    if (!holding(lk))
 1d0:	00000097          	auipc	ra,0x0
 1d4:	f40080e7          	jalr	-192(ra) # 110 <holding>
 1d8:	c11d                	beqz	a0,1fe <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1da:	57fd                	li	a5,-1
 1dc:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1e0:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1e4:	0ff0000f          	fence
 1e8:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1ec:	00000097          	auipc	ra,0x0
 1f0:	096080e7          	jalr	150(ra) # 282 <tyield>
}
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
        printf("releasing lock we are not holding");
 1fe:	00001517          	auipc	a0,0x1
 202:	97250513          	addi	a0,a0,-1678 # b70 <malloc+0x186>
 206:	00000097          	auipc	ra,0x0
 20a:	72c080e7          	jalr	1836(ra) # 932 <printf>
        exit(-1);
 20e:	557d                	li	a0,-1
 210:	00000097          	auipc	ra,0x0
 214:	3a2080e7          	jalr	930(ra) # 5b2 <exit>

0000000000000218 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 21e:	00001717          	auipc	a4,0x1
 222:	df273703          	ld	a4,-526(a4) # 1010 <current_thread>
 226:	47c1                	li	a5,16
 228:	c319                	beqz	a4,22e <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 22a:	37fd                	addiw	a5,a5,-1
 22c:	fff5                	bnez	a5,228 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 234:	7179                	addi	sp,sp,-48
 236:	f406                	sd	ra,40(sp)
 238:	f022                	sd	s0,32(sp)
 23a:	ec26                	sd	s1,24(sp)
 23c:	e84a                	sd	s2,16(sp)
 23e:	e44e                	sd	s3,8(sp)
 240:	1800                	addi	s0,sp,48
 242:	84aa                	mv	s1,a0
 244:	89b2                	mv	s3,a2
 246:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 248:	09000513          	li	a0,144
 24c:	00000097          	auipc	ra,0x0
 250:	79e080e7          	jalr	1950(ra) # 9ea <malloc>
 254:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 256:	478d                	li	a5,3
 258:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 25a:	609c                	ld	a5,0(s1)
 25c:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 260:	609c                	ld	a5,0(s1)
 262:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 266:	70a2                	ld	ra,40(sp)
 268:	7402                	ld	s0,32(sp)
 26a:	64e2                	ld	s1,24(sp)
 26c:	6942                	ld	s2,16(sp)
 26e:	69a2                	ld	s3,8(sp)
 270:	6145                	addi	sp,sp,48
 272:	8082                	ret

0000000000000274 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 274:	1141                	addi	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 27a:	4501                	li	a0,0
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret

0000000000000282 <tyield>:

void tyield()
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 288:	00001797          	auipc	a5,0x1
 28c:	d887b783          	ld	a5,-632(a5) # 1010 <current_thread>
 290:	470d                	li	a4,3
 292:	dfb8                	sw	a4,120(a5)
    tsched();
}
 294:	6422                	ld	s0,8(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret

000000000000029a <twhoami>:

uint8 twhoami()
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 2a0:	4501                	li	a0,0
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <tswtch>:
 2a8:	00153023          	sd	ra,0(a0)
 2ac:	00253423          	sd	sp,8(a0)
 2b0:	e900                	sd	s0,16(a0)
 2b2:	ed04                	sd	s1,24(a0)
 2b4:	03253023          	sd	s2,32(a0)
 2b8:	03353423          	sd	s3,40(a0)
 2bc:	03453823          	sd	s4,48(a0)
 2c0:	03553c23          	sd	s5,56(a0)
 2c4:	05653023          	sd	s6,64(a0)
 2c8:	05753423          	sd	s7,72(a0)
 2cc:	05853823          	sd	s8,80(a0)
 2d0:	05953c23          	sd	s9,88(a0)
 2d4:	07a53023          	sd	s10,96(a0)
 2d8:	07b53423          	sd	s11,104(a0)
 2dc:	0005b083          	ld	ra,0(a1)
 2e0:	0085b103          	ld	sp,8(a1)
 2e4:	6980                	ld	s0,16(a1)
 2e6:	6d84                	ld	s1,24(a1)
 2e8:	0205b903          	ld	s2,32(a1)
 2ec:	0285b983          	ld	s3,40(a1)
 2f0:	0305ba03          	ld	s4,48(a1)
 2f4:	0385ba83          	ld	s5,56(a1)
 2f8:	0405bb03          	ld	s6,64(a1)
 2fc:	0485bb83          	ld	s7,72(a1)
 300:	0505bc03          	ld	s8,80(a1)
 304:	0585bc83          	ld	s9,88(a1)
 308:	0605bd03          	ld	s10,96(a1)
 30c:	0685bd83          	ld	s11,104(a1)
 310:	8082                	ret

0000000000000312 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 312:	1101                	addi	sp,sp,-32
 314:	ec06                	sd	ra,24(sp)
 316:	e822                	sd	s0,16(sp)
 318:	e426                	sd	s1,8(sp)
 31a:	e04a                	sd	s2,0(sp)
 31c:	1000                	addi	s0,sp,32
 31e:	84aa                	mv	s1,a0
 320:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 322:	09000513          	li	a0,144
 326:	00000097          	auipc	ra,0x0
 32a:	6c4080e7          	jalr	1732(ra) # 9ea <malloc>

    main_thread->tid = 0;
 32e:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 332:	85ca                	mv	a1,s2
 334:	8526                	mv	a0,s1
 336:	00000097          	auipc	ra,0x0
 33a:	cca080e7          	jalr	-822(ra) # 0 <main>
    exit(res);
 33e:	00000097          	auipc	ra,0x0
 342:	274080e7          	jalr	628(ra) # 5b2 <exit>

0000000000000346 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 34c:	87aa                	mv	a5,a0
 34e:	0585                	addi	a1,a1,1
 350:	0785                	addi	a5,a5,1
 352:	fff5c703          	lbu	a4,-1(a1)
 356:	fee78fa3          	sb	a4,-1(a5)
 35a:	fb75                	bnez	a4,34e <strcpy+0x8>
        ;
    return os;
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <strcmp>:

int strcmp(const char *p, const char *q)
{
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 368:	00054783          	lbu	a5,0(a0)
 36c:	cb91                	beqz	a5,380 <strcmp+0x1e>
 36e:	0005c703          	lbu	a4,0(a1)
 372:	00f71763          	bne	a4,a5,380 <strcmp+0x1e>
        p++, q++;
 376:	0505                	addi	a0,a0,1
 378:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 37a:	00054783          	lbu	a5,0(a0)
 37e:	fbe5                	bnez	a5,36e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 380:	0005c503          	lbu	a0,0(a1)
}
 384:	40a7853b          	subw	a0,a5,a0
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret

000000000000038e <strlen>:

uint strlen(const char *s)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 394:	00054783          	lbu	a5,0(a0)
 398:	cf91                	beqz	a5,3b4 <strlen+0x26>
 39a:	0505                	addi	a0,a0,1
 39c:	87aa                	mv	a5,a0
 39e:	86be                	mv	a3,a5
 3a0:	0785                	addi	a5,a5,1
 3a2:	fff7c703          	lbu	a4,-1(a5)
 3a6:	ff65                	bnez	a4,39e <strlen+0x10>
 3a8:	40a6853b          	subw	a0,a3,a0
 3ac:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
    for (n = 0; s[n]; n++)
 3b4:	4501                	li	a0,0
 3b6:	bfe5                	j	3ae <strlen+0x20>

00000000000003b8 <memset>:

void *
memset(void *dst, int c, uint n)
{
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e422                	sd	s0,8(sp)
 3bc:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 3be:	ca19                	beqz	a2,3d4 <memset+0x1c>
 3c0:	87aa                	mv	a5,a0
 3c2:	1602                	slli	a2,a2,0x20
 3c4:	9201                	srli	a2,a2,0x20
 3c6:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 3ca:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 3ce:	0785                	addi	a5,a5,1
 3d0:	fee79de3          	bne	a5,a4,3ca <memset+0x12>
    }
    return dst;
}
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret

00000000000003da <strchr>:

char *
strchr(const char *s, char c)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	addi	s0,sp,16
    for (; *s; s++)
 3e0:	00054783          	lbu	a5,0(a0)
 3e4:	cb99                	beqz	a5,3fa <strchr+0x20>
        if (*s == c)
 3e6:	00f58763          	beq	a1,a5,3f4 <strchr+0x1a>
    for (; *s; s++)
 3ea:	0505                	addi	a0,a0,1
 3ec:	00054783          	lbu	a5,0(a0)
 3f0:	fbfd                	bnez	a5,3e6 <strchr+0xc>
            return (char *)s;
    return 0;
 3f2:	4501                	li	a0,0
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	addi	sp,sp,16
 3f8:	8082                	ret
    return 0;
 3fa:	4501                	li	a0,0
 3fc:	bfe5                	j	3f4 <strchr+0x1a>

00000000000003fe <gets>:

char *
gets(char *buf, int max)
{
 3fe:	711d                	addi	sp,sp,-96
 400:	ec86                	sd	ra,88(sp)
 402:	e8a2                	sd	s0,80(sp)
 404:	e4a6                	sd	s1,72(sp)
 406:	e0ca                	sd	s2,64(sp)
 408:	fc4e                	sd	s3,56(sp)
 40a:	f852                	sd	s4,48(sp)
 40c:	f456                	sd	s5,40(sp)
 40e:	f05a                	sd	s6,32(sp)
 410:	ec5e                	sd	s7,24(sp)
 412:	1080                	addi	s0,sp,96
 414:	8baa                	mv	s7,a0
 416:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 418:	892a                	mv	s2,a0
 41a:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 41c:	4aa9                	li	s5,10
 41e:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 420:	89a6                	mv	s3,s1
 422:	2485                	addiw	s1,s1,1
 424:	0344d863          	bge	s1,s4,454 <gets+0x56>
        cc = read(0, &c, 1);
 428:	4605                	li	a2,1
 42a:	faf40593          	addi	a1,s0,-81
 42e:	4501                	li	a0,0
 430:	00000097          	auipc	ra,0x0
 434:	19a080e7          	jalr	410(ra) # 5ca <read>
        if (cc < 1)
 438:	00a05e63          	blez	a0,454 <gets+0x56>
        buf[i++] = c;
 43c:	faf44783          	lbu	a5,-81(s0)
 440:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 444:	01578763          	beq	a5,s5,452 <gets+0x54>
 448:	0905                	addi	s2,s2,1
 44a:	fd679be3          	bne	a5,s6,420 <gets+0x22>
    for (i = 0; i + 1 < max;)
 44e:	89a6                	mv	s3,s1
 450:	a011                	j	454 <gets+0x56>
 452:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 454:	99de                	add	s3,s3,s7
 456:	00098023          	sb	zero,0(s3)
    return buf;
}
 45a:	855e                	mv	a0,s7
 45c:	60e6                	ld	ra,88(sp)
 45e:	6446                	ld	s0,80(sp)
 460:	64a6                	ld	s1,72(sp)
 462:	6906                	ld	s2,64(sp)
 464:	79e2                	ld	s3,56(sp)
 466:	7a42                	ld	s4,48(sp)
 468:	7aa2                	ld	s5,40(sp)
 46a:	7b02                	ld	s6,32(sp)
 46c:	6be2                	ld	s7,24(sp)
 46e:	6125                	addi	sp,sp,96
 470:	8082                	ret

0000000000000472 <stat>:

int stat(const char *n, struct stat *st)
{
 472:	1101                	addi	sp,sp,-32
 474:	ec06                	sd	ra,24(sp)
 476:	e822                	sd	s0,16(sp)
 478:	e426                	sd	s1,8(sp)
 47a:	e04a                	sd	s2,0(sp)
 47c:	1000                	addi	s0,sp,32
 47e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 480:	4581                	li	a1,0
 482:	00000097          	auipc	ra,0x0
 486:	170080e7          	jalr	368(ra) # 5f2 <open>
    if (fd < 0)
 48a:	02054563          	bltz	a0,4b4 <stat+0x42>
 48e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 490:	85ca                	mv	a1,s2
 492:	00000097          	auipc	ra,0x0
 496:	178080e7          	jalr	376(ra) # 60a <fstat>
 49a:	892a                	mv	s2,a0
    close(fd);
 49c:	8526                	mv	a0,s1
 49e:	00000097          	auipc	ra,0x0
 4a2:	13c080e7          	jalr	316(ra) # 5da <close>
    return r;
}
 4a6:	854a                	mv	a0,s2
 4a8:	60e2                	ld	ra,24(sp)
 4aa:	6442                	ld	s0,16(sp)
 4ac:	64a2                	ld	s1,8(sp)
 4ae:	6902                	ld	s2,0(sp)
 4b0:	6105                	addi	sp,sp,32
 4b2:	8082                	ret
        return -1;
 4b4:	597d                	li	s2,-1
 4b6:	bfc5                	j	4a6 <stat+0x34>

00000000000004b8 <atoi>:

int atoi(const char *s)
{
 4b8:	1141                	addi	sp,sp,-16
 4ba:	e422                	sd	s0,8(sp)
 4bc:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4be:	00054683          	lbu	a3,0(a0)
 4c2:	fd06879b          	addiw	a5,a3,-48
 4c6:	0ff7f793          	zext.b	a5,a5
 4ca:	4625                	li	a2,9
 4cc:	02f66863          	bltu	a2,a5,4fc <atoi+0x44>
 4d0:	872a                	mv	a4,a0
    n = 0;
 4d2:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4d4:	0705                	addi	a4,a4,1
 4d6:	0025179b          	slliw	a5,a0,0x2
 4da:	9fa9                	addw	a5,a5,a0
 4dc:	0017979b          	slliw	a5,a5,0x1
 4e0:	9fb5                	addw	a5,a5,a3
 4e2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 4e6:	00074683          	lbu	a3,0(a4)
 4ea:	fd06879b          	addiw	a5,a3,-48
 4ee:	0ff7f793          	zext.b	a5,a5
 4f2:	fef671e3          	bgeu	a2,a5,4d4 <atoi+0x1c>
    return n;
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret
    n = 0;
 4fc:	4501                	li	a0,0
 4fe:	bfe5                	j	4f6 <atoi+0x3e>

0000000000000500 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 500:	1141                	addi	sp,sp,-16
 502:	e422                	sd	s0,8(sp)
 504:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 506:	02b57463          	bgeu	a0,a1,52e <memmove+0x2e>
    {
        while (n-- > 0)
 50a:	00c05f63          	blez	a2,528 <memmove+0x28>
 50e:	1602                	slli	a2,a2,0x20
 510:	9201                	srli	a2,a2,0x20
 512:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 516:	872a                	mv	a4,a0
            *dst++ = *src++;
 518:	0585                	addi	a1,a1,1
 51a:	0705                	addi	a4,a4,1
 51c:	fff5c683          	lbu	a3,-1(a1)
 520:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 524:	fee79ae3          	bne	a5,a4,518 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
        dst += n;
 52e:	00c50733          	add	a4,a0,a2
        src += n;
 532:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 534:	fec05ae3          	blez	a2,528 <memmove+0x28>
 538:	fff6079b          	addiw	a5,a2,-1
 53c:	1782                	slli	a5,a5,0x20
 53e:	9381                	srli	a5,a5,0x20
 540:	fff7c793          	not	a5,a5
 544:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 546:	15fd                	addi	a1,a1,-1
 548:	177d                	addi	a4,a4,-1
 54a:	0005c683          	lbu	a3,0(a1)
 54e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 552:	fee79ae3          	bne	a5,a4,546 <memmove+0x46>
 556:	bfc9                	j	528 <memmove+0x28>

0000000000000558 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 558:	1141                	addi	sp,sp,-16
 55a:	e422                	sd	s0,8(sp)
 55c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 55e:	ca05                	beqz	a2,58e <memcmp+0x36>
 560:	fff6069b          	addiw	a3,a2,-1
 564:	1682                	slli	a3,a3,0x20
 566:	9281                	srli	a3,a3,0x20
 568:	0685                	addi	a3,a3,1
 56a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 56c:	00054783          	lbu	a5,0(a0)
 570:	0005c703          	lbu	a4,0(a1)
 574:	00e79863          	bne	a5,a4,584 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 578:	0505                	addi	a0,a0,1
        p2++;
 57a:	0585                	addi	a1,a1,1
    while (n-- > 0)
 57c:	fed518e3          	bne	a0,a3,56c <memcmp+0x14>
    }
    return 0;
 580:	4501                	li	a0,0
 582:	a019                	j	588 <memcmp+0x30>
            return *p1 - *p2;
 584:	40e7853b          	subw	a0,a5,a4
}
 588:	6422                	ld	s0,8(sp)
 58a:	0141                	addi	sp,sp,16
 58c:	8082                	ret
    return 0;
 58e:	4501                	li	a0,0
 590:	bfe5                	j	588 <memcmp+0x30>

0000000000000592 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 592:	1141                	addi	sp,sp,-16
 594:	e406                	sd	ra,8(sp)
 596:	e022                	sd	s0,0(sp)
 598:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 59a:	00000097          	auipc	ra,0x0
 59e:	f66080e7          	jalr	-154(ra) # 500 <memmove>
}
 5a2:	60a2                	ld	ra,8(sp)
 5a4:	6402                	ld	s0,0(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret

00000000000005aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5aa:	4885                	li	a7,1
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b2:	4889                	li	a7,2
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ba:	488d                	li	a7,3
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c2:	4891                	li	a7,4
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <read>:
.global read
read:
 li a7, SYS_read
 5ca:	4895                	li	a7,5
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <write>:
.global write
write:
 li a7, SYS_write
 5d2:	48c1                	li	a7,16
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <close>:
.global close
close:
 li a7, SYS_close
 5da:	48d5                	li	a7,21
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e2:	4899                	li	a7,6
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ea:	489d                	li	a7,7
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <open>:
.global open
open:
 li a7, SYS_open
 5f2:	48bd                	li	a7,15
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fa:	48c5                	li	a7,17
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 602:	48c9                	li	a7,18
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60a:	48a1                	li	a7,8
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <link>:
.global link
link:
 li a7, SYS_link
 612:	48cd                	li	a7,19
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61a:	48d1                	li	a7,20
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 622:	48a5                	li	a7,9
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <dup>:
.global dup
dup:
 li a7, SYS_dup
 62a:	48a9                	li	a7,10
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 632:	48ad                	li	a7,11
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63a:	48b1                	li	a7,12
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 642:	48b5                	li	a7,13
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64a:	48b9                	li	a7,14
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <ps>:
.global ps
ps:
 li a7, SYS_ps
 652:	48d9                	li	a7,22
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 65a:	48dd                	li	a7,23
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 662:	48e1                	li	a7,24
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 66a:	1101                	addi	sp,sp,-32
 66c:	ec06                	sd	ra,24(sp)
 66e:	e822                	sd	s0,16(sp)
 670:	1000                	addi	s0,sp,32
 672:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 676:	4605                	li	a2,1
 678:	fef40593          	addi	a1,s0,-17
 67c:	00000097          	auipc	ra,0x0
 680:	f56080e7          	jalr	-170(ra) # 5d2 <write>
}
 684:	60e2                	ld	ra,24(sp)
 686:	6442                	ld	s0,16(sp)
 688:	6105                	addi	sp,sp,32
 68a:	8082                	ret

000000000000068c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 68c:	7139                	addi	sp,sp,-64
 68e:	fc06                	sd	ra,56(sp)
 690:	f822                	sd	s0,48(sp)
 692:	f426                	sd	s1,40(sp)
 694:	f04a                	sd	s2,32(sp)
 696:	ec4e                	sd	s3,24(sp)
 698:	0080                	addi	s0,sp,64
 69a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 69c:	c299                	beqz	a3,6a2 <printint+0x16>
 69e:	0805c963          	bltz	a1,730 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6a2:	2581                	sext.w	a1,a1
  neg = 0;
 6a4:	4881                	li	a7,0
 6a6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6aa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6ac:	2601                	sext.w	a2,a2
 6ae:	00000517          	auipc	a0,0x0
 6b2:	54a50513          	addi	a0,a0,1354 # bf8 <digits>
 6b6:	883a                	mv	a6,a4
 6b8:	2705                	addiw	a4,a4,1
 6ba:	02c5f7bb          	remuw	a5,a1,a2
 6be:	1782                	slli	a5,a5,0x20
 6c0:	9381                	srli	a5,a5,0x20
 6c2:	97aa                	add	a5,a5,a0
 6c4:	0007c783          	lbu	a5,0(a5)
 6c8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6cc:	0005879b          	sext.w	a5,a1
 6d0:	02c5d5bb          	divuw	a1,a1,a2
 6d4:	0685                	addi	a3,a3,1
 6d6:	fec7f0e3          	bgeu	a5,a2,6b6 <printint+0x2a>
  if(neg)
 6da:	00088c63          	beqz	a7,6f2 <printint+0x66>
    buf[i++] = '-';
 6de:	fd070793          	addi	a5,a4,-48
 6e2:	00878733          	add	a4,a5,s0
 6e6:	02d00793          	li	a5,45
 6ea:	fef70823          	sb	a5,-16(a4)
 6ee:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6f2:	02e05863          	blez	a4,722 <printint+0x96>
 6f6:	fc040793          	addi	a5,s0,-64
 6fa:	00e78933          	add	s2,a5,a4
 6fe:	fff78993          	addi	s3,a5,-1
 702:	99ba                	add	s3,s3,a4
 704:	377d                	addiw	a4,a4,-1
 706:	1702                	slli	a4,a4,0x20
 708:	9301                	srli	a4,a4,0x20
 70a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 70e:	fff94583          	lbu	a1,-1(s2)
 712:	8526                	mv	a0,s1
 714:	00000097          	auipc	ra,0x0
 718:	f56080e7          	jalr	-170(ra) # 66a <putc>
  while(--i >= 0)
 71c:	197d                	addi	s2,s2,-1
 71e:	ff3918e3          	bne	s2,s3,70e <printint+0x82>
}
 722:	70e2                	ld	ra,56(sp)
 724:	7442                	ld	s0,48(sp)
 726:	74a2                	ld	s1,40(sp)
 728:	7902                	ld	s2,32(sp)
 72a:	69e2                	ld	s3,24(sp)
 72c:	6121                	addi	sp,sp,64
 72e:	8082                	ret
    x = -xx;
 730:	40b005bb          	negw	a1,a1
    neg = 1;
 734:	4885                	li	a7,1
    x = -xx;
 736:	bf85                	j	6a6 <printint+0x1a>

0000000000000738 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 738:	715d                	addi	sp,sp,-80
 73a:	e486                	sd	ra,72(sp)
 73c:	e0a2                	sd	s0,64(sp)
 73e:	fc26                	sd	s1,56(sp)
 740:	f84a                	sd	s2,48(sp)
 742:	f44e                	sd	s3,40(sp)
 744:	f052                	sd	s4,32(sp)
 746:	ec56                	sd	s5,24(sp)
 748:	e85a                	sd	s6,16(sp)
 74a:	e45e                	sd	s7,8(sp)
 74c:	e062                	sd	s8,0(sp)
 74e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 750:	0005c903          	lbu	s2,0(a1)
 754:	18090c63          	beqz	s2,8ec <vprintf+0x1b4>
 758:	8aaa                	mv	s5,a0
 75a:	8bb2                	mv	s7,a2
 75c:	00158493          	addi	s1,a1,1
  state = 0;
 760:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 762:	02500a13          	li	s4,37
 766:	4b55                	li	s6,21
 768:	a839                	j	786 <vprintf+0x4e>
        putc(fd, c);
 76a:	85ca                	mv	a1,s2
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	efc080e7          	jalr	-260(ra) # 66a <putc>
 776:	a019                	j	77c <vprintf+0x44>
    } else if(state == '%'){
 778:	01498d63          	beq	s3,s4,792 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 77c:	0485                	addi	s1,s1,1
 77e:	fff4c903          	lbu	s2,-1(s1)
 782:	16090563          	beqz	s2,8ec <vprintf+0x1b4>
    if(state == 0){
 786:	fe0999e3          	bnez	s3,778 <vprintf+0x40>
      if(c == '%'){
 78a:	ff4910e3          	bne	s2,s4,76a <vprintf+0x32>
        state = '%';
 78e:	89d2                	mv	s3,s4
 790:	b7f5                	j	77c <vprintf+0x44>
      if(c == 'd'){
 792:	13490263          	beq	s2,s4,8b6 <vprintf+0x17e>
 796:	f9d9079b          	addiw	a5,s2,-99
 79a:	0ff7f793          	zext.b	a5,a5
 79e:	12fb6563          	bltu	s6,a5,8c8 <vprintf+0x190>
 7a2:	f9d9079b          	addiw	a5,s2,-99
 7a6:	0ff7f713          	zext.b	a4,a5
 7aa:	10eb6f63          	bltu	s6,a4,8c8 <vprintf+0x190>
 7ae:	00271793          	slli	a5,a4,0x2
 7b2:	00000717          	auipc	a4,0x0
 7b6:	3ee70713          	addi	a4,a4,1006 # ba0 <malloc+0x1b6>
 7ba:	97ba                	add	a5,a5,a4
 7bc:	439c                	lw	a5,0(a5)
 7be:	97ba                	add	a5,a5,a4
 7c0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7c2:	008b8913          	addi	s2,s7,8
 7c6:	4685                	li	a3,1
 7c8:	4629                	li	a2,10
 7ca:	000ba583          	lw	a1,0(s7)
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	ebc080e7          	jalr	-324(ra) # 68c <printint>
 7d8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	b745                	j	77c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7de:	008b8913          	addi	s2,s7,8
 7e2:	4681                	li	a3,0
 7e4:	4629                	li	a2,10
 7e6:	000ba583          	lw	a1,0(s7)
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	ea0080e7          	jalr	-352(ra) # 68c <printint>
 7f4:	8bca                	mv	s7,s2
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	b751                	j	77c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7fa:	008b8913          	addi	s2,s7,8
 7fe:	4681                	li	a3,0
 800:	4641                	li	a2,16
 802:	000ba583          	lw	a1,0(s7)
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	e84080e7          	jalr	-380(ra) # 68c <printint>
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	b7a5                	j	77c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 816:	008b8c13          	addi	s8,s7,8
 81a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 81e:	03000593          	li	a1,48
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	e46080e7          	jalr	-442(ra) # 66a <putc>
  putc(fd, 'x');
 82c:	07800593          	li	a1,120
 830:	8556                	mv	a0,s5
 832:	00000097          	auipc	ra,0x0
 836:	e38080e7          	jalr	-456(ra) # 66a <putc>
 83a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 83c:	00000b97          	auipc	s7,0x0
 840:	3bcb8b93          	addi	s7,s7,956 # bf8 <digits>
 844:	03c9d793          	srli	a5,s3,0x3c
 848:	97de                	add	a5,a5,s7
 84a:	0007c583          	lbu	a1,0(a5)
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	e1a080e7          	jalr	-486(ra) # 66a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 858:	0992                	slli	s3,s3,0x4
 85a:	397d                	addiw	s2,s2,-1
 85c:	fe0914e3          	bnez	s2,844 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 860:	8be2                	mv	s7,s8
      state = 0;
 862:	4981                	li	s3,0
 864:	bf21                	j	77c <vprintf+0x44>
        s = va_arg(ap, char*);
 866:	008b8993          	addi	s3,s7,8
 86a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 86e:	02090163          	beqz	s2,890 <vprintf+0x158>
        while(*s != 0){
 872:	00094583          	lbu	a1,0(s2)
 876:	c9a5                	beqz	a1,8e6 <vprintf+0x1ae>
          putc(fd, *s);
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	df0080e7          	jalr	-528(ra) # 66a <putc>
          s++;
 882:	0905                	addi	s2,s2,1
        while(*s != 0){
 884:	00094583          	lbu	a1,0(s2)
 888:	f9e5                	bnez	a1,878 <vprintf+0x140>
        s = va_arg(ap, char*);
 88a:	8bce                	mv	s7,s3
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b5fd                	j	77c <vprintf+0x44>
          s = "(null)";
 890:	00000917          	auipc	s2,0x0
 894:	30890913          	addi	s2,s2,776 # b98 <malloc+0x1ae>
        while(*s != 0){
 898:	02800593          	li	a1,40
 89c:	bff1                	j	878 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 89e:	008b8913          	addi	s2,s7,8
 8a2:	000bc583          	lbu	a1,0(s7)
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	dc2080e7          	jalr	-574(ra) # 66a <putc>
 8b0:	8bca                	mv	s7,s2
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	b5e1                	j	77c <vprintf+0x44>
        putc(fd, c);
 8b6:	02500593          	li	a1,37
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	dae080e7          	jalr	-594(ra) # 66a <putc>
      state = 0;
 8c4:	4981                	li	s3,0
 8c6:	bd5d                	j	77c <vprintf+0x44>
        putc(fd, '%');
 8c8:	02500593          	li	a1,37
 8cc:	8556                	mv	a0,s5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	d9c080e7          	jalr	-612(ra) # 66a <putc>
        putc(fd, c);
 8d6:	85ca                	mv	a1,s2
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	d90080e7          	jalr	-624(ra) # 66a <putc>
      state = 0;
 8e2:	4981                	li	s3,0
 8e4:	bd61                	j	77c <vprintf+0x44>
        s = va_arg(ap, char*);
 8e6:	8bce                	mv	s7,s3
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bd49                	j	77c <vprintf+0x44>
    }
  }
}
 8ec:	60a6                	ld	ra,72(sp)
 8ee:	6406                	ld	s0,64(sp)
 8f0:	74e2                	ld	s1,56(sp)
 8f2:	7942                	ld	s2,48(sp)
 8f4:	79a2                	ld	s3,40(sp)
 8f6:	7a02                	ld	s4,32(sp)
 8f8:	6ae2                	ld	s5,24(sp)
 8fa:	6b42                	ld	s6,16(sp)
 8fc:	6ba2                	ld	s7,8(sp)
 8fe:	6c02                	ld	s8,0(sp)
 900:	6161                	addi	sp,sp,80
 902:	8082                	ret

0000000000000904 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 904:	715d                	addi	sp,sp,-80
 906:	ec06                	sd	ra,24(sp)
 908:	e822                	sd	s0,16(sp)
 90a:	1000                	addi	s0,sp,32
 90c:	e010                	sd	a2,0(s0)
 90e:	e414                	sd	a3,8(s0)
 910:	e818                	sd	a4,16(s0)
 912:	ec1c                	sd	a5,24(s0)
 914:	03043023          	sd	a6,32(s0)
 918:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 91c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 920:	8622                	mv	a2,s0
 922:	00000097          	auipc	ra,0x0
 926:	e16080e7          	jalr	-490(ra) # 738 <vprintf>
}
 92a:	60e2                	ld	ra,24(sp)
 92c:	6442                	ld	s0,16(sp)
 92e:	6161                	addi	sp,sp,80
 930:	8082                	ret

0000000000000932 <printf>:

void
printf(const char *fmt, ...)
{
 932:	711d                	addi	sp,sp,-96
 934:	ec06                	sd	ra,24(sp)
 936:	e822                	sd	s0,16(sp)
 938:	1000                	addi	s0,sp,32
 93a:	e40c                	sd	a1,8(s0)
 93c:	e810                	sd	a2,16(s0)
 93e:	ec14                	sd	a3,24(s0)
 940:	f018                	sd	a4,32(s0)
 942:	f41c                	sd	a5,40(s0)
 944:	03043823          	sd	a6,48(s0)
 948:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 94c:	00840613          	addi	a2,s0,8
 950:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 954:	85aa                	mv	a1,a0
 956:	4505                	li	a0,1
 958:	00000097          	auipc	ra,0x0
 95c:	de0080e7          	jalr	-544(ra) # 738 <vprintf>
}
 960:	60e2                	ld	ra,24(sp)
 962:	6442                	ld	s0,16(sp)
 964:	6125                	addi	sp,sp,96
 966:	8082                	ret

0000000000000968 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 968:	1141                	addi	sp,sp,-16
 96a:	e422                	sd	s0,8(sp)
 96c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 96e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 972:	00000797          	auipc	a5,0x0
 976:	6a67b783          	ld	a5,1702(a5) # 1018 <freep>
 97a:	a02d                	j	9a4 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 97c:	4618                	lw	a4,8(a2)
 97e:	9f2d                	addw	a4,a4,a1
 980:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 984:	6398                	ld	a4,0(a5)
 986:	6310                	ld	a2,0(a4)
 988:	a83d                	j	9c6 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 98a:	ff852703          	lw	a4,-8(a0)
 98e:	9f31                	addw	a4,a4,a2
 990:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 992:	ff053683          	ld	a3,-16(a0)
 996:	a091                	j	9da <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 998:	6398                	ld	a4,0(a5)
 99a:	00e7e463          	bltu	a5,a4,9a2 <free+0x3a>
 99e:	00e6ea63          	bltu	a3,a4,9b2 <free+0x4a>
{
 9a2:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a4:	fed7fae3          	bgeu	a5,a3,998 <free+0x30>
 9a8:	6398                	ld	a4,0(a5)
 9aa:	00e6e463          	bltu	a3,a4,9b2 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ae:	fee7eae3          	bltu	a5,a4,9a2 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 9b2:	ff852583          	lw	a1,-8(a0)
 9b6:	6390                	ld	a2,0(a5)
 9b8:	02059813          	slli	a6,a1,0x20
 9bc:	01c85713          	srli	a4,a6,0x1c
 9c0:	9736                	add	a4,a4,a3
 9c2:	fae60de3          	beq	a2,a4,97c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9c6:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 9ca:	4790                	lw	a2,8(a5)
 9cc:	02061593          	slli	a1,a2,0x20
 9d0:	01c5d713          	srli	a4,a1,0x1c
 9d4:	973e                	add	a4,a4,a5
 9d6:	fae68ae3          	beq	a3,a4,98a <free+0x22>
        p->s.ptr = bp->s.ptr;
 9da:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 9dc:	00000717          	auipc	a4,0x0
 9e0:	62f73e23          	sd	a5,1596(a4) # 1018 <freep>
}
 9e4:	6422                	ld	s0,8(sp)
 9e6:	0141                	addi	sp,sp,16
 9e8:	8082                	ret

00000000000009ea <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 9ea:	7139                	addi	sp,sp,-64
 9ec:	fc06                	sd	ra,56(sp)
 9ee:	f822                	sd	s0,48(sp)
 9f0:	f426                	sd	s1,40(sp)
 9f2:	f04a                	sd	s2,32(sp)
 9f4:	ec4e                	sd	s3,24(sp)
 9f6:	e852                	sd	s4,16(sp)
 9f8:	e456                	sd	s5,8(sp)
 9fa:	e05a                	sd	s6,0(sp)
 9fc:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 9fe:	02051493          	slli	s1,a0,0x20
 a02:	9081                	srli	s1,s1,0x20
 a04:	04bd                	addi	s1,s1,15
 a06:	8091                	srli	s1,s1,0x4
 a08:	0014899b          	addiw	s3,s1,1
 a0c:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 a0e:	00000517          	auipc	a0,0x0
 a12:	60a53503          	ld	a0,1546(a0) # 1018 <freep>
 a16:	c515                	beqz	a0,a42 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a18:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 a1a:	4798                	lw	a4,8(a5)
 a1c:	02977f63          	bgeu	a4,s1,a5a <malloc+0x70>
    if (nu < 4096)
 a20:	8a4e                	mv	s4,s3
 a22:	0009871b          	sext.w	a4,s3
 a26:	6685                	lui	a3,0x1
 a28:	00d77363          	bgeu	a4,a3,a2e <malloc+0x44>
 a2c:	6a05                	lui	s4,0x1
 a2e:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a32:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a36:	00000917          	auipc	s2,0x0
 a3a:	5e290913          	addi	s2,s2,1506 # 1018 <freep>
    if (p == (char *)-1)
 a3e:	5afd                	li	s5,-1
 a40:	a895                	j	ab4 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 a42:	00000797          	auipc	a5,0x0
 a46:	5de78793          	addi	a5,a5,1502 # 1020 <base>
 a4a:	00000717          	auipc	a4,0x0
 a4e:	5cf73723          	sd	a5,1486(a4) # 1018 <freep>
 a52:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a54:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a58:	b7e1                	j	a20 <malloc+0x36>
            if (p->s.size == nunits)
 a5a:	02e48c63          	beq	s1,a4,a92 <malloc+0xa8>
                p->s.size -= nunits;
 a5e:	4137073b          	subw	a4,a4,s3
 a62:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a64:	02071693          	slli	a3,a4,0x20
 a68:	01c6d713          	srli	a4,a3,0x1c
 a6c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a6e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a72:	00000717          	auipc	a4,0x0
 a76:	5aa73323          	sd	a0,1446(a4) # 1018 <freep>
            return (void *)(p + 1);
 a7a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 a7e:	70e2                	ld	ra,56(sp)
 a80:	7442                	ld	s0,48(sp)
 a82:	74a2                	ld	s1,40(sp)
 a84:	7902                	ld	s2,32(sp)
 a86:	69e2                	ld	s3,24(sp)
 a88:	6a42                	ld	s4,16(sp)
 a8a:	6aa2                	ld	s5,8(sp)
 a8c:	6b02                	ld	s6,0(sp)
 a8e:	6121                	addi	sp,sp,64
 a90:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 a92:	6398                	ld	a4,0(a5)
 a94:	e118                	sd	a4,0(a0)
 a96:	bff1                	j	a72 <malloc+0x88>
    hp->s.size = nu;
 a98:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a9c:	0541                	addi	a0,a0,16
 a9e:	00000097          	auipc	ra,0x0
 aa2:	eca080e7          	jalr	-310(ra) # 968 <free>
    return freep;
 aa6:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 aaa:	d971                	beqz	a0,a7e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 aac:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 aae:	4798                	lw	a4,8(a5)
 ab0:	fa9775e3          	bgeu	a4,s1,a5a <malloc+0x70>
        if (p == freep)
 ab4:	00093703          	ld	a4,0(s2)
 ab8:	853e                	mv	a0,a5
 aba:	fef719e3          	bne	a4,a5,aac <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 abe:	8552                	mv	a0,s4
 ac0:	00000097          	auipc	ra,0x0
 ac4:	b7a080e7          	jalr	-1158(ra) # 63a <sbrk>
    if (p == (char *)-1)
 ac8:	fd5518e3          	bne	a0,s5,a98 <malloc+0xae>
                return 0;
 acc:	4501                	li	a0,0
 ace:	bf45                	j	a7e <malloc+0x94>
