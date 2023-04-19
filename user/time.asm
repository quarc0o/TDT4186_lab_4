
user/_time:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    if (argc < 2)
   c:	4785                	li	a5,1
   e:	02a7db63          	bge	a5,a0,44 <main+0x44>
  12:	84ae                	mv	s1,a1
        printf("Time took 0 ticks\n");
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
        exit(1);
    }

    int startticks = uptime();
  14:	00000097          	auipc	ra,0x0
  18:	77e080e7          	jalr	1918(ra) # 792 <uptime>
  1c:	892a                	mv	s2,a0

    // we now start the program in a separate process:
    int uutPid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	6d4080e7          	jalr	1748(ra) # 6f2 <fork>

    // check if fork worked:
    if (uutPid < 0)
  26:	04054463          	bltz	a0,6e <main+0x6e>
    {
        printf("fork failed... couldn't start %s", argv[1]);
        exit(1);
    }

    if (uutPid == 0)
  2a:	e125                	bnez	a0,8a <main+0x8a>
    {
        // we are the unit under test part of the program - execute the program immediately
        exec(argv[1], argv + 1); // pass rest of the command line to the executable as args
  2c:	00848593          	addi	a1,s1,8
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	700080e7          	jalr	1792(ra) # 732 <exec>
        // wait for the uut to finish
        wait(0);
        int endticks = uptime();
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
    }
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	6be080e7          	jalr	1726(ra) # 6fa <exit>
        printf("Time took 0 ticks\n");
  44:	00001517          	auipc	a0,0x1
  48:	bdc50513          	addi	a0,a0,-1060 # c20 <malloc+0xee>
  4c:	00001097          	auipc	ra,0x1
  50:	a2e080e7          	jalr	-1490(ra) # a7a <printf>
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
  54:	00001517          	auipc	a0,0x1
  58:	be450513          	addi	a0,a0,-1052 # c38 <malloc+0x106>
  5c:	00001097          	auipc	ra,0x1
  60:	a1e080e7          	jalr	-1506(ra) # a7a <printf>
        exit(1);
  64:	4505                	li	a0,1
  66:	00000097          	auipc	ra,0x0
  6a:	694080e7          	jalr	1684(ra) # 6fa <exit>
        printf("fork failed... couldn't start %s", argv[1]);
  6e:	648c                	ld	a1,8(s1)
  70:	00001517          	auipc	a0,0x1
  74:	bf050513          	addi	a0,a0,-1040 # c60 <malloc+0x12e>
  78:	00001097          	auipc	ra,0x1
  7c:	a02080e7          	jalr	-1534(ra) # a7a <printf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	678080e7          	jalr	1656(ra) # 6fa <exit>
        wait(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	676080e7          	jalr	1654(ra) # 702 <wait>
        int endticks = uptime();
  94:	00000097          	auipc	ra,0x0
  98:	6fe080e7          	jalr	1790(ra) # 792 <uptime>
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
  9c:	4125063b          	subw	a2,a0,s2
  a0:	648c                	ld	a1,8(s1)
  a2:	00001517          	auipc	a0,0x1
  a6:	be650513          	addi	a0,a0,-1050 # c88 <malloc+0x156>
  aa:	00001097          	auipc	ra,0x1
  ae:	9d0080e7          	jalr	-1584(ra) # a7a <printf>
  b2:	b761                	j	3a <main+0x3a>

00000000000000b4 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
    lk->name = name;
  ba:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  bc:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  c0:	57fd                	li	a5,-1
  c2:	00f50823          	sb	a5,16(a0)
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  cc:	00054783          	lbu	a5,0(a0)
  d0:	e399                	bnez	a5,d6 <holding+0xa>
  d2:	4501                	li	a0,0
}
  d4:	8082                	ret
{
  d6:	1101                	addi	sp,sp,-32
  d8:	ec06                	sd	ra,24(sp)
  da:	e822                	sd	s0,16(sp)
  dc:	e426                	sd	s1,8(sp)
  de:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  e0:	01054483          	lbu	s1,16(a0)
  e4:	00000097          	auipc	ra,0x0
  e8:	2c4080e7          	jalr	708(ra) # 3a8 <twhoami>
  ec:	2501                	sext.w	a0,a0
  ee:	40a48533          	sub	a0,s1,a0
  f2:	00153513          	seqz	a0,a0
}
  f6:	60e2                	ld	ra,24(sp)
  f8:	6442                	ld	s0,16(sp)
  fa:	64a2                	ld	s1,8(sp)
  fc:	6105                	addi	sp,sp,32
  fe:	8082                	ret

0000000000000100 <acquire>:

void acquire(struct lock *lk)
{
 100:	7179                	addi	sp,sp,-48
 102:	f406                	sd	ra,40(sp)
 104:	f022                	sd	s0,32(sp)
 106:	ec26                	sd	s1,24(sp)
 108:	e84a                	sd	s2,16(sp)
 10a:	e44e                	sd	s3,8(sp)
 10c:	e052                	sd	s4,0(sp)
 10e:	1800                	addi	s0,sp,48
 110:	8a2a                	mv	s4,a0
    if (holding(lk))
 112:	00000097          	auipc	ra,0x0
 116:	fba080e7          	jalr	-70(ra) # cc <holding>
 11a:	e919                	bnez	a0,130 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 11c:	ffca7493          	andi	s1,s4,-4
 120:	003a7913          	andi	s2,s4,3
 124:	0039191b          	slliw	s2,s2,0x3
 128:	4985                	li	s3,1
 12a:	012999bb          	sllw	s3,s3,s2
 12e:	a015                	j	152 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 130:	00001517          	auipc	a0,0x1
 134:	b7850513          	addi	a0,a0,-1160 # ca8 <malloc+0x176>
 138:	00001097          	auipc	ra,0x1
 13c:	942080e7          	jalr	-1726(ra) # a7a <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	5b8080e7          	jalr	1464(ra) # 6fa <exit>
    {
        // give up the cpu for other threads
        tyield();
 14a:	00000097          	auipc	ra,0x0
 14e:	1dc080e7          	jalr	476(ra) # 326 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 152:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 156:	0127d7bb          	srlw	a5,a5,s2
 15a:	0ff7f793          	zext.b	a5,a5
 15e:	f7f5                	bnez	a5,14a <acquire+0x4a>
    }

    __sync_synchronize();
 160:	0ff0000f          	fence

    lk->tid = twhoami();
 164:	00000097          	auipc	ra,0x0
 168:	244080e7          	jalr	580(ra) # 3a8 <twhoami>
 16c:	00aa0823          	sb	a0,16(s4)
}
 170:	70a2                	ld	ra,40(sp)
 172:	7402                	ld	s0,32(sp)
 174:	64e2                	ld	s1,24(sp)
 176:	6942                	ld	s2,16(sp)
 178:	69a2                	ld	s3,8(sp)
 17a:	6a02                	ld	s4,0(sp)
 17c:	6145                	addi	sp,sp,48
 17e:	8082                	ret

0000000000000180 <release>:

