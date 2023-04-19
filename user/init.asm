
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
  12:	c5250513          	addi	a0,a0,-942 # c60 <malloc+0xea>
  16:	00000097          	auipc	ra,0x0
  1a:	768080e7          	jalr	1896(ra) # 77e <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    {
        mknod("console", CONSOLE, 0);
        open("console", O_RDWR);
    }
    dup(0); // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	792080e7          	jalr	1938(ra) # 7b6 <dup>
    dup(0); // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	788080e7          	jalr	1928(ra) # 7b6 <dup>

    for (;;)
    {
        printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	c3290913          	addi	s2,s2,-974 # c68 <malloc+0xf2>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	a7e080e7          	jalr	-1410(ra) # abe <printf>
        pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	6ee080e7          	jalr	1774(ra) # 736 <fork>
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
  5e:	6ec080e7          	jalr	1772(ra) # 746 <wait>
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
  6e:	c4e50513          	addi	a0,a0,-946 # cb8 <malloc+0x142>
  72:	00001097          	auipc	ra,0x1
  76:	a4c080e7          	jalr	-1460(ra) # abe <printf>
                exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	6c2080e7          	jalr	1730(ra) # 73e <exit>
        mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	bd850513          	addi	a0,a0,-1064 # c60 <malloc+0xea>
  90:	00000097          	auipc	ra,0x0
  94:	6f6080e7          	jalr	1782(ra) # 786 <mknod>
        open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	bc650513          	addi	a0,a0,-1082 # c60 <malloc+0xea>
  a2:	00000097          	auipc	ra,0x0
  a6:	6dc080e7          	jalr	1756(ra) # 77e <open>
  aa:	bfa5                	j	22 <main+0x22>
            printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	bd450513          	addi	a0,a0,-1068 # c80 <malloc+0x10a>
  b4:	00001097          	auipc	ra,0x1
  b8:	a0a080e7          	jalr	-1526(ra) # abe <printf>
            exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	680080e7          	jalr	1664(ra) # 73e <exit>
            exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f4a58593          	addi	a1,a1,-182 # 1010 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	bca50513          	addi	a0,a0,-1078 # c98 <malloc+0x122>
  d6:	00000097          	auipc	ra,0x0
  da:	6a0080e7          	jalr	1696(ra) # 776 <exec>
            printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	bc250513          	addi	a0,a0,-1086 # ca0 <malloc+0x12a>
  e6:	00001097          	auipc	ra,0x1
  ea:	9d8080e7          	jalr	-1576(ra) # abe <printf>
            exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	64e080e7          	jalr	1614(ra) # 73e <exit>

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
 12c:	2c4080e7          	jalr	708(ra) # 3ec <twhoami>
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
 178:	b6450513          	addi	a0,a0,-1180 # cd8 <malloc+0x162>
 17c:	00001097          	auipc	ra,0x1
 180:	942080e7          	jalr	-1726(ra) # abe <printf>
        exit(-1);
 184:	557d                	li	a0,-1
 186:	00000097          	auipc	ra,0x0
 18a:	5b8080e7          	jalr	1464(ra) # 73e <exit>
    {
        // give up the cpu for other threads
        tyield();
 18e:	00000097          	auipc	ra,0x0
 192:	1dc080e7          	jalr	476(ra) # 36a <tyield>
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
 1ac:	244080e7          	jalr	580(ra) # 3ec <twhoami>
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
 1f0:	17e080e7          	jalr	382(ra) # 36a <tyield>
}
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
        printf("releasing lock we are not holding");
 1fe:	00001517          	auipc	a0,0x1
 202:	b0250513          	addi	a0,a0,-1278 # d00 <malloc+0x18a>
 206:	00001097          	auipc	ra,0x1
 20a:	8b8080e7          	jalr	-1864(ra) # abe <printf>
        exit(-1);
 20e:	557d                	li	a0,-1
 210:	00000097          	auipc	ra,0x0
 214:	52e080e7          	jalr	1326(ra) # 73e <exit>

0000000000000218 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 218:	00001517          	auipc	a0,0x1
 21c:	e0853503          	ld	a0,-504(a0) # 1020 <current_thread>
 220:	00001717          	auipc	a4,0x1
 224:	e1070713          	addi	a4,a4,-496 # 1030 <threads>
    for (int i = 0; i < 16; i++) {
 228:	4781                	li	a5,0
 22a:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 22c:	6314                	ld	a3,0(a4)
 22e:	00a68763          	beq	a3,a0,23c <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 232:	2785                	addiw	a5,a5,1
 234:	0721                	addi	a4,a4,8
 236:	fec79be3          	bne	a5,a2,22c <tsched+0x14>
    int current_index = 0;
 23a:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 23c:	0017869b          	addiw	a3,a5,1
 240:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 244:	00001817          	auipc	a6,0x1
 248:	dec80813          	addi	a6,a6,-532 # 1030 <threads>
 24c:	488d                	li	a7,3
 24e:	a021                	j	256 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 250:	2685                	addiw	a3,a3,1
 252:	04c68363          	beq	a3,a2,298 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 256:	41f6d71b          	sraiw	a4,a3,0x1f
 25a:	01c7571b          	srliw	a4,a4,0x1c
 25e:	00d707bb          	addw	a5,a4,a3
 262:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 264:	9f99                	subw	a5,a5,a4
 266:	078e                	slli	a5,a5,0x3
 268:	97c2                	add	a5,a5,a6
 26a:	638c                	ld	a1,0(a5)
 26c:	d1f5                	beqz	a1,250 <tsched+0x38>
 26e:	5dbc                	lw	a5,120(a1)
 270:	ff1790e3          	bne	a5,a7,250 <tsched+0x38>
{
 274:	1141                	addi	sp,sp,-16
 276:	e406                	sd	ra,8(sp)
 278:	e022                	sd	s0,0(sp)
 27a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 27c:	00001797          	auipc	a5,0x1
 280:	dab7b223          	sd	a1,-604(a5) # 1020 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 284:	05a1                	addi	a1,a1,8
 286:	0521                	addi	a0,a0,8
 288:	00000097          	auipc	ra,0x0
 28c:	17c080e7          	jalr	380(ra) # 404 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 290:	60a2                	ld	ra,8(sp)
 292:	6402                	ld	s0,0(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
 298:	8082                	ret

000000000000029a <thread_wrapper>:
{
 29a:	1101                	addi	sp,sp,-32
 29c:	ec06                	sd	ra,24(sp)
 29e:	e822                	sd	s0,16(sp)
 2a0:	e426                	sd	s1,8(sp)
 2a2:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 2a4:	00001497          	auipc	s1,0x1
 2a8:	d7c48493          	addi	s1,s1,-644 # 1020 <current_thread>
 2ac:	609c                	ld	a5,0(s1)
 2ae:	67d8                	ld	a4,136(a5)
 2b0:	63c8                	ld	a0,128(a5)
 2b2:	9702                	jalr	a4
    current_thread->state = EXITED;
 2b4:	609c                	ld	a5,0(s1)
 2b6:	4719                	li	a4,6
 2b8:	dfb8                	sw	a4,120(a5)
    tsched();
 2ba:	00000097          	auipc	ra,0x0
 2be:	f5e080e7          	jalr	-162(ra) # 218 <tsched>
}
 2c2:	60e2                	ld	ra,24(sp)
 2c4:	6442                	ld	s0,16(sp)
 2c6:	64a2                	ld	s1,8(sp)
 2c8:	6105                	addi	sp,sp,32
 2ca:	8082                	ret

00000000000002cc <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2cc:	7179                	addi	sp,sp,-48
 2ce:	f406                	sd	ra,40(sp)
 2d0:	f022                	sd	s0,32(sp)
 2d2:	ec26                	sd	s1,24(sp)
 2d4:	e84a                	sd	s2,16(sp)
 2d6:	e44e                	sd	s3,8(sp)
 2d8:	1800                	addi	s0,sp,48
 2da:	84aa                	mv	s1,a0
 2dc:	89b2                	mv	s3,a2
 2de:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2e0:	09800513          	li	a0,152
 2e4:	00001097          	auipc	ra,0x1
 2e8:	892080e7          	jalr	-1902(ra) # b76 <malloc>
 2ec:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2ee:	478d                	li	a5,3
 2f0:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2f2:	609c                	ld	a5,0(s1)
 2f4:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2f8:	609c                	ld	a5,0(s1)
 2fa:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 2fe:	6098                	ld	a4,0(s1)
 300:	00001797          	auipc	a5,0x1
 304:	d0078793          	addi	a5,a5,-768 # 1000 <next_tid>
 308:	4394                	lw	a3,0(a5)
 30a:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 30e:	4398                	lw	a4,0(a5)
 310:	2705                	addiw	a4,a4,1
 312:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 314:	6505                	lui	a0,0x1
 316:	00001097          	auipc	ra,0x1
 31a:	860080e7          	jalr	-1952(ra) # b76 <malloc>
 31e:	609c                	ld	a5,0(s1)
 320:	6705                	lui	a4,0x1
 322:	953a                	add	a0,a0,a4
 324:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 326:	609c                	ld	a5,0(s1)
 328:	00000717          	auipc	a4,0x0
 32c:	f7270713          	addi	a4,a4,-142 # 29a <thread_wrapper>
 330:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 332:	00001717          	auipc	a4,0x1
 336:	cfe70713          	addi	a4,a4,-770 # 1030 <threads>
 33a:	4781                	li	a5,0
 33c:	4641                	li	a2,16
        if (threads[i] == NULL) {
 33e:	6314                	ld	a3,0(a4)
 340:	ce81                	beqz	a3,358 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 342:	2785                	addiw	a5,a5,1
 344:	0721                	addi	a4,a4,8
 346:	fec79ce3          	bne	a5,a2,33e <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 34a:	70a2                	ld	ra,40(sp)
 34c:	7402                	ld	s0,32(sp)
 34e:	64e2                	ld	s1,24(sp)
 350:	6942                	ld	s2,16(sp)
 352:	69a2                	ld	s3,8(sp)
 354:	6145                	addi	sp,sp,48
 356:	8082                	ret
            threads[i] = *thread;
 358:	6094                	ld	a3,0(s1)
 35a:	078e                	slli	a5,a5,0x3
 35c:	00001717          	auipc	a4,0x1
 360:	cd470713          	addi	a4,a4,-812 # 1030 <threads>
 364:	97ba                	add	a5,a5,a4
 366:	e394                	sd	a3,0(a5)
            break;
 368:	b7cd                	j	34a <tcreate+0x7e>

000000000000036a <tyield>:
    return 0;
}


void tyield()
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e406                	sd	ra,8(sp)
 36e:	e022                	sd	s0,0(sp)
 370:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 372:	00001797          	auipc	a5,0x1
 376:	cae7b783          	ld	a5,-850(a5) # 1020 <current_thread>
 37a:	470d                	li	a4,3
 37c:	dfb8                	sw	a4,120(a5)
    tsched();
 37e:	00000097          	auipc	ra,0x0
 382:	e9a080e7          	jalr	-358(ra) # 218 <tsched>
}
 386:	60a2                	ld	ra,8(sp)
 388:	6402                	ld	s0,0(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret

000000000000038e <tjoin>:
{
 38e:	1101                	addi	sp,sp,-32
 390:	ec06                	sd	ra,24(sp)
 392:	e822                	sd	s0,16(sp)
 394:	e426                	sd	s1,8(sp)
 396:	e04a                	sd	s2,0(sp)
 398:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 39a:	00001797          	auipc	a5,0x1
 39e:	c9678793          	addi	a5,a5,-874 # 1030 <threads>
 3a2:	00001697          	auipc	a3,0x1
 3a6:	d0e68693          	addi	a3,a3,-754 # 10b0 <base>
 3aa:	a021                	j	3b2 <tjoin+0x24>
 3ac:	07a1                	addi	a5,a5,8
 3ae:	02d78b63          	beq	a5,a3,3e4 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3b2:	6384                	ld	s1,0(a5)
 3b4:	dce5                	beqz	s1,3ac <tjoin+0x1e>
 3b6:	0004c703          	lbu	a4,0(s1)
 3ba:	fea719e3          	bne	a4,a0,3ac <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3be:	5cb8                	lw	a4,120(s1)
 3c0:	4799                	li	a5,6
 3c2:	4919                	li	s2,6
 3c4:	02f70263          	beq	a4,a5,3e8 <tjoin+0x5a>
        tyield();
 3c8:	00000097          	auipc	ra,0x0
 3cc:	fa2080e7          	jalr	-94(ra) # 36a <tyield>
    while (target_thread->state != EXITED) {
 3d0:	5cbc                	lw	a5,120(s1)
 3d2:	ff279be3          	bne	a5,s2,3c8 <tjoin+0x3a>
    return 0;
 3d6:	4501                	li	a0,0
}
 3d8:	60e2                	ld	ra,24(sp)
 3da:	6442                	ld	s0,16(sp)
 3dc:	64a2                	ld	s1,8(sp)
 3de:	6902                	ld	s2,0(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret
        return -1;
 3e4:	557d                	li	a0,-1
 3e6:	bfcd                	j	3d8 <tjoin+0x4a>
    return 0;
 3e8:	4501                	li	a0,0
 3ea:	b7fd                	j	3d8 <tjoin+0x4a>

00000000000003ec <twhoami>:

uint8 twhoami()
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3f2:	00001797          	auipc	a5,0x1
 3f6:	c2e7b783          	ld	a5,-978(a5) # 1020 <current_thread>
 3fa:	0007c503          	lbu	a0,0(a5)
 3fe:	6422                	ld	s0,8(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret

0000000000000404 <tswtch>:
 404:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 408:	00253423          	sd	sp,8(a0)
 40c:	e900                	sd	s0,16(a0)
 40e:	ed04                	sd	s1,24(a0)
 410:	03253023          	sd	s2,32(a0)
 414:	03353423          	sd	s3,40(a0)
 418:	03453823          	sd	s4,48(a0)
 41c:	03553c23          	sd	s5,56(a0)
 420:	05653023          	sd	s6,64(a0)
 424:	05753423          	sd	s7,72(a0)
 428:	05853823          	sd	s8,80(a0)
 42c:	05953c23          	sd	s9,88(a0)
 430:	07a53023          	sd	s10,96(a0)
 434:	07b53423          	sd	s11,104(a0)
 438:	0005b083          	ld	ra,0(a1)
 43c:	0085b103          	ld	sp,8(a1)
 440:	6980                	ld	s0,16(a1)
 442:	6d84                	ld	s1,24(a1)
 444:	0205b903          	ld	s2,32(a1)
 448:	0285b983          	ld	s3,40(a1)
 44c:	0305ba03          	ld	s4,48(a1)
 450:	0385ba83          	ld	s5,56(a1)
 454:	0405bb03          	ld	s6,64(a1)
 458:	0485bb83          	ld	s7,72(a1)
 45c:	0505bc03          	ld	s8,80(a1)
 460:	0585bc83          	ld	s9,88(a1)
 464:	0605bd03          	ld	s10,96(a1)
 468:	0685bd83          	ld	s11,104(a1)
 46c:	8082                	ret

000000000000046e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 46e:	1101                	addi	sp,sp,-32
 470:	ec06                	sd	ra,24(sp)
 472:	e822                	sd	s0,16(sp)
 474:	e426                	sd	s1,8(sp)
 476:	e04a                	sd	s2,0(sp)
 478:	1000                	addi	s0,sp,32
 47a:	84aa                	mv	s1,a0
 47c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 47e:	09800513          	li	a0,152
 482:	00000097          	auipc	ra,0x0
 486:	6f4080e7          	jalr	1780(ra) # b76 <malloc>

    main_thread->tid = 1;
 48a:	4785                	li	a5,1
 48c:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 490:	4791                	li	a5,4
 492:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 494:	00001797          	auipc	a5,0x1
 498:	b8a7b623          	sd	a0,-1140(a5) # 1020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 49c:	00001797          	auipc	a5,0x1
 4a0:	b9478793          	addi	a5,a5,-1132 # 1030 <threads>
 4a4:	00001717          	auipc	a4,0x1
 4a8:	c0c70713          	addi	a4,a4,-1012 # 10b0 <base>
        threads[i] = NULL;
 4ac:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4b0:	07a1                	addi	a5,a5,8
 4b2:	fee79de3          	bne	a5,a4,4ac <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4b6:	00001797          	auipc	a5,0x1
 4ba:	b6a7bd23          	sd	a0,-1158(a5) # 1030 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4be:	85ca                	mv	a1,s2
 4c0:	8526                	mv	a0,s1
 4c2:	00000097          	auipc	ra,0x0
 4c6:	b3e080e7          	jalr	-1218(ra) # 0 <main>
    //tsched();

    exit(res);
 4ca:	00000097          	auipc	ra,0x0
 4ce:	274080e7          	jalr	628(ra) # 73e <exit>

00000000000004d2 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4d8:	87aa                	mv	a5,a0
 4da:	0585                	addi	a1,a1,1
 4dc:	0785                	addi	a5,a5,1
 4de:	fff5c703          	lbu	a4,-1(a1)
 4e2:	fee78fa3          	sb	a4,-1(a5)
 4e6:	fb75                	bnez	a4,4da <strcpy+0x8>
        ;
    return os;
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret

00000000000004ee <strcmp>:

int strcmp(const char *p, const char *q)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4f4:	00054783          	lbu	a5,0(a0)
 4f8:	cb91                	beqz	a5,50c <strcmp+0x1e>
 4fa:	0005c703          	lbu	a4,0(a1)
 4fe:	00f71763          	bne	a4,a5,50c <strcmp+0x1e>
        p++, q++;
 502:	0505                	addi	a0,a0,1
 504:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 506:	00054783          	lbu	a5,0(a0)
 50a:	fbe5                	bnez	a5,4fa <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 50c:	0005c503          	lbu	a0,0(a1)
}
 510:	40a7853b          	subw	a0,a5,a0
 514:	6422                	ld	s0,8(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret

000000000000051a <strlen>:

uint strlen(const char *s)
{
 51a:	1141                	addi	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 520:	00054783          	lbu	a5,0(a0)
 524:	cf91                	beqz	a5,540 <strlen+0x26>
 526:	0505                	addi	a0,a0,1
 528:	87aa                	mv	a5,a0
 52a:	86be                	mv	a3,a5
 52c:	0785                	addi	a5,a5,1
 52e:	fff7c703          	lbu	a4,-1(a5)
 532:	ff65                	bnez	a4,52a <strlen+0x10>
 534:	40a6853b          	subw	a0,a3,a0
 538:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 53a:	6422                	ld	s0,8(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret
    for (n = 0; s[n]; n++)
 540:	4501                	li	a0,0
 542:	bfe5                	j	53a <strlen+0x20>

0000000000000544 <memset>:

void *
memset(void *dst, int c, uint n)
{
 544:	1141                	addi	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 54a:	ca19                	beqz	a2,560 <memset+0x1c>
 54c:	87aa                	mv	a5,a0
 54e:	1602                	slli	a2,a2,0x20
 550:	9201                	srli	a2,a2,0x20
 552:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 556:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 55a:	0785                	addi	a5,a5,1
 55c:	fee79de3          	bne	a5,a4,556 <memset+0x12>
    }
    return dst;
}
 560:	6422                	ld	s0,8(sp)
 562:	0141                	addi	sp,sp,16
 564:	8082                	ret

0000000000000566 <strchr>:

char *
strchr(const char *s, char c)
{
 566:	1141                	addi	sp,sp,-16
 568:	e422                	sd	s0,8(sp)
 56a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 56c:	00054783          	lbu	a5,0(a0)
 570:	cb99                	beqz	a5,586 <strchr+0x20>
        if (*s == c)
 572:	00f58763          	beq	a1,a5,580 <strchr+0x1a>
    for (; *s; s++)
 576:	0505                	addi	a0,a0,1
 578:	00054783          	lbu	a5,0(a0)
 57c:	fbfd                	bnez	a5,572 <strchr+0xc>
            return (char *)s;
    return 0;
 57e:	4501                	li	a0,0
}
 580:	6422                	ld	s0,8(sp)
 582:	0141                	addi	sp,sp,16
 584:	8082                	ret
    return 0;
 586:	4501                	li	a0,0
 588:	bfe5                	j	580 <strchr+0x1a>

000000000000058a <gets>:

char *
gets(char *buf, int max)
{
 58a:	711d                	addi	sp,sp,-96
 58c:	ec86                	sd	ra,88(sp)
 58e:	e8a2                	sd	s0,80(sp)
 590:	e4a6                	sd	s1,72(sp)
 592:	e0ca                	sd	s2,64(sp)
 594:	fc4e                	sd	s3,56(sp)
 596:	f852                	sd	s4,48(sp)
 598:	f456                	sd	s5,40(sp)
 59a:	f05a                	sd	s6,32(sp)
 59c:	ec5e                	sd	s7,24(sp)
 59e:	1080                	addi	s0,sp,96
 5a0:	8baa                	mv	s7,a0
 5a2:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5a4:	892a                	mv	s2,a0
 5a6:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5a8:	4aa9                	li	s5,10
 5aa:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5ac:	89a6                	mv	s3,s1
 5ae:	2485                	addiw	s1,s1,1
 5b0:	0344d863          	bge	s1,s4,5e0 <gets+0x56>
        cc = read(0, &c, 1);
 5b4:	4605                	li	a2,1
 5b6:	faf40593          	addi	a1,s0,-81
 5ba:	4501                	li	a0,0
 5bc:	00000097          	auipc	ra,0x0
 5c0:	19a080e7          	jalr	410(ra) # 756 <read>
        if (cc < 1)
 5c4:	00a05e63          	blez	a0,5e0 <gets+0x56>
        buf[i++] = c;
 5c8:	faf44783          	lbu	a5,-81(s0)
 5cc:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5d0:	01578763          	beq	a5,s5,5de <gets+0x54>
 5d4:	0905                	addi	s2,s2,1
 5d6:	fd679be3          	bne	a5,s6,5ac <gets+0x22>
    for (i = 0; i + 1 < max;)
 5da:	89a6                	mv	s3,s1
 5dc:	a011                	j	5e0 <gets+0x56>
 5de:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5e0:	99de                	add	s3,s3,s7
 5e2:	00098023          	sb	zero,0(s3)
    return buf;
}
 5e6:	855e                	mv	a0,s7
 5e8:	60e6                	ld	ra,88(sp)
 5ea:	6446                	ld	s0,80(sp)
 5ec:	64a6                	ld	s1,72(sp)
 5ee:	6906                	ld	s2,64(sp)
 5f0:	79e2                	ld	s3,56(sp)
 5f2:	7a42                	ld	s4,48(sp)
 5f4:	7aa2                	ld	s5,40(sp)
 5f6:	7b02                	ld	s6,32(sp)
 5f8:	6be2                	ld	s7,24(sp)
 5fa:	6125                	addi	sp,sp,96
 5fc:	8082                	ret

00000000000005fe <stat>:

int stat(const char *n, struct stat *st)
{
 5fe:	1101                	addi	sp,sp,-32
 600:	ec06                	sd	ra,24(sp)
 602:	e822                	sd	s0,16(sp)
 604:	e426                	sd	s1,8(sp)
 606:	e04a                	sd	s2,0(sp)
 608:	1000                	addi	s0,sp,32
 60a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 60c:	4581                	li	a1,0
 60e:	00000097          	auipc	ra,0x0
 612:	170080e7          	jalr	368(ra) # 77e <open>
    if (fd < 0)
 616:	02054563          	bltz	a0,640 <stat+0x42>
 61a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 61c:	85ca                	mv	a1,s2
 61e:	00000097          	auipc	ra,0x0
 622:	178080e7          	jalr	376(ra) # 796 <fstat>
 626:	892a                	mv	s2,a0
    close(fd);
 628:	8526                	mv	a0,s1
 62a:	00000097          	auipc	ra,0x0
 62e:	13c080e7          	jalr	316(ra) # 766 <close>
    return r;
}
 632:	854a                	mv	a0,s2
 634:	60e2                	ld	ra,24(sp)
 636:	6442                	ld	s0,16(sp)
 638:	64a2                	ld	s1,8(sp)
 63a:	6902                	ld	s2,0(sp)
 63c:	6105                	addi	sp,sp,32
 63e:	8082                	ret
        return -1;
 640:	597d                	li	s2,-1
 642:	bfc5                	j	632 <stat+0x34>

0000000000000644 <atoi>:

int atoi(const char *s)
{
 644:	1141                	addi	sp,sp,-16
 646:	e422                	sd	s0,8(sp)
 648:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 64a:	00054683          	lbu	a3,0(a0)
 64e:	fd06879b          	addiw	a5,a3,-48
 652:	0ff7f793          	zext.b	a5,a5
 656:	4625                	li	a2,9
 658:	02f66863          	bltu	a2,a5,688 <atoi+0x44>
 65c:	872a                	mv	a4,a0
    n = 0;
 65e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 660:	0705                	addi	a4,a4,1
 662:	0025179b          	slliw	a5,a0,0x2
 666:	9fa9                	addw	a5,a5,a0
 668:	0017979b          	slliw	a5,a5,0x1
 66c:	9fb5                	addw	a5,a5,a3
 66e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 672:	00074683          	lbu	a3,0(a4)
 676:	fd06879b          	addiw	a5,a3,-48
 67a:	0ff7f793          	zext.b	a5,a5
 67e:	fef671e3          	bgeu	a2,a5,660 <atoi+0x1c>
    return n;
}
 682:	6422                	ld	s0,8(sp)
 684:	0141                	addi	sp,sp,16
 686:	8082                	ret
    n = 0;
 688:	4501                	li	a0,0
 68a:	bfe5                	j	682 <atoi+0x3e>

000000000000068c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 68c:	1141                	addi	sp,sp,-16
 68e:	e422                	sd	s0,8(sp)
 690:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 692:	02b57463          	bgeu	a0,a1,6ba <memmove+0x2e>
    {
        while (n-- > 0)
 696:	00c05f63          	blez	a2,6b4 <memmove+0x28>
 69a:	1602                	slli	a2,a2,0x20
 69c:	9201                	srli	a2,a2,0x20
 69e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6a2:	872a                	mv	a4,a0
            *dst++ = *src++;
 6a4:	0585                	addi	a1,a1,1
 6a6:	0705                	addi	a4,a4,1
 6a8:	fff5c683          	lbu	a3,-1(a1)
 6ac:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6b0:	fee79ae3          	bne	a5,a4,6a4 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6b4:	6422                	ld	s0,8(sp)
 6b6:	0141                	addi	sp,sp,16
 6b8:	8082                	ret
        dst += n;
 6ba:	00c50733          	add	a4,a0,a2
        src += n;
 6be:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6c0:	fec05ae3          	blez	a2,6b4 <memmove+0x28>
 6c4:	fff6079b          	addiw	a5,a2,-1
 6c8:	1782                	slli	a5,a5,0x20
 6ca:	9381                	srli	a5,a5,0x20
 6cc:	fff7c793          	not	a5,a5
 6d0:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6d2:	15fd                	addi	a1,a1,-1
 6d4:	177d                	addi	a4,a4,-1
 6d6:	0005c683          	lbu	a3,0(a1)
 6da:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6de:	fee79ae3          	bne	a5,a4,6d2 <memmove+0x46>
 6e2:	bfc9                	j	6b4 <memmove+0x28>

00000000000006e4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6e4:	1141                	addi	sp,sp,-16
 6e6:	e422                	sd	s0,8(sp)
 6e8:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6ea:	ca05                	beqz	a2,71a <memcmp+0x36>
 6ec:	fff6069b          	addiw	a3,a2,-1
 6f0:	1682                	slli	a3,a3,0x20
 6f2:	9281                	srli	a3,a3,0x20
 6f4:	0685                	addi	a3,a3,1
 6f6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6f8:	00054783          	lbu	a5,0(a0)
 6fc:	0005c703          	lbu	a4,0(a1)
 700:	00e79863          	bne	a5,a4,710 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 704:	0505                	addi	a0,a0,1
        p2++;
 706:	0585                	addi	a1,a1,1
    while (n-- > 0)
 708:	fed518e3          	bne	a0,a3,6f8 <memcmp+0x14>
    }
    return 0;
 70c:	4501                	li	a0,0
 70e:	a019                	j	714 <memcmp+0x30>
            return *p1 - *p2;
 710:	40e7853b          	subw	a0,a5,a4
}
 714:	6422                	ld	s0,8(sp)
 716:	0141                	addi	sp,sp,16
 718:	8082                	ret
    return 0;
 71a:	4501                	li	a0,0
 71c:	bfe5                	j	714 <memcmp+0x30>

000000000000071e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 71e:	1141                	addi	sp,sp,-16
 720:	e406                	sd	ra,8(sp)
 722:	e022                	sd	s0,0(sp)
 724:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 726:	00000097          	auipc	ra,0x0
 72a:	f66080e7          	jalr	-154(ra) # 68c <memmove>
}
 72e:	60a2                	ld	ra,8(sp)
 730:	6402                	ld	s0,0(sp)
 732:	0141                	addi	sp,sp,16
 734:	8082                	ret

0000000000000736 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 736:	4885                	li	a7,1
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <exit>:
.global exit
exit:
 li a7, SYS_exit
 73e:	4889                	li	a7,2
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <wait>:
.global wait
wait:
 li a7, SYS_wait
 746:	488d                	li	a7,3
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 74e:	4891                	li	a7,4
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <read>:
.global read
read:
 li a7, SYS_read
 756:	4895                	li	a7,5
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <write>:
.global write
write:
 li a7, SYS_write
 75e:	48c1                	li	a7,16
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <close>:
.global close
close:
 li a7, SYS_close
 766:	48d5                	li	a7,21
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <kill>:
.global kill
kill:
 li a7, SYS_kill
 76e:	4899                	li	a7,6
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <exec>:
.global exec
exec:
 li a7, SYS_exec
 776:	489d                	li	a7,7
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <open>:
.global open
open:
 li a7, SYS_open
 77e:	48bd                	li	a7,15
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 786:	48c5                	li	a7,17
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 78e:	48c9                	li	a7,18
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 796:	48a1                	li	a7,8
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <link>:
.global link
link:
 li a7, SYS_link
 79e:	48cd                	li	a7,19
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7a6:	48d1                	li	a7,20
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7ae:	48a5                	li	a7,9
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7b6:	48a9                	li	a7,10
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7be:	48ad                	li	a7,11
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7c6:	48b1                	li	a7,12
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7ce:	48b5                	li	a7,13
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7d6:	48b9                	li	a7,14
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <ps>:
.global ps
ps:
 li a7, SYS_ps
 7de:	48d9                	li	a7,22
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7e6:	48dd                	li	a7,23
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7ee:	48e1                	li	a7,24
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7f6:	1101                	addi	sp,sp,-32
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 802:	4605                	li	a2,1
 804:	fef40593          	addi	a1,s0,-17
 808:	00000097          	auipc	ra,0x0
 80c:	f56080e7          	jalr	-170(ra) # 75e <write>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6105                	addi	sp,sp,32
 816:	8082                	ret

0000000000000818 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 818:	7139                	addi	sp,sp,-64
 81a:	fc06                	sd	ra,56(sp)
 81c:	f822                	sd	s0,48(sp)
 81e:	f426                	sd	s1,40(sp)
 820:	f04a                	sd	s2,32(sp)
 822:	ec4e                	sd	s3,24(sp)
 824:	0080                	addi	s0,sp,64
 826:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 828:	c299                	beqz	a3,82e <printint+0x16>
 82a:	0805c963          	bltz	a1,8bc <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 82e:	2581                	sext.w	a1,a1
  neg = 0;
 830:	4881                	li	a7,0
 832:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 836:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 838:	2601                	sext.w	a2,a2
 83a:	00000517          	auipc	a0,0x0
 83e:	54e50513          	addi	a0,a0,1358 # d88 <digits>
 842:	883a                	mv	a6,a4
 844:	2705                	addiw	a4,a4,1
 846:	02c5f7bb          	remuw	a5,a1,a2
 84a:	1782                	slli	a5,a5,0x20
 84c:	9381                	srli	a5,a5,0x20
 84e:	97aa                	add	a5,a5,a0
 850:	0007c783          	lbu	a5,0(a5)
 854:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 858:	0005879b          	sext.w	a5,a1
 85c:	02c5d5bb          	divuw	a1,a1,a2
 860:	0685                	addi	a3,a3,1
 862:	fec7f0e3          	bgeu	a5,a2,842 <printint+0x2a>
  if(neg)
 866:	00088c63          	beqz	a7,87e <printint+0x66>
    buf[i++] = '-';
 86a:	fd070793          	addi	a5,a4,-48
 86e:	00878733          	add	a4,a5,s0
 872:	02d00793          	li	a5,45
 876:	fef70823          	sb	a5,-16(a4)
 87a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 87e:	02e05863          	blez	a4,8ae <printint+0x96>
 882:	fc040793          	addi	a5,s0,-64
 886:	00e78933          	add	s2,a5,a4
 88a:	fff78993          	addi	s3,a5,-1
 88e:	99ba                	add	s3,s3,a4
 890:	377d                	addiw	a4,a4,-1
 892:	1702                	slli	a4,a4,0x20
 894:	9301                	srli	a4,a4,0x20
 896:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 89a:	fff94583          	lbu	a1,-1(s2)
 89e:	8526                	mv	a0,s1
 8a0:	00000097          	auipc	ra,0x0
 8a4:	f56080e7          	jalr	-170(ra) # 7f6 <putc>
  while(--i >= 0)
 8a8:	197d                	addi	s2,s2,-1
 8aa:	ff3918e3          	bne	s2,s3,89a <printint+0x82>
}
 8ae:	70e2                	ld	ra,56(sp)
 8b0:	7442                	ld	s0,48(sp)
 8b2:	74a2                	ld	s1,40(sp)
 8b4:	7902                	ld	s2,32(sp)
 8b6:	69e2                	ld	s3,24(sp)
 8b8:	6121                	addi	sp,sp,64
 8ba:	8082                	ret
    x = -xx;
 8bc:	40b005bb          	negw	a1,a1
    neg = 1;
 8c0:	4885                	li	a7,1
    x = -xx;
 8c2:	bf85                	j	832 <printint+0x1a>

00000000000008c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8c4:	715d                	addi	sp,sp,-80
 8c6:	e486                	sd	ra,72(sp)
 8c8:	e0a2                	sd	s0,64(sp)
 8ca:	fc26                	sd	s1,56(sp)
 8cc:	f84a                	sd	s2,48(sp)
 8ce:	f44e                	sd	s3,40(sp)
 8d0:	f052                	sd	s4,32(sp)
 8d2:	ec56                	sd	s5,24(sp)
 8d4:	e85a                	sd	s6,16(sp)
 8d6:	e45e                	sd	s7,8(sp)
 8d8:	e062                	sd	s8,0(sp)
 8da:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8dc:	0005c903          	lbu	s2,0(a1)
 8e0:	18090c63          	beqz	s2,a78 <vprintf+0x1b4>
 8e4:	8aaa                	mv	s5,a0
 8e6:	8bb2                	mv	s7,a2
 8e8:	00158493          	addi	s1,a1,1
  state = 0;
 8ec:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8ee:	02500a13          	li	s4,37
 8f2:	4b55                	li	s6,21
 8f4:	a839                	j	912 <vprintf+0x4e>
        putc(fd, c);
 8f6:	85ca                	mv	a1,s2
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	efc080e7          	jalr	-260(ra) # 7f6 <putc>
 902:	a019                	j	908 <vprintf+0x44>
    } else if(state == '%'){
 904:	01498d63          	beq	s3,s4,91e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 908:	0485                	addi	s1,s1,1
 90a:	fff4c903          	lbu	s2,-1(s1)
 90e:	16090563          	beqz	s2,a78 <vprintf+0x1b4>
    if(state == 0){
 912:	fe0999e3          	bnez	s3,904 <vprintf+0x40>
      if(c == '%'){
 916:	ff4910e3          	bne	s2,s4,8f6 <vprintf+0x32>
        state = '%';
 91a:	89d2                	mv	s3,s4
 91c:	b7f5                	j	908 <vprintf+0x44>
      if(c == 'd'){
 91e:	13490263          	beq	s2,s4,a42 <vprintf+0x17e>
 922:	f9d9079b          	addiw	a5,s2,-99
 926:	0ff7f793          	zext.b	a5,a5
 92a:	12fb6563          	bltu	s6,a5,a54 <vprintf+0x190>
 92e:	f9d9079b          	addiw	a5,s2,-99
 932:	0ff7f713          	zext.b	a4,a5
 936:	10eb6f63          	bltu	s6,a4,a54 <vprintf+0x190>
 93a:	00271793          	slli	a5,a4,0x2
 93e:	00000717          	auipc	a4,0x0
 942:	3f270713          	addi	a4,a4,1010 # d30 <malloc+0x1ba>
 946:	97ba                	add	a5,a5,a4
 948:	439c                	lw	a5,0(a5)
 94a:	97ba                	add	a5,a5,a4
 94c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 94e:	008b8913          	addi	s2,s7,8
 952:	4685                	li	a3,1
 954:	4629                	li	a2,10
 956:	000ba583          	lw	a1,0(s7)
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	ebc080e7          	jalr	-324(ra) # 818 <printint>
 964:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 966:	4981                	li	s3,0
 968:	b745                	j	908 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 96a:	008b8913          	addi	s2,s7,8
 96e:	4681                	li	a3,0
 970:	4629                	li	a2,10
 972:	000ba583          	lw	a1,0(s7)
 976:	8556                	mv	a0,s5
 978:	00000097          	auipc	ra,0x0
 97c:	ea0080e7          	jalr	-352(ra) # 818 <printint>
 980:	8bca                	mv	s7,s2
      state = 0;
 982:	4981                	li	s3,0
 984:	b751                	j	908 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 986:	008b8913          	addi	s2,s7,8
 98a:	4681                	li	a3,0
 98c:	4641                	li	a2,16
 98e:	000ba583          	lw	a1,0(s7)
 992:	8556                	mv	a0,s5
 994:	00000097          	auipc	ra,0x0
 998:	e84080e7          	jalr	-380(ra) # 818 <printint>
 99c:	8bca                	mv	s7,s2
      state = 0;
 99e:	4981                	li	s3,0
 9a0:	b7a5                	j	908 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9a2:	008b8c13          	addi	s8,s7,8
 9a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9aa:	03000593          	li	a1,48
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	e46080e7          	jalr	-442(ra) # 7f6 <putc>
  putc(fd, 'x');
 9b8:	07800593          	li	a1,120
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	e38080e7          	jalr	-456(ra) # 7f6 <putc>
 9c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9c8:	00000b97          	auipc	s7,0x0
 9cc:	3c0b8b93          	addi	s7,s7,960 # d88 <digits>
 9d0:	03c9d793          	srli	a5,s3,0x3c
 9d4:	97de                	add	a5,a5,s7
 9d6:	0007c583          	lbu	a1,0(a5)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	e1a080e7          	jalr	-486(ra) # 7f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9e4:	0992                	slli	s3,s3,0x4
 9e6:	397d                	addiw	s2,s2,-1
 9e8:	fe0914e3          	bnez	s2,9d0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9ec:	8be2                	mv	s7,s8
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	bf21                	j	908 <vprintf+0x44>
        s = va_arg(ap, char*);
 9f2:	008b8993          	addi	s3,s7,8
 9f6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9fa:	02090163          	beqz	s2,a1c <vprintf+0x158>
        while(*s != 0){
 9fe:	00094583          	lbu	a1,0(s2)
 a02:	c9a5                	beqz	a1,a72 <vprintf+0x1ae>
          putc(fd, *s);
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	df0080e7          	jalr	-528(ra) # 7f6 <putc>
          s++;
 a0e:	0905                	addi	s2,s2,1
        while(*s != 0){
 a10:	00094583          	lbu	a1,0(s2)
 a14:	f9e5                	bnez	a1,a04 <vprintf+0x140>
        s = va_arg(ap, char*);
 a16:	8bce                	mv	s7,s3
      state = 0;
 a18:	4981                	li	s3,0
 a1a:	b5fd                	j	908 <vprintf+0x44>
          s = "(null)";
 a1c:	00000917          	auipc	s2,0x0
 a20:	30c90913          	addi	s2,s2,780 # d28 <malloc+0x1b2>
        while(*s != 0){
 a24:	02800593          	li	a1,40
 a28:	bff1                	j	a04 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a2a:	008b8913          	addi	s2,s7,8
 a2e:	000bc583          	lbu	a1,0(s7)
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	dc2080e7          	jalr	-574(ra) # 7f6 <putc>
 a3c:	8bca                	mv	s7,s2
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	b5e1                	j	908 <vprintf+0x44>
        putc(fd, c);
 a42:	02500593          	li	a1,37
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	dae080e7          	jalr	-594(ra) # 7f6 <putc>
      state = 0;
 a50:	4981                	li	s3,0
 a52:	bd5d                	j	908 <vprintf+0x44>
        putc(fd, '%');
 a54:	02500593          	li	a1,37
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	d9c080e7          	jalr	-612(ra) # 7f6 <putc>
        putc(fd, c);
 a62:	85ca                	mv	a1,s2
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	d90080e7          	jalr	-624(ra) # 7f6 <putc>
      state = 0;
 a6e:	4981                	li	s3,0
 a70:	bd61                	j	908 <vprintf+0x44>
        s = va_arg(ap, char*);
 a72:	8bce                	mv	s7,s3
      state = 0;
 a74:	4981                	li	s3,0
 a76:	bd49                	j	908 <vprintf+0x44>
    }
  }
}
 a78:	60a6                	ld	ra,72(sp)
 a7a:	6406                	ld	s0,64(sp)
 a7c:	74e2                	ld	s1,56(sp)
 a7e:	7942                	ld	s2,48(sp)
 a80:	79a2                	ld	s3,40(sp)
 a82:	7a02                	ld	s4,32(sp)
 a84:	6ae2                	ld	s5,24(sp)
 a86:	6b42                	ld	s6,16(sp)
 a88:	6ba2                	ld	s7,8(sp)
 a8a:	6c02                	ld	s8,0(sp)
 a8c:	6161                	addi	sp,sp,80
 a8e:	8082                	ret

0000000000000a90 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a90:	715d                	addi	sp,sp,-80
 a92:	ec06                	sd	ra,24(sp)
 a94:	e822                	sd	s0,16(sp)
 a96:	1000                	addi	s0,sp,32
 a98:	e010                	sd	a2,0(s0)
 a9a:	e414                	sd	a3,8(s0)
 a9c:	e818                	sd	a4,16(s0)
 a9e:	ec1c                	sd	a5,24(s0)
 aa0:	03043023          	sd	a6,32(s0)
 aa4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aac:	8622                	mv	a2,s0
 aae:	00000097          	auipc	ra,0x0
 ab2:	e16080e7          	jalr	-490(ra) # 8c4 <vprintf>
}
 ab6:	60e2                	ld	ra,24(sp)
 ab8:	6442                	ld	s0,16(sp)
 aba:	6161                	addi	sp,sp,80
 abc:	8082                	ret

0000000000000abe <printf>:

void
printf(const char *fmt, ...)
{
 abe:	711d                	addi	sp,sp,-96
 ac0:	ec06                	sd	ra,24(sp)
 ac2:	e822                	sd	s0,16(sp)
 ac4:	1000                	addi	s0,sp,32
 ac6:	e40c                	sd	a1,8(s0)
 ac8:	e810                	sd	a2,16(s0)
 aca:	ec14                	sd	a3,24(s0)
 acc:	f018                	sd	a4,32(s0)
 ace:	f41c                	sd	a5,40(s0)
 ad0:	03043823          	sd	a6,48(s0)
 ad4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad8:	00840613          	addi	a2,s0,8
 adc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ae0:	85aa                	mv	a1,a0
 ae2:	4505                	li	a0,1
 ae4:	00000097          	auipc	ra,0x0
 ae8:	de0080e7          	jalr	-544(ra) # 8c4 <vprintf>
}
 aec:	60e2                	ld	ra,24(sp)
 aee:	6442                	ld	s0,16(sp)
 af0:	6125                	addi	sp,sp,96
 af2:	8082                	ret

0000000000000af4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 af4:	1141                	addi	sp,sp,-16
 af6:	e422                	sd	s0,8(sp)
 af8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 afa:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 afe:	00000797          	auipc	a5,0x0
 b02:	52a7b783          	ld	a5,1322(a5) # 1028 <freep>
 b06:	a02d                	j	b30 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b08:	4618                	lw	a4,8(a2)
 b0a:	9f2d                	addw	a4,a4,a1
 b0c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b10:	6398                	ld	a4,0(a5)
 b12:	6310                	ld	a2,0(a4)
 b14:	a83d                	j	b52 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b16:	ff852703          	lw	a4,-8(a0)
 b1a:	9f31                	addw	a4,a4,a2
 b1c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b1e:	ff053683          	ld	a3,-16(a0)
 b22:	a091                	j	b66 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b24:	6398                	ld	a4,0(a5)
 b26:	00e7e463          	bltu	a5,a4,b2e <free+0x3a>
 b2a:	00e6ea63          	bltu	a3,a4,b3e <free+0x4a>
{
 b2e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b30:	fed7fae3          	bgeu	a5,a3,b24 <free+0x30>
 b34:	6398                	ld	a4,0(a5)
 b36:	00e6e463          	bltu	a3,a4,b3e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	fee7eae3          	bltu	a5,a4,b2e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b3e:	ff852583          	lw	a1,-8(a0)
 b42:	6390                	ld	a2,0(a5)
 b44:	02059813          	slli	a6,a1,0x20
 b48:	01c85713          	srli	a4,a6,0x1c
 b4c:	9736                	add	a4,a4,a3
 b4e:	fae60de3          	beq	a2,a4,b08 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b52:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b56:	4790                	lw	a2,8(a5)
 b58:	02061593          	slli	a1,a2,0x20
 b5c:	01c5d713          	srli	a4,a1,0x1c
 b60:	973e                	add	a4,a4,a5
 b62:	fae68ae3          	beq	a3,a4,b16 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b66:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b68:	00000717          	auipc	a4,0x0
 b6c:	4cf73023          	sd	a5,1216(a4) # 1028 <freep>
}
 b70:	6422                	ld	s0,8(sp)
 b72:	0141                	addi	sp,sp,16
 b74:	8082                	ret

0000000000000b76 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b76:	7139                	addi	sp,sp,-64
 b78:	fc06                	sd	ra,56(sp)
 b7a:	f822                	sd	s0,48(sp)
 b7c:	f426                	sd	s1,40(sp)
 b7e:	f04a                	sd	s2,32(sp)
 b80:	ec4e                	sd	s3,24(sp)
 b82:	e852                	sd	s4,16(sp)
 b84:	e456                	sd	s5,8(sp)
 b86:	e05a                	sd	s6,0(sp)
 b88:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b8a:	02051493          	slli	s1,a0,0x20
 b8e:	9081                	srli	s1,s1,0x20
 b90:	04bd                	addi	s1,s1,15
 b92:	8091                	srli	s1,s1,0x4
 b94:	0014899b          	addiw	s3,s1,1
 b98:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b9a:	00000517          	auipc	a0,0x0
 b9e:	48e53503          	ld	a0,1166(a0) # 1028 <freep>
 ba2:	c515                	beqz	a0,bce <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ba4:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 ba6:	4798                	lw	a4,8(a5)
 ba8:	02977f63          	bgeu	a4,s1,be6 <malloc+0x70>
    if (nu < 4096)
 bac:	8a4e                	mv	s4,s3
 bae:	0009871b          	sext.w	a4,s3
 bb2:	6685                	lui	a3,0x1
 bb4:	00d77363          	bgeu	a4,a3,bba <malloc+0x44>
 bb8:	6a05                	lui	s4,0x1
 bba:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bbe:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bc2:	00000917          	auipc	s2,0x0
 bc6:	46690913          	addi	s2,s2,1126 # 1028 <freep>
    if (p == (char *)-1)
 bca:	5afd                	li	s5,-1
 bcc:	a895                	j	c40 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bce:	00000797          	auipc	a5,0x0
 bd2:	4e278793          	addi	a5,a5,1250 # 10b0 <base>
 bd6:	00000717          	auipc	a4,0x0
 bda:	44f73923          	sd	a5,1106(a4) # 1028 <freep>
 bde:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 be0:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 be4:	b7e1                	j	bac <malloc+0x36>
            if (p->s.size == nunits)
 be6:	02e48c63          	beq	s1,a4,c1e <malloc+0xa8>
                p->s.size -= nunits;
 bea:	4137073b          	subw	a4,a4,s3
 bee:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bf0:	02071693          	slli	a3,a4,0x20
 bf4:	01c6d713          	srli	a4,a3,0x1c
 bf8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bfa:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bfe:	00000717          	auipc	a4,0x0
 c02:	42a73523          	sd	a0,1066(a4) # 1028 <freep>
            return (void *)(p + 1);
 c06:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c0a:	70e2                	ld	ra,56(sp)
 c0c:	7442                	ld	s0,48(sp)
 c0e:	74a2                	ld	s1,40(sp)
 c10:	7902                	ld	s2,32(sp)
 c12:	69e2                	ld	s3,24(sp)
 c14:	6a42                	ld	s4,16(sp)
 c16:	6aa2                	ld	s5,8(sp)
 c18:	6b02                	ld	s6,0(sp)
 c1a:	6121                	addi	sp,sp,64
 c1c:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c1e:	6398                	ld	a4,0(a5)
 c20:	e118                	sd	a4,0(a0)
 c22:	bff1                	j	bfe <malloc+0x88>
    hp->s.size = nu;
 c24:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c28:	0541                	addi	a0,a0,16
 c2a:	00000097          	auipc	ra,0x0
 c2e:	eca080e7          	jalr	-310(ra) # af4 <free>
    return freep;
 c32:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c36:	d971                	beqz	a0,c0a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c38:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c3a:	4798                	lw	a4,8(a5)
 c3c:	fa9775e3          	bgeu	a4,s1,be6 <malloc+0x70>
        if (p == freep)
 c40:	00093703          	ld	a4,0(s2)
 c44:	853e                	mv	a0,a5
 c46:	fef719e3          	bne	a4,a5,c38 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c4a:	8552                	mv	a0,s4
 c4c:	00000097          	auipc	ra,0x0
 c50:	b7a080e7          	jalr	-1158(ra) # 7c6 <sbrk>
    if (p == (char *)-1)
 c54:	fd5518e3          	bne	a0,s5,c24 <malloc+0xae>
                return 0;
 c58:	4501                	li	a0,0
 c5a:	bf45                	j	c0a <malloc+0x94>