void release(struct lock *lk)
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e426                	sd	s1,8(sp)
 188:	1000                	addi	s0,sp,32
 18a:	84aa                	mv	s1,a0
    if (!holding(lk))
 18c:	00000097          	auipc	ra,0x0
 190:	f40080e7          	jalr	-192(ra) # cc <holding>
 194:	c11d                	beqz	a0,1ba <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 196:	57fd                	li	a5,-1
 198:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 19c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1a0:	0ff0000f          	fence
 1a4:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1a8:	00000097          	auipc	ra,0x0
 1ac:	17e080e7          	jalr	382(ra) # 326 <tyield>
}
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
        printf("releasing lock we are not holding");
 1ba:	00001517          	auipc	a0,0x1
 1be:	b1650513          	addi	a0,a0,-1258 # cd0 <malloc+0x19e>
 1c2:	00001097          	auipc	ra,0x1
 1c6:	8b8080e7          	jalr	-1864(ra) # a7a <printf>
        exit(-1);
 1ca:	557d                	li	a0,-1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	52e080e7          	jalr	1326(ra) # 6fa <exit>

00000000000001d4 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1d4:	00001517          	auipc	a0,0x1
 1d8:	e3c53503          	ld	a0,-452(a0) # 1010 <current_thread>
 1dc:	00001717          	auipc	a4,0x1
 1e0:	e4470713          	addi	a4,a4,-444 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1e4:	4781                	li	a5,0
 1e6:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1e8:	6314                	ld	a3,0(a4)
 1ea:	00a68763          	beq	a3,a0,1f8 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1ee:	2785                	addiw	a5,a5,1
 1f0:	0721                	addi	a4,a4,8
 1f2:	fec79be3          	bne	a5,a2,1e8 <tsched+0x14>
    int current_index = 0;
 1f6:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1f8:	0017869b          	addiw	a3,a5,1
 1fc:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 200:	00001817          	auipc	a6,0x1
 204:	e2080813          	addi	a6,a6,-480 # 1020 <threads>
 208:	488d                	li	a7,3
 20a:	a021                	j	212 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 20c:	2685                	addiw	a3,a3,1
 20e:	04c68363          	beq	a3,a2,254 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 212:	41f6d71b          	sraiw	a4,a3,0x1f
 216:	01c7571b          	srliw	a4,a4,0x1c
 21a:	00d707bb          	addw	a5,a4,a3
 21e:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 220:	9f99                	subw	a5,a5,a4
 222:	078e                	slli	a5,a5,0x3
 224:	97c2                	add	a5,a5,a6
 226:	638c                	ld	a1,0(a5)
 228:	d1f5                	beqz	a1,20c <tsched+0x38>
 22a:	5dbc                	lw	a5,120(a1)
 22c:	ff1790e3          	bne	a5,a7,20c <tsched+0x38>
{
 230:	1141                	addi	sp,sp,-16
 232:	e406                	sd	ra,8(sp)
 234:	e022                	sd	s0,0(sp)
 236:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 238:	00001797          	auipc	a5,0x1
 23c:	dcb7bc23          	sd	a1,-552(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 240:	05a1                	addi	a1,a1,8
 242:	0521                	addi	a0,a0,8
 244:	00000097          	auipc	ra,0x0
 248:	17c080e7          	jalr	380(ra) # 3c0 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 24c:	60a2                	ld	ra,8(sp)
 24e:	6402                	ld	s0,0(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret
 254:	8082                	ret

0000000000000256 <thread_wrapper>:
{
 256:	1101                	addi	sp,sp,-32
 258:	ec06                	sd	ra,24(sp)
 25a:	e822                	sd	s0,16(sp)
 25c:	e426                	sd	s1,8(sp)
 25e:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 260:	00001497          	auipc	s1,0x1
 264:	db048493          	addi	s1,s1,-592 # 1010 <current_thread>
 268:	609c                	ld	a5,0(s1)
 26a:	67d8                	ld	a4,136(a5)
 26c:	63c8                	ld	a0,128(a5)
 26e:	9702                	jalr	a4
    current_thread->state = EXITED;
 270:	609c                	ld	a5,0(s1)
 272:	4719                	li	a4,6
 274:	dfb8                	sw	a4,120(a5)
    tsched();
 276:	00000097          	auipc	ra,0x0
 27a:	f5e080e7          	jalr	-162(ra) # 1d4 <tsched>
}
 27e:	60e2                	ld	ra,24(sp)
 280:	6442                	ld	s0,16(sp)
 282:	64a2                	ld	s1,8(sp)
 284:	6105                	addi	sp,sp,32
 286:	8082                	ret

0000000000000288 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 288:	7179                	addi	sp,sp,-48
 28a:	f406                	sd	ra,40(sp)
 28c:	f022                	sd	s0,32(sp)
 28e:	ec26                	sd	s1,24(sp)
 290:	e84a                	sd	s2,16(sp)
 292:	e44e                	sd	s3,8(sp)
 294:	1800                	addi	s0,sp,48
 296:	84aa                	mv	s1,a0
 298:	89b2                	mv	s3,a2
 29a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 29c:	09800513          	li	a0,152
 2a0:	00001097          	auipc	ra,0x1
 2a4:	892080e7          	jalr	-1902(ra) # b32 <malloc>
 2a8:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2aa:	478d                	li	a5,3
 2ac:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2ae:	609c                	ld	a5,0(s1)
 2b0:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2b4:	609c                	ld	a5,0(s1)
 2b6:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 2ba:	6098                	ld	a4,0(s1)
 2bc:	00001797          	auipc	a5,0x1
 2c0:	d4478793          	addi	a5,a5,-700 # 1000 <next_tid>
 2c4:	4394                	lw	a3,0(a5)
 2c6:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2ca:	4398                	lw	a4,0(a5)
 2cc:	2705                	addiw	a4,a4,1
 2ce:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 2d0:	6505                	lui	a0,0x1
 2d2:	00001097          	auipc	ra,0x1
 2d6:	860080e7          	jalr	-1952(ra) # b32 <malloc>
 2da:	609c                	ld	a5,0(s1)
 2dc:	6705                	lui	a4,0x1
 2de:	953a                	add	a0,a0,a4
 2e0:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2e2:	609c                	ld	a5,0(s1)
 2e4:	00000717          	auipc	a4,0x0
 2e8:	f7270713          	addi	a4,a4,-142 # 256 <thread_wrapper>
 2ec:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2ee:	00001717          	auipc	a4,0x1
 2f2:	d3270713          	addi	a4,a4,-718 # 1020 <threads>
 2f6:	4781                	li	a5,0
 2f8:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2fa:	6314                	ld	a3,0(a4)
 2fc:	ce81                	beqz	a3,314 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2fe:	2785                	addiw	a5,a5,1
 300:	0721                	addi	a4,a4,8
 302:	fec79ce3          	bne	a5,a2,2fa <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 306:	70a2                	ld	ra,40(sp)
 308:	7402                	ld	s0,32(sp)
 30a:	64e2                	ld	s1,24(sp)
 30c:	6942                	ld	s2,16(sp)
 30e:	69a2                	ld	s3,8(sp)
 310:	6145                	addi	sp,sp,48
 312:	8082                	ret
            threads[i] = *thread;
 314:	6094                	ld	a3,0(s1)
 316:	078e                	slli	a5,a5,0x3
 318:	00001717          	auipc	a4,0x1
 31c:	d0870713          	addi	a4,a4,-760 # 1020 <threads>
 320:	97ba                	add	a5,a5,a4
 322:	e394                	sd	a3,0(a5)
            break;
 324:	b7cd                	j	306 <tcreate+0x7e>

0000000000000326 <tyield>:
    return 0;
}


void tyield()
{
 326:	1141                	addi	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 32e:	00001797          	auipc	a5,0x1
 332:	ce27b783          	ld	a5,-798(a5) # 1010 <current_thread>
 336:	470d                	li	a4,3
 338:	dfb8                	sw	a4,120(a5)
    tsched();
 33a:	00000097          	auipc	ra,0x0
 33e:	e9a080e7          	jalr	-358(ra) # 1d4 <tsched>
}
 342:	60a2                	ld	ra,8(sp)
 344:	6402                	ld	s0,0(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <tjoin>:
{
 34a:	1101                	addi	sp,sp,-32
 34c:	ec06                	sd	ra,24(sp)
 34e:	e822                	sd	s0,16(sp)
 350:	e426                	sd	s1,8(sp)
 352:	e04a                	sd	s2,0(sp)
 354:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 356:	00001797          	auipc	a5,0x1
 35a:	cca78793          	addi	a5,a5,-822 # 1020 <threads>
 35e:	00001697          	auipc	a3,0x1
 362:	d4268693          	addi	a3,a3,-702 # 10a0 <base>
 366:	a021                	j	36e <tjoin+0x24>
 368:	07a1                	addi	a5,a5,8
 36a:	02d78b63          	beq	a5,a3,3a0 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 36e:	6384                	ld	s1,0(a5)
 370:	dce5                	beqz	s1,368 <tjoin+0x1e>
 372:	0004c703          	lbu	a4,0(s1)
 376:	fea719e3          	bne	a4,a0,368 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 37a:	5cb8                	lw	a4,120(s1)
 37c:	4799                	li	a5,6
 37e:	4919                	li	s2,6
 380:	02f70263          	beq	a4,a5,3a4 <tjoin+0x5a>
        tyield();
 384:	00000097          	auipc	ra,0x0
 388:	fa2080e7          	jalr	-94(ra) # 326 <tyield>
    while (target_thread->state != EXITED) {
 38c:	5cbc                	lw	a5,120(s1)
 38e:	ff279be3          	bne	a5,s2,384 <tjoin+0x3a>
    return 0;
 392:	4501                	li	a0,0
}
 394:	60e2                	ld	ra,24(sp)
 396:	6442                	ld	s0,16(sp)
 398:	64a2                	ld	s1,8(sp)
 39a:	6902                	ld	s2,0(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret
        return -1;
 3a0:	557d                	li	a0,-1
 3a2:	bfcd                	j	394 <tjoin+0x4a>
    return 0;
 3a4:	4501                	li	a0,0
 3a6:	b7fd                	j	394 <tjoin+0x4a>

00000000000003a8 <twhoami>:

uint8 twhoami()
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3ae:	00001797          	auipc	a5,0x1
 3b2:	c627b783          	ld	a5,-926(a5) # 1010 <current_thread>
 3b6:	0007c503          	lbu	a0,0(a5)
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <tswtch>:
 3c0:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 3c4:	00253423          	sd	sp,8(a0)
 3c8:	e900                	sd	s0,16(a0)
 3ca:	ed04                	sd	s1,24(a0)
 3cc:	03253023          	sd	s2,32(a0)
 3d0:	03353423          	sd	s3,40(a0)
 3d4:	03453823          	sd	s4,48(a0)
 3d8:	03553c23          	sd	s5,56(a0)
 3dc:	05653023          	sd	s6,64(a0)
 3e0:	05753423          	sd	s7,72(a0)
 3e4:	05853823          	sd	s8,80(a0)
 3e8:	05953c23          	sd	s9,88(a0)
 3ec:	07a53023          	sd	s10,96(a0)
 3f0:	07b53423          	sd	s11,104(a0)
 3f4:	0005b083          	ld	ra,0(a1)
 3f8:	0085b103          	ld	sp,8(a1)
 3fc:	6980                	ld	s0,16(a1)
 3fe:	6d84                	ld	s1,24(a1)
 400:	0205b903          	ld	s2,32(a1)
 404:	0285b983          	ld	s3,40(a1)
 408:	0305ba03          	ld	s4,48(a1)
 40c:	0385ba83          	ld	s5,56(a1)
 410:	0405bb03          	ld	s6,64(a1)
 414:	0485bb83          	ld	s7,72(a1)
 418:	0505bc03          	ld	s8,80(a1)
 41c:	0585bc83          	ld	s9,88(a1)
 420:	0605bd03          	ld	s10,96(a1)
 424:	0685bd83          	ld	s11,104(a1)
 428:	8082                	ret

000000000000042a <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 42a:	1101                	addi	sp,sp,-32
 42c:	ec06                	sd	ra,24(sp)
 42e:	e822                	sd	s0,16(sp)
 430:	e426                	sd	s1,8(sp)
 432:	e04a                	sd	s2,0(sp)
 434:	1000                	addi	s0,sp,32
 436:	84aa                	mv	s1,a0
 438:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 43a:	09800513          	li	a0,152
 43e:	00000097          	auipc	ra,0x0
 442:	6f4080e7          	jalr	1780(ra) # b32 <malloc>

    main_thread->tid = 1;
 446:	4785                	li	a5,1
 448:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 44c:	4791                	li	a5,4
 44e:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 450:	00001797          	auipc	a5,0x1
 454:	bca7b023          	sd	a0,-1088(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 458:	00001797          	auipc	a5,0x1
 45c:	bc878793          	addi	a5,a5,-1080 # 1020 <threads>
 460:	00001717          	auipc	a4,0x1
 464:	c4070713          	addi	a4,a4,-960 # 10a0 <base>
        threads[i] = NULL;
 468:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 46c:	07a1                	addi	a5,a5,8
 46e:	fee79de3          	bne	a5,a4,468 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 472:	00001797          	auipc	a5,0x1
 476:	baa7b723          	sd	a0,-1106(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 47a:	85ca                	mv	a1,s2
 47c:	8526                	mv	a0,s1
 47e:	00000097          	auipc	ra,0x0
 482:	b82080e7          	jalr	-1150(ra) # 0 <main>
    //tsched();

    exit(res);
 486:	00000097          	auipc	ra,0x0
 48a:	274080e7          	jalr	628(ra) # 6fa <exit>

000000000000048e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 494:	87aa                	mv	a5,a0
 496:	0585                	addi	a1,a1,1
 498:	0785                	addi	a5,a5,1
 49a:	fff5c703          	lbu	a4,-1(a1)
 49e:	fee78fa3          	sb	a4,-1(a5)
 4a2:	fb75                	bnez	a4,496 <strcpy+0x8>
        ;
    return os;
}
 4a4:	6422                	ld	s0,8(sp)
 4a6:	0141                	addi	sp,sp,16
 4a8:	8082                	ret

00000000000004aa <strcmp>:

int strcmp(const char *p, const char *q)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4b0:	00054783          	lbu	a5,0(a0)
 4b4:	cb91                	beqz	a5,4c8 <strcmp+0x1e>
 4b6:	0005c703          	lbu	a4,0(a1)
 4ba:	00f71763          	bne	a4,a5,4c8 <strcmp+0x1e>
        p++, q++;
 4be:	0505                	addi	a0,a0,1
 4c0:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4c2:	00054783          	lbu	a5,0(a0)
 4c6:	fbe5                	bnez	a5,4b6 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4c8:	0005c503          	lbu	a0,0(a1)
}
 4cc:	40a7853b          	subw	a0,a5,a0
 4d0:	6422                	ld	s0,8(sp)
 4d2:	0141                	addi	sp,sp,16
 4d4:	8082                	ret

00000000000004d6 <strlen>:

uint strlen(const char *s)
{
 4d6:	1141                	addi	sp,sp,-16
 4d8:	e422                	sd	s0,8(sp)
 4da:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4dc:	00054783          	lbu	a5,0(a0)
 4e0:	cf91                	beqz	a5,4fc <strlen+0x26>
 4e2:	0505                	addi	a0,a0,1
 4e4:	87aa                	mv	a5,a0
 4e6:	86be                	mv	a3,a5
 4e8:	0785                	addi	a5,a5,1
 4ea:	fff7c703          	lbu	a4,-1(a5)
 4ee:	ff65                	bnez	a4,4e6 <strlen+0x10>
 4f0:	40a6853b          	subw	a0,a3,a0
 4f4:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret
    for (n = 0; s[n]; n++)
 4fc:	4501                	li	a0,0
 4fe:	bfe5                	j	4f6 <strlen+0x20>

0000000000000500 <memset>:

void *
memset(void *dst, int c, uint n)
{
 500:	1141                	addi	sp,sp,-16
 502:	e422                	sd	s0,8(sp)
 504:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 506:	ca19                	beqz	a2,51c <memset+0x1c>
 508:	87aa                	mv	a5,a0
 50a:	1602                	slli	a2,a2,0x20
 50c:	9201                	srli	a2,a2,0x20
 50e:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 512:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 516:	0785                	addi	a5,a5,1
 518:	fee79de3          	bne	a5,a4,512 <memset+0x12>
    }
    return dst;
}
 51c:	6422                	ld	s0,8(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret

0000000000000522 <strchr>:

char *
strchr(const char *s, char c)
{
 522:	1141                	addi	sp,sp,-16
 524:	e422                	sd	s0,8(sp)
 526:	0800                	addi	s0,sp,16
    for (; *s; s++)
 528:	00054783          	lbu	a5,0(a0)
 52c:	cb99                	beqz	a5,542 <strchr+0x20>
        if (*s == c)
 52e:	00f58763          	beq	a1,a5,53c <strchr+0x1a>
    for (; *s; s++)
 532:	0505                	addi	a0,a0,1
 534:	00054783          	lbu	a5,0(a0)
 538:	fbfd                	bnez	a5,52e <strchr+0xc>
            return (char *)s;
    return 0;
 53a:	4501                	li	a0,0
}
 53c:	6422                	ld	s0,8(sp)
 53e:	0141                	addi	sp,sp,16
 540:	8082                	ret
    return 0;
 542:	4501                	li	a0,0
 544:	bfe5                	j	53c <strchr+0x1a>

0000000000000546 <gets>:

char *
gets(char *buf, int max)
{
 546:	711d                	addi	sp,sp,-96
 548:	ec86                	sd	ra,88(sp)
 54a:	e8a2                	sd	s0,80(sp)
 54c:	e4a6                	sd	s1,72(sp)
 54e:	e0ca                	sd	s2,64(sp)
 550:	fc4e                	sd	s3,56(sp)
 552:	f852                	sd	s4,48(sp)
 554:	f456                	sd	s5,40(sp)
 556:	f05a                	sd	s6,32(sp)
 558:	ec5e                	sd	s7,24(sp)
 55a:	1080                	addi	s0,sp,96
 55c:	8baa                	mv	s7,a0
 55e:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 560:	892a                	mv	s2,a0
 562:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 564:	4aa9                	li	s5,10
 566:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 568:	89a6                	mv	s3,s1
 56a:	2485                	addiw	s1,s1,1
 56c:	0344d863          	bge	s1,s4,59c <gets+0x56>
        cc = read(0, &c, 1);
 570:	4605                	li	a2,1
 572:	faf40593          	addi	a1,s0,-81
 576:	4501                	li	a0,0
 578:	00000097          	auipc	ra,0x0
 57c:	19a080e7          	jalr	410(ra) # 712 <read>
        if (cc < 1)
 580:	00a05e63          	blez	a0,59c <gets+0x56>
        buf[i++] = c;
 584:	faf44783          	lbu	a5,-81(s0)
 588:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 58c:	01578763          	beq	a5,s5,59a <gets+0x54>
 590:	0905                	addi	s2,s2,1
 592:	fd679be3          	bne	a5,s6,568 <gets+0x22>
    for (i = 0; i + 1 < max;)
 596:	89a6                	mv	s3,s1
 598:	a011                	j	59c <gets+0x56>
 59a:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 59c:	99de                	add	s3,s3,s7
 59e:	00098023          	sb	zero,0(s3)
    return buf;
}
 5a2:	855e                	mv	a0,s7
 5a4:	60e6                	ld	ra,88(sp)
 5a6:	6446                	ld	s0,80(sp)
 5a8:	64a6                	ld	s1,72(sp)
 5aa:	6906                	ld	s2,64(sp)
 5ac:	79e2                	ld	s3,56(sp)
 5ae:	7a42                	ld	s4,48(sp)
 5b0:	7aa2                	ld	s5,40(sp)
 5b2:	7b02                	ld	s6,32(sp)
 5b4:	6be2                	ld	s7,24(sp)
 5b6:	6125                	addi	sp,sp,96
 5b8:	8082                	ret

00000000000005ba <stat>:

int stat(const char *n, struct stat *st)
{
 5ba:	1101                	addi	sp,sp,-32
 5bc:	ec06                	sd	ra,24(sp)
 5be:	e822                	sd	s0,16(sp)
 5c0:	e426                	sd	s1,8(sp)
 5c2:	e04a                	sd	s2,0(sp)
 5c4:	1000                	addi	s0,sp,32
 5c6:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5c8:	4581                	li	a1,0
 5ca:	00000097          	auipc	ra,0x0
 5ce:	170080e7          	jalr	368(ra) # 73a <open>
    if (fd < 0)
 5d2:	02054563          	bltz	a0,5fc <stat+0x42>
 5d6:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5d8:	85ca                	mv	a1,s2
 5da:	00000097          	auipc	ra,0x0
 5de:	178080e7          	jalr	376(ra) # 752 <fstat>
 5e2:	892a                	mv	s2,a0
    close(fd);
 5e4:	8526                	mv	a0,s1
 5e6:	00000097          	auipc	ra,0x0
 5ea:	13c080e7          	jalr	316(ra) # 722 <close>
    return r;
}
 5ee:	854a                	mv	a0,s2
 5f0:	60e2                	ld	ra,24(sp)
 5f2:	6442                	ld	s0,16(sp)
 5f4:	64a2                	ld	s1,8(sp)
 5f6:	6902                	ld	s2,0(sp)
 5f8:	6105                	addi	sp,sp,32
 5fa:	8082                	ret
        return -1;
 5fc:	597d                	li	s2,-1
 5fe:	bfc5                	j	5ee <stat+0x34>

0000000000000600 <atoi>:

int atoi(const char *s)
{
 600:	1141                	addi	sp,sp,-16
 602:	e422                	sd	s0,8(sp)
 604:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 606:	00054683          	lbu	a3,0(a0)
 60a:	fd06879b          	addiw	a5,a3,-48
 60e:	0ff7f793          	zext.b	a5,a5
 612:	4625                	li	a2,9
 614:	02f66863          	bltu	a2,a5,644 <atoi+0x44>
 618:	872a                	mv	a4,a0
    n = 0;
 61a:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 61c:	0705                	addi	a4,a4,1
 61e:	0025179b          	slliw	a5,a0,0x2
 622:	9fa9                	addw	a5,a5,a0
 624:	0017979b          	slliw	a5,a5,0x1
 628:	9fb5                	addw	a5,a5,a3
 62a:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 62e:	00074683          	lbu	a3,0(a4)
 632:	fd06879b          	addiw	a5,a3,-48
 636:	0ff7f793          	zext.b	a5,a5
 63a:	fef671e3          	bgeu	a2,a5,61c <atoi+0x1c>
    return n;
}
 63e:	6422                	ld	s0,8(sp)
 640:	0141                	addi	sp,sp,16
 642:	8082                	ret
    n = 0;
 644:	4501                	li	a0,0
 646:	bfe5                	j	63e <atoi+0x3e>

0000000000000648 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 648:	1141                	addi	sp,sp,-16
 64a:	e422                	sd	s0,8(sp)
 64c:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 64e:	02b57463          	bgeu	a0,a1,676 <memmove+0x2e>
    {
        while (n-- > 0)
 652:	00c05f63          	blez	a2,670 <memmove+0x28>
 656:	1602                	slli	a2,a2,0x20
 658:	9201                	srli	a2,a2,0x20
 65a:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 65e:	872a                	mv	a4,a0
            *dst++ = *src++;
 660:	0585                	addi	a1,a1,1
 662:	0705                	addi	a4,a4,1
 664:	fff5c683          	lbu	a3,-1(a1)
 668:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 66c:	fee79ae3          	bne	a5,a4,660 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 670:	6422                	ld	s0,8(sp)
 672:	0141                	addi	sp,sp,16
 674:	8082                	ret
        dst += n;
 676:	00c50733          	add	a4,a0,a2
        src += n;
 67a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 67c:	fec05ae3          	blez	a2,670 <memmove+0x28>
 680:	fff6079b          	addiw	a5,a2,-1
 684:	1782                	slli	a5,a5,0x20
 686:	9381                	srli	a5,a5,0x20
 688:	fff7c793          	not	a5,a5
 68c:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 68e:	15fd                	addi	a1,a1,-1
 690:	177d                	addi	a4,a4,-1
 692:	0005c683          	lbu	a3,0(a1)
 696:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 69a:	fee79ae3          	bne	a5,a4,68e <memmove+0x46>
 69e:	bfc9                	j	670 <memmove+0x28>

00000000000006a0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6a0:	1141                	addi	sp,sp,-16
 6a2:	e422                	sd	s0,8(sp)
 6a4:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6a6:	ca05                	beqz	a2,6d6 <memcmp+0x36>
 6a8:	fff6069b          	addiw	a3,a2,-1
 6ac:	1682                	slli	a3,a3,0x20
 6ae:	9281                	srli	a3,a3,0x20
 6b0:	0685                	addi	a3,a3,1
 6b2:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6b4:	00054783          	lbu	a5,0(a0)
 6b8:	0005c703          	lbu	a4,0(a1)
 6bc:	00e79863          	bne	a5,a4,6cc <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6c0:	0505                	addi	a0,a0,1
        p2++;
 6c2:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6c4:	fed518e3          	bne	a0,a3,6b4 <memcmp+0x14>
    }
    return 0;
 6c8:	4501                	li	a0,0
 6ca:	a019                	j	6d0 <memcmp+0x30>
            return *p1 - *p2;
 6cc:	40e7853b          	subw	a0,a5,a4
}
 6d0:	6422                	ld	s0,8(sp)
 6d2:	0141                	addi	sp,sp,16
 6d4:	8082                	ret
    return 0;
 6d6:	4501                	li	a0,0
 6d8:	bfe5                	j	6d0 <memcmp+0x30>

00000000000006da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6da:	1141                	addi	sp,sp,-16
 6dc:	e406                	sd	ra,8(sp)
 6de:	e022                	sd	s0,0(sp)
 6e0:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6e2:	00000097          	auipc	ra,0x0
 6e6:	f66080e7          	jalr	-154(ra) # 648 <memmove>
}
 6ea:	60a2                	ld	ra,8(sp)
 6ec:	6402                	ld	s0,0(sp)
 6ee:	0141                	addi	sp,sp,16
 6f0:	8082                	ret

00000000000006f2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6f2:	4885                	li	a7,1
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <exit>:
.global exit
exit:
 li a7, SYS_exit
 6fa:	4889                	li	a7,2
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <wait>:
.global wait
wait:
 li a7, SYS_wait
 702:	488d                	li	a7,3
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 70a:	4891                	li	a7,4
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <read>:
.global read
read:
 li a7, SYS_read
 712:	4895                	li	a7,5
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <write>:
.global write
write:
 li a7, SYS_write
 71a:	48c1                	li	a7,16
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <close>:
.global close
close:
 li a7, SYS_close
 722:	48d5                	li	a7,21
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <kill>:
.global kill
kill:
 li a7, SYS_kill
 72a:	4899                	li	a7,6
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <exec>:
.global exec
exec:
 li a7, SYS_exec
 732:	489d                	li	a7,7
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <open>:
.global open
open:
 li a7, SYS_open
 73a:	48bd                	li	a7,15
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 742:	48c5                	li	a7,17
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 74a:	48c9                	li	a7,18
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 752:	48a1                	li	a7,8
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <link>:
.global link
link:
 li a7, SYS_link
 75a:	48cd                	li	a7,19
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 762:	48d1                	li	a7,20
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 76a:	48a5                	li	a7,9
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <dup>:
.global dup
dup:
 li a7, SYS_dup
 772:	48a9                	li	a7,10
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 77a:	48ad                	li	a7,11
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 782:	48b1                	li	a7,12
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 78a:	48b5                	li	a7,13
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 792:	48b9                	li	a7,14
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <ps>:
.global ps
ps:
 li a7, SYS_ps
 79a:	48d9                	li	a7,22
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7a2:	48dd                	li	a7,23
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7aa:	48e1                	li	a7,24
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7b2:	1101                	addi	sp,sp,-32
 7b4:	ec06                	sd	ra,24(sp)
 7b6:	e822                	sd	s0,16(sp)
 7b8:	1000                	addi	s0,sp,32
 7ba:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7be:	4605                	li	a2,1
 7c0:	fef40593          	addi	a1,s0,-17
 7c4:	00000097          	auipc	ra,0x0
 7c8:	f56080e7          	jalr	-170(ra) # 71a <write>
}
 7cc:	60e2                	ld	ra,24(sp)
 7ce:	6442                	ld	s0,16(sp)
 7d0:	6105                	addi	sp,sp,32
 7d2:	8082                	ret

00000000000007d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7d4:	7139                	addi	sp,sp,-64
 7d6:	fc06                	sd	ra,56(sp)
 7d8:	f822                	sd	s0,48(sp)
 7da:	f426                	sd	s1,40(sp)
 7dc:	f04a                	sd	s2,32(sp)
 7de:	ec4e                	sd	s3,24(sp)
 7e0:	0080                	addi	s0,sp,64
 7e2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7e4:	c299                	beqz	a3,7ea <printint+0x16>
 7e6:	0805c963          	bltz	a1,878 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7ea:	2581                	sext.w	a1,a1
  neg = 0;
 7ec:	4881                	li	a7,0
 7ee:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7f2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7f4:	2601                	sext.w	a2,a2
 7f6:	00000517          	auipc	a0,0x0
 7fa:	56250513          	addi	a0,a0,1378 # d58 <digits>
 7fe:	883a                	mv	a6,a4
 800:	2705                	addiw	a4,a4,1
 802:	02c5f7bb          	remuw	a5,a1,a2
 806:	1782                	slli	a5,a5,0x20
 808:	9381                	srli	a5,a5,0x20
 80a:	97aa                	add	a5,a5,a0
 80c:	0007c783          	lbu	a5,0(a5)
 810:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 814:	0005879b          	sext.w	a5,a1
 818:	02c5d5bb          	divuw	a1,a1,a2
 81c:	0685                	addi	a3,a3,1
 81e:	fec7f0e3          	bgeu	a5,a2,7fe <printint+0x2a>
  if(neg)
 822:	00088c63          	beqz	a7,83a <printint+0x66>
    buf[i++] = '-';
 826:	fd070793          	addi	a5,a4,-48
 82a:	00878733          	add	a4,a5,s0
 82e:	02d00793          	li	a5,45
 832:	fef70823          	sb	a5,-16(a4)
 836:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 83a:	02e05863          	blez	a4,86a <printint+0x96>
 83e:	fc040793          	addi	a5,s0,-64
 842:	00e78933          	add	s2,a5,a4
 846:	fff78993          	addi	s3,a5,-1
 84a:	99ba                	add	s3,s3,a4
 84c:	377d                	addiw	a4,a4,-1
 84e:	1702                	slli	a4,a4,0x20
 850:	9301                	srli	a4,a4,0x20
 852:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 856:	fff94583          	lbu	a1,-1(s2)
 85a:	8526                	mv	a0,s1
 85c:	00000097          	auipc	ra,0x0
 860:	f56080e7          	jalr	-170(ra) # 7b2 <putc>
  while(--i >= 0)
 864:	197d                	addi	s2,s2,-1
 866:	ff3918e3          	bne	s2,s3,856 <printint+0x82>
}
 86a:	70e2                	ld	ra,56(sp)
 86c:	7442                	ld	s0,48(sp)
 86e:	74a2                	ld	s1,40(sp)
 870:	7902                	ld	s2,32(sp)
 872:	69e2                	ld	s3,24(sp)
 874:	6121                	addi	sp,sp,64
 876:	8082                	ret
    x = -xx;
 878:	40b005bb          	negw	a1,a1
    neg = 1;
 87c:	4885                	li	a7,1
    x = -xx;
 87e:	bf85                	j	7ee <printint+0x1a>

0000000000000880 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 880:	715d                	addi	sp,sp,-80
 882:	e486                	sd	ra,72(sp)
 884:	e0a2                	sd	s0,64(sp)
 886:	fc26                	sd	s1,56(sp)
 888:	f84a                	sd	s2,48(sp)
 88a:	f44e                	sd	s3,40(sp)
 88c:	f052                	sd	s4,32(sp)
 88e:	ec56                	sd	s5,24(sp)
 890:	e85a                	sd	s6,16(sp)
 892:	e45e                	sd	s7,8(sp)
 894:	e062                	sd	s8,0(sp)
 896:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 898:	0005c903          	lbu	s2,0(a1)
 89c:	18090c63          	beqz	s2,a34 <vprintf+0x1b4>
 8a0:	8aaa                	mv	s5,a0
 8a2:	8bb2                	mv	s7,a2
 8a4:	00158493          	addi	s1,a1,1
  state = 0;
 8a8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8aa:	02500a13          	li	s4,37
 8ae:	4b55                	li	s6,21
 8b0:	a839                	j	8ce <vprintf+0x4e>
        putc(fd, c);
 8b2:	85ca                	mv	a1,s2
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	efc080e7          	jalr	-260(ra) # 7b2 <putc>
 8be:	a019                	j	8c4 <vprintf+0x44>
    } else if(state == '%'){
 8c0:	01498d63          	beq	s3,s4,8da <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8c4:	0485                	addi	s1,s1,1
 8c6:	fff4c903          	lbu	s2,-1(s1)
 8ca:	16090563          	beqz	s2,a34 <vprintf+0x1b4>
    if(state == 0){
 8ce:	fe0999e3          	bnez	s3,8c0 <vprintf+0x40>
      if(c == '%'){
 8d2:	ff4910e3          	bne	s2,s4,8b2 <vprintf+0x32>
        state = '%';
 8d6:	89d2                	mv	s3,s4
 8d8:	b7f5                	j	8c4 <vprintf+0x44>
      if(c == 'd'){
 8da:	13490263          	beq	s2,s4,9fe <vprintf+0x17e>
 8de:	f9d9079b          	addiw	a5,s2,-99
 8e2:	0ff7f793          	zext.b	a5,a5
 8e6:	12fb6563          	bltu	s6,a5,a10 <vprintf+0x190>
 8ea:	f9d9079b          	addiw	a5,s2,-99
 8ee:	0ff7f713          	zext.b	a4,a5
 8f2:	10eb6f63          	bltu	s6,a4,a10 <vprintf+0x190>
 8f6:	00271793          	slli	a5,a4,0x2
 8fa:	00000717          	auipc	a4,0x0
 8fe:	40670713          	addi	a4,a4,1030 # d00 <malloc+0x1ce>
 902:	97ba                	add	a5,a5,a4
 904:	439c                	lw	a5,0(a5)
 906:	97ba                	add	a5,a5,a4
 908:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 90a:	008b8913          	addi	s2,s7,8
 90e:	4685                	li	a3,1
 910:	4629                	li	a2,10
 912:	000ba583          	lw	a1,0(s7)
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	ebc080e7          	jalr	-324(ra) # 7d4 <printint>
 920:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 922:	4981                	li	s3,0
 924:	b745                	j	8c4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 926:	008b8913          	addi	s2,s7,8
 92a:	4681                	li	a3,0
 92c:	4629                	li	a2,10
 92e:	000ba583          	lw	a1,0(s7)
 932:	8556                	mv	a0,s5
 934:	00000097          	auipc	ra,0x0
 938:	ea0080e7          	jalr	-352(ra) # 7d4 <printint>
 93c:	8bca                	mv	s7,s2
      state = 0;
 93e:	4981                	li	s3,0
 940:	b751                	j	8c4 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 942:	008b8913          	addi	s2,s7,8
 946:	4681                	li	a3,0
 948:	4641                	li	a2,16
 94a:	000ba583          	lw	a1,0(s7)
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	e84080e7          	jalr	-380(ra) # 7d4 <printint>
 958:	8bca                	mv	s7,s2
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b7a5                	j	8c4 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 95e:	008b8c13          	addi	s8,s7,8
 962:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 966:	03000593          	li	a1,48
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	e46080e7          	jalr	-442(ra) # 7b2 <putc>
  putc(fd, 'x');
 974:	07800593          	li	a1,120
 978:	8556                	mv	a0,s5
 97a:	00000097          	auipc	ra,0x0
 97e:	e38080e7          	jalr	-456(ra) # 7b2 <putc>
 982:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 984:	00000b97          	auipc	s7,0x0
 988:	3d4b8b93          	addi	s7,s7,980 # d58 <digits>
 98c:	03c9d793          	srli	a5,s3,0x3c
 990:	97de                	add	a5,a5,s7
 992:	0007c583          	lbu	a1,0(a5)
 996:	8556                	mv	a0,s5
 998:	00000097          	auipc	ra,0x0
 99c:	e1a080e7          	jalr	-486(ra) # 7b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9a0:	0992                	slli	s3,s3,0x4
 9a2:	397d                	addiw	s2,s2,-1
 9a4:	fe0914e3          	bnez	s2,98c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9a8:	8be2                	mv	s7,s8
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	bf21                	j	8c4 <vprintf+0x44>
        s = va_arg(ap, char*);
 9ae:	008b8993          	addi	s3,s7,8
 9b2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9b6:	02090163          	beqz	s2,9d8 <vprintf+0x158>
        while(*s != 0){
 9ba:	00094583          	lbu	a1,0(s2)
 9be:	c9a5                	beqz	a1,a2e <vprintf+0x1ae>
          putc(fd, *s);
 9c0:	8556                	mv	a0,s5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	df0080e7          	jalr	-528(ra) # 7b2 <putc>
          s++;
 9ca:	0905                	addi	s2,s2,1
        while(*s != 0){
 9cc:	00094583          	lbu	a1,0(s2)
 9d0:	f9e5                	bnez	a1,9c0 <vprintf+0x140>
        s = va_arg(ap, char*);
 9d2:	8bce                	mv	s7,s3
      state = 0;
 9d4:	4981                	li	s3,0
 9d6:	b5fd                	j	8c4 <vprintf+0x44>
          s = "(null)";
 9d8:	00000917          	auipc	s2,0x0
 9dc:	32090913          	addi	s2,s2,800 # cf8 <malloc+0x1c6>
        while(*s != 0){
 9e0:	02800593          	li	a1,40
 9e4:	bff1                	j	9c0 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9e6:	008b8913          	addi	s2,s7,8
 9ea:	000bc583          	lbu	a1,0(s7)
 9ee:	8556                	mv	a0,s5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	dc2080e7          	jalr	-574(ra) # 7b2 <putc>
 9f8:	8bca                	mv	s7,s2
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	b5e1                	j	8c4 <vprintf+0x44>
        putc(fd, c);
 9fe:	02500593          	li	a1,37
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	dae080e7          	jalr	-594(ra) # 7b2 <putc>
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	bd5d                	j	8c4 <vprintf+0x44>
        putc(fd, '%');
 a10:	02500593          	li	a1,37
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	d9c080e7          	jalr	-612(ra) # 7b2 <putc>
        putc(fd, c);
 a1e:	85ca                	mv	a1,s2
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	d90080e7          	jalr	-624(ra) # 7b2 <putc>
      state = 0;
 a2a:	4981                	li	s3,0
 a2c:	bd61                	j	8c4 <vprintf+0x44>
        s = va_arg(ap, char*);
 a2e:	8bce                	mv	s7,s3
      state = 0;
 a30:	4981                	li	s3,0
 a32:	bd49                	j	8c4 <vprintf+0x44>
    }
  }
}
 a34:	60a6                	ld	ra,72(sp)
 a36:	6406                	ld	s0,64(sp)
 a38:	74e2                	ld	s1,56(sp)
 a3a:	7942                	ld	s2,48(sp)
 a3c:	79a2                	ld	s3,40(sp)
 a3e:	7a02                	ld	s4,32(sp)
 a40:	6ae2                	ld	s5,24(sp)
 a42:	6b42                	ld	s6,16(sp)
 a44:	6ba2                	ld	s7,8(sp)
 a46:	6c02                	ld	s8,0(sp)
 a48:	6161                	addi	sp,sp,80
 a4a:	8082                	ret

0000000000000a4c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a4c:	715d                	addi	sp,sp,-80
 a4e:	ec06                	sd	ra,24(sp)
 a50:	e822                	sd	s0,16(sp)
 a52:	1000                	addi	s0,sp,32
 a54:	e010                	sd	a2,0(s0)
 a56:	e414                	sd	a3,8(s0)
 a58:	e818                	sd	a4,16(s0)
 a5a:	ec1c                	sd	a5,24(s0)
 a5c:	03043023          	sd	a6,32(s0)
 a60:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a64:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a68:	8622                	mv	a2,s0
 a6a:	00000097          	auipc	ra,0x0
 a6e:	e16080e7          	jalr	-490(ra) # 880 <vprintf>
}
 a72:	60e2                	ld	ra,24(sp)
 a74:	6442                	ld	s0,16(sp)
 a76:	6161                	addi	sp,sp,80
 a78:	8082                	ret

0000000000000a7a <printf>:

void
printf(const char *fmt, ...)
{
 a7a:	711d                	addi	sp,sp,-96
 a7c:	ec06                	sd	ra,24(sp)
 a7e:	e822                	sd	s0,16(sp)
 a80:	1000                	addi	s0,sp,32
 a82:	e40c                	sd	a1,8(s0)
 a84:	e810                	sd	a2,16(s0)
 a86:	ec14                	sd	a3,24(s0)
 a88:	f018                	sd	a4,32(s0)
 a8a:	f41c                	sd	a5,40(s0)
 a8c:	03043823          	sd	a6,48(s0)
 a90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a94:	00840613          	addi	a2,s0,8
 a98:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a9c:	85aa                	mv	a1,a0
 a9e:	4505                	li	a0,1
 aa0:	00000097          	auipc	ra,0x0
 aa4:	de0080e7          	jalr	-544(ra) # 880 <vprintf>
}
 aa8:	60e2                	ld	ra,24(sp)
 aaa:	6442                	ld	s0,16(sp)
 aac:	6125                	addi	sp,sp,96
 aae:	8082                	ret

0000000000000ab0 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ab0:	1141                	addi	sp,sp,-16
 ab2:	e422                	sd	s0,8(sp)
 ab4:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 ab6:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aba:	00000797          	auipc	a5,0x0
 abe:	55e7b783          	ld	a5,1374(a5) # 1018 <freep>
 ac2:	a02d                	j	aec <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ac4:	4618                	lw	a4,8(a2)
 ac6:	9f2d                	addw	a4,a4,a1
 ac8:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 acc:	6398                	ld	a4,0(a5)
 ace:	6310                	ld	a2,0(a4)
 ad0:	a83d                	j	b0e <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ad2:	ff852703          	lw	a4,-8(a0)
 ad6:	9f31                	addw	a4,a4,a2
 ad8:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ada:	ff053683          	ld	a3,-16(a0)
 ade:	a091                	j	b22 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae0:	6398                	ld	a4,0(a5)
 ae2:	00e7e463          	bltu	a5,a4,aea <free+0x3a>
 ae6:	00e6ea63          	bltu	a3,a4,afa <free+0x4a>
{
 aea:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aec:	fed7fae3          	bgeu	a5,a3,ae0 <free+0x30>
 af0:	6398                	ld	a4,0(a5)
 af2:	00e6e463          	bltu	a3,a4,afa <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af6:	fee7eae3          	bltu	a5,a4,aea <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 afa:	ff852583          	lw	a1,-8(a0)
 afe:	6390                	ld	a2,0(a5)
 b00:	02059813          	slli	a6,a1,0x20
 b04:	01c85713          	srli	a4,a6,0x1c
 b08:	9736                	add	a4,a4,a3
 b0a:	fae60de3          	beq	a2,a4,ac4 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b0e:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b12:	4790                	lw	a2,8(a5)
 b14:	02061593          	slli	a1,a2,0x20
 b18:	01c5d713          	srli	a4,a1,0x1c
 b1c:	973e                	add	a4,a4,a5
 b1e:	fae68ae3          	beq	a3,a4,ad2 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b22:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b24:	00000717          	auipc	a4,0x0
 b28:	4ef73a23          	sd	a5,1268(a4) # 1018 <freep>
}
 b2c:	6422                	ld	s0,8(sp)
 b2e:	0141                	addi	sp,sp,16
 b30:	8082                	ret

0000000000000b32 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b32:	7139                	addi	sp,sp,-64
 b34:	fc06                	sd	ra,56(sp)
 b36:	f822                	sd	s0,48(sp)
 b38:	f426                	sd	s1,40(sp)
 b3a:	f04a                	sd	s2,32(sp)
 b3c:	ec4e                	sd	s3,24(sp)
 b3e:	e852                	sd	s4,16(sp)
 b40:	e456                	sd	s5,8(sp)
 b42:	e05a                	sd	s6,0(sp)
 b44:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b46:	02051493          	slli	s1,a0,0x20
 b4a:	9081                	srli	s1,s1,0x20
 b4c:	04bd                	addi	s1,s1,15
 b4e:	8091                	srli	s1,s1,0x4
 b50:	0014899b          	addiw	s3,s1,1
 b54:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b56:	00000517          	auipc	a0,0x0
 b5a:	4c253503          	ld	a0,1218(a0) # 1018 <freep>
 b5e:	c515                	beqz	a0,b8a <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b60:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b62:	4798                	lw	a4,8(a5)
 b64:	02977f63          	bgeu	a4,s1,ba2 <malloc+0x70>
    if (nu < 4096)
 b68:	8a4e                	mv	s4,s3
 b6a:	0009871b          	sext.w	a4,s3
 b6e:	6685                	lui	a3,0x1
 b70:	00d77363          	bgeu	a4,a3,b76 <malloc+0x44>
 b74:	6a05                	lui	s4,0x1
 b76:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b7a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b7e:	00000917          	auipc	s2,0x0
 b82:	49a90913          	addi	s2,s2,1178 # 1018 <freep>
    if (p == (char *)-1)
 b86:	5afd                	li	s5,-1
 b88:	a895                	j	bfc <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b8a:	00000797          	auipc	a5,0x0
 b8e:	51678793          	addi	a5,a5,1302 # 10a0 <base>
 b92:	00000717          	auipc	a4,0x0
 b96:	48f73323          	sd	a5,1158(a4) # 1018 <freep>
 b9a:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b9c:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 ba0:	b7e1                	j	b68 <malloc+0x36>
            if (p->s.size == nunits)
 ba2:	02e48c63          	beq	s1,a4,bda <malloc+0xa8>
                p->s.size -= nunits;
 ba6:	4137073b          	subw	a4,a4,s3
 baa:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bac:	02071693          	slli	a3,a4,0x20
 bb0:	01c6d713          	srli	a4,a3,0x1c
 bb4:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bb6:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bba:	00000717          	auipc	a4,0x0
 bbe:	44a73f23          	sd	a0,1118(a4) # 1018 <freep>
            return (void *)(p + 1);
 bc2:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bc6:	70e2                	ld	ra,56(sp)
 bc8:	7442                	ld	s0,48(sp)
 bca:	74a2                	ld	s1,40(sp)
 bcc:	7902                	ld	s2,32(sp)
 bce:	69e2                	ld	s3,24(sp)
 bd0:	6a42                	ld	s4,16(sp)
 bd2:	6aa2                	ld	s5,8(sp)
 bd4:	6b02                	ld	s6,0(sp)
 bd6:	6121                	addi	sp,sp,64
 bd8:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bda:	6398                	ld	a4,0(a5)
 bdc:	e118                	sd	a4,0(a0)
 bde:	bff1                	j	bba <malloc+0x88>
    hp->s.size = nu;
 be0:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 be4:	0541                	addi	a0,a0,16
 be6:	00000097          	auipc	ra,0x0
 bea:	eca080e7          	jalr	-310(ra) # ab0 <free>
    return freep;
 bee:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bf2:	d971                	beqz	a0,bc6 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bf4:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bf6:	4798                	lw	a4,8(a5)
 bf8:	fa9775e3          	bgeu	a4,s1,ba2 <malloc+0x70>
        if (p == freep)
 bfc:	00093703          	ld	a4,0(s2)
 c00:	853e                	mv	a0,a5
 c02:	fef719e3          	bne	a4,a5,bf4 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c06:	8552                	mv	a0,s4
 c08:	00000097          	auipc	ra,0x0
 c0c:	b7a080e7          	jalr	-1158(ra) # 782 <sbrk>
    if (p == (char *)-1)
 c10:	fd5518e3          	bne	a0,s5,be0 <malloc+0xae>
                return 0;
 c14:	4501                	li	a0,0
 c16:	bf45                	j	bc6 <malloc+0x94>
