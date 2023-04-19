
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	cda78793          	addi	a5,a5,-806 # cf0 <malloc+0x122>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	c9450513          	addi	a0,a0,-876 # cc0 <malloc+0xf2>
  34:	00001097          	auipc	ra,0x1
  38:	ae2080e7          	jalr	-1310(ra) # b16 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	554080e7          	jalr	1364(ra) # 59c <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	73a080e7          	jalr	1850(ra) # 78e <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	c7050513          	addi	a0,a0,-912 # cd8 <malloc+0x10a>
  70:	00001097          	auipc	ra,0x1
  74:	aa6080e7          	jalr	-1370(ra) # b16 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	74c080e7          	jalr	1868(ra) # 7d6 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	716080e7          	jalr	1814(ra) # 7b6 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	710080e7          	jalr	1808(ra) # 7be <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	c3250513          	addi	a0,a0,-974 # ce8 <malloc+0x11a>
  be:	00001097          	auipc	ra,0x1
  c2:	a58080e7          	jalr	-1448(ra) # b16 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	70a080e7          	jalr	1802(ra) # 7d6 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	6cc080e7          	jalr	1740(ra) # 7ae <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	6ce080e7          	jalr	1742(ra) # 7be <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	6a4080e7          	jalr	1700(ra) # 79e <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	692080e7          	jalr	1682(ra) # 796 <exit>

000000000000010c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
    lk->name = name;
 112:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 114:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 118:	57fd                	li	a5,-1
 11a:	00f50823          	sb	a5,16(a0)
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 124:	00054783          	lbu	a5,0(a0)
 128:	e399                	bnez	a5,12e <holding+0xa>
 12a:	4501                	li	a0,0
}
 12c:	8082                	ret
{
 12e:	1101                	addi	sp,sp,-32
 130:	ec06                	sd	ra,24(sp)
 132:	e822                	sd	s0,16(sp)
 134:	e426                	sd	s1,8(sp)
 136:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 138:	01054483          	lbu	s1,16(a0)
 13c:	00000097          	auipc	ra,0x0
 140:	340080e7          	jalr	832(ra) # 47c <twhoami>
 144:	2501                	sext.w	a0,a0
 146:	40a48533          	sub	a0,s1,a0
 14a:	00153513          	seqz	a0,a0
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret

0000000000000158 <acquire>:

void acquire(struct lock *lk)
{
 158:	7179                	addi	sp,sp,-48
 15a:	f406                	sd	ra,40(sp)
 15c:	f022                	sd	s0,32(sp)
 15e:	ec26                	sd	s1,24(sp)
 160:	e84a                	sd	s2,16(sp)
 162:	e44e                	sd	s3,8(sp)
 164:	e052                	sd	s4,0(sp)
 166:	1800                	addi	s0,sp,48
 168:	8a2a                	mv	s4,a0
    if (holding(lk))
 16a:	00000097          	auipc	ra,0x0
 16e:	fba080e7          	jalr	-70(ra) # 124 <holding>
 172:	e919                	bnez	a0,188 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 174:	ffca7493          	andi	s1,s4,-4
 178:	003a7913          	andi	s2,s4,3
 17c:	0039191b          	slliw	s2,s2,0x3
 180:	4985                	li	s3,1
 182:	012999bb          	sllw	s3,s3,s2
 186:	a015                	j	1aa <acquire+0x52>
        printf("re-acquiring lock we already hold");
 188:	00001517          	auipc	a0,0x1
 18c:	b7850513          	addi	a0,a0,-1160 # d00 <malloc+0x132>
 190:	00001097          	auipc	ra,0x1
 194:	986080e7          	jalr	-1658(ra) # b16 <printf>
        exit(-1);
 198:	557d                	li	a0,-1
 19a:	00000097          	auipc	ra,0x0
 19e:	5fc080e7          	jalr	1532(ra) # 796 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1a2:	00000097          	auipc	ra,0x0
 1a6:	258080e7          	jalr	600(ra) # 3fa <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1aa:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1ae:	0127d7bb          	srlw	a5,a5,s2
 1b2:	0ff7f793          	zext.b	a5,a5
 1b6:	f7f5                	bnez	a5,1a2 <acquire+0x4a>
    }

    __sync_synchronize();
 1b8:	0ff0000f          	fence

    lk->tid = twhoami();
 1bc:	00000097          	auipc	ra,0x0
 1c0:	2c0080e7          	jalr	704(ra) # 47c <twhoami>
 1c4:	00aa0823          	sb	a0,16(s4)
}
 1c8:	70a2                	ld	ra,40(sp)
 1ca:	7402                	ld	s0,32(sp)
 1cc:	64e2                	ld	s1,24(sp)
 1ce:	6942                	ld	s2,16(sp)
 1d0:	69a2                	ld	s3,8(sp)
 1d2:	6a02                	ld	s4,0(sp)
 1d4:	6145                	addi	sp,sp,48
 1d6:	8082                	ret

00000000000001d8 <release>:

void release(struct lock *lk)
{
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	1000                	addi	s0,sp,32
 1e2:	84aa                	mv	s1,a0
    if (!holding(lk))
 1e4:	00000097          	auipc	ra,0x0
 1e8:	f40080e7          	jalr	-192(ra) # 124 <holding>
 1ec:	c11d                	beqz	a0,212 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1ee:	57fd                	li	a5,-1
 1f0:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1f4:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1f8:	0ff0000f          	fence
 1fc:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 200:	00000097          	auipc	ra,0x0
 204:	1fa080e7          	jalr	506(ra) # 3fa <tyield>
}
 208:	60e2                	ld	ra,24(sp)
 20a:	6442                	ld	s0,16(sp)
 20c:	64a2                	ld	s1,8(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
        printf("releasing lock we are not holding");
 212:	00001517          	auipc	a0,0x1
 216:	b1650513          	addi	a0,a0,-1258 # d28 <malloc+0x15a>
 21a:	00001097          	auipc	ra,0x1
 21e:	8fc080e7          	jalr	-1796(ra) # b16 <printf>
        exit(-1);
 222:	557d                	li	a0,-1
 224:	00000097          	auipc	ra,0x0
 228:	572080e7          	jalr	1394(ra) # 796 <exit>

000000000000022c <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 22c:	1141                	addi	sp,sp,-16
 22e:	e406                	sd	ra,8(sp)
 230:	e022                	sd	s0,0(sp)
 232:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 234:	09800513          	li	a0,152
 238:	00001097          	auipc	ra,0x1
 23c:	996080e7          	jalr	-1642(ra) # bce <malloc>

    main_thread->tid = next_tid;
 240:	00001797          	auipc	a5,0x1
 244:	dc078793          	addi	a5,a5,-576 # 1000 <next_tid>
 248:	4398                	lw	a4,0(a5)
 24a:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 24e:	4398                	lw	a4,0(a5)
 250:	2705                	addiw	a4,a4,1
 252:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 254:	4791                	li	a5,4
 256:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 258:	00001797          	auipc	a5,0x1
 25c:	daa7bc23          	sd	a0,-584(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 260:	00001797          	auipc	a5,0x1
 264:	dc078793          	addi	a5,a5,-576 # 1020 <threads>
 268:	00001717          	auipc	a4,0x1
 26c:	e3870713          	addi	a4,a4,-456 # 10a0 <base>
        threads[i] = NULL;
 270:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 274:	07a1                	addi	a5,a5,8
 276:	fee79de3          	bne	a5,a4,270 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 27a:	00001797          	auipc	a5,0x1
 27e:	daa7b323          	sd	a0,-602(a5) # 1020 <threads>
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret

000000000000028a <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 28a:	00001517          	auipc	a0,0x1
 28e:	d8653503          	ld	a0,-634(a0) # 1010 <current_thread>
 292:	00001717          	auipc	a4,0x1
 296:	d8e70713          	addi	a4,a4,-626 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 29a:	4781                	li	a5,0
 29c:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 29e:	6314                	ld	a3,0(a4)
 2a0:	00a68763          	beq	a3,a0,2ae <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 2a4:	2785                	addiw	a5,a5,1
 2a6:	0721                	addi	a4,a4,8
 2a8:	fec79be3          	bne	a5,a2,29e <tsched+0x14>
    int current_index = 0;
 2ac:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 2ae:	0017869b          	addiw	a3,a5,1
 2b2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2b6:	00001817          	auipc	a6,0x1
 2ba:	d6a80813          	addi	a6,a6,-662 # 1020 <threads>
 2be:	488d                	li	a7,3
 2c0:	a021                	j	2c8 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 2c2:	2685                	addiw	a3,a3,1
 2c4:	04c68363          	beq	a3,a2,30a <tsched+0x80>
        int next_index = (current_index + i) % 16;
 2c8:	41f6d71b          	sraiw	a4,a3,0x1f
 2cc:	01c7571b          	srliw	a4,a4,0x1c
 2d0:	00d707bb          	addw	a5,a4,a3
 2d4:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2d6:	9f99                	subw	a5,a5,a4
 2d8:	078e                	slli	a5,a5,0x3
 2da:	97c2                	add	a5,a5,a6
 2dc:	638c                	ld	a1,0(a5)
 2de:	d1f5                	beqz	a1,2c2 <tsched+0x38>
 2e0:	5dbc                	lw	a5,120(a1)
 2e2:	ff1790e3          	bne	a5,a7,2c2 <tsched+0x38>
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e406                	sd	ra,8(sp)
 2ea:	e022                	sd	s0,0(sp)
 2ec:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 2ee:	00001797          	auipc	a5,0x1
 2f2:	d2b7b123          	sd	a1,-734(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2f6:	05a1                	addi	a1,a1,8
 2f8:	0521                	addi	a0,a0,8
 2fa:	00000097          	auipc	ra,0x0
 2fe:	19a080e7          	jalr	410(ra) # 494 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 302:	60a2                	ld	ra,8(sp)
 304:	6402                	ld	s0,0(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
 30a:	8082                	ret

000000000000030c <thread_wrapper>:
{
 30c:	1101                	addi	sp,sp,-32
 30e:	ec06                	sd	ra,24(sp)
 310:	e822                	sd	s0,16(sp)
 312:	e426                	sd	s1,8(sp)
 314:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 316:	00001497          	auipc	s1,0x1
 31a:	cfa48493          	addi	s1,s1,-774 # 1010 <current_thread>
 31e:	609c                	ld	a5,0(s1)
 320:	6b9c                	ld	a5,16(a5)
    func(arg);
 322:	6398                	ld	a4,0(a5)
 324:	6788                	ld	a0,8(a5)
 326:	9702                	jalr	a4
    current_thread->state = EXITED;
 328:	609c                	ld	a5,0(s1)
 32a:	4719                	li	a4,6
 32c:	dfb8                	sw	a4,120(a5)
    tsched();
 32e:	00000097          	auipc	ra,0x0
 332:	f5c080e7          	jalr	-164(ra) # 28a <tsched>
}
 336:	60e2                	ld	ra,24(sp)
 338:	6442                	ld	s0,16(sp)
 33a:	64a2                	ld	s1,8(sp)
 33c:	6105                	addi	sp,sp,32
 33e:	8082                	ret

0000000000000340 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 340:	7179                	addi	sp,sp,-48
 342:	f406                	sd	ra,40(sp)
 344:	f022                	sd	s0,32(sp)
 346:	ec26                	sd	s1,24(sp)
 348:	e84a                	sd	s2,16(sp)
 34a:	e44e                	sd	s3,8(sp)
 34c:	1800                	addi	s0,sp,48
 34e:	84aa                	mv	s1,a0
 350:	8932                	mv	s2,a2
 352:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 354:	09800513          	li	a0,152
 358:	00001097          	auipc	ra,0x1
 35c:	876080e7          	jalr	-1930(ra) # bce <malloc>
 360:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 362:	478d                	li	a5,3
 364:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 366:	609c                	ld	a5,0(s1)
 368:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 36c:	609c                	ld	a5,0(s1)
 36e:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 372:	6098                	ld	a4,0(s1)
 374:	00001797          	auipc	a5,0x1
 378:	c8c78793          	addi	a5,a5,-884 # 1000 <next_tid>
 37c:	4394                	lw	a3,0(a5)
 37e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 382:	4398                	lw	a4,0(a5)
 384:	2705                	addiw	a4,a4,1
 386:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 388:	6505                	lui	a0,0x1
 38a:	00001097          	auipc	ra,0x1
 38e:	844080e7          	jalr	-1980(ra) # bce <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 392:	6785                	lui	a5,0x1
 394:	00a78733          	add	a4,a5,a0
 398:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 39c:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x240>
 39e:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 3a0:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 3a4:	609c                	ld	a5,0(s1)
 3a6:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 3a8:	609c                	ld	a5,0(s1)
 3aa:	00000717          	auipc	a4,0x0
 3ae:	f6270713          	addi	a4,a4,-158 # 30c <thread_wrapper>
 3b2:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 3b4:	00001717          	auipc	a4,0x1
 3b8:	c6c70713          	addi	a4,a4,-916 # 1020 <threads>
 3bc:	4781                	li	a5,0
 3be:	4641                	li	a2,16
        if (threads[i] == NULL) {
 3c0:	6314                	ld	a3,0(a4)
 3c2:	c29d                	beqz	a3,3e8 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 3c4:	2785                	addiw	a5,a5,1
 3c6:	0721                	addi	a4,a4,8
 3c8:	fec79ce3          	bne	a5,a2,3c0 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 3cc:	6088                	ld	a0,0(s1)
 3ce:	00000097          	auipc	ra,0x0
 3d2:	77e080e7          	jalr	1918(ra) # b4c <free>
        *thread = NULL;
 3d6:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 3da:	70a2                	ld	ra,40(sp)
 3dc:	7402                	ld	s0,32(sp)
 3de:	64e2                	ld	s1,24(sp)
 3e0:	6942                	ld	s2,16(sp)
 3e2:	69a2                	ld	s3,8(sp)
 3e4:	6145                	addi	sp,sp,48
 3e6:	8082                	ret
            threads[i] = *thread;
 3e8:	6094                	ld	a3,0(s1)
 3ea:	078e                	slli	a5,a5,0x3
 3ec:	00001717          	auipc	a4,0x1
 3f0:	c3470713          	addi	a4,a4,-972 # 1020 <threads>
 3f4:	97ba                	add	a5,a5,a4
 3f6:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 3f8:	b7cd                	j	3da <tcreate+0x9a>

00000000000003fa <tyield>:
    return 0;
}


void tyield()
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e406                	sd	ra,8(sp)
 3fe:	e022                	sd	s0,0(sp)
 400:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 402:	00001797          	auipc	a5,0x1
 406:	c0e7b783          	ld	a5,-1010(a5) # 1010 <current_thread>
 40a:	470d                	li	a4,3
 40c:	dfb8                	sw	a4,120(a5)
    tsched();
 40e:	00000097          	auipc	ra,0x0
 412:	e7c080e7          	jalr	-388(ra) # 28a <tsched>
}
 416:	60a2                	ld	ra,8(sp)
 418:	6402                	ld	s0,0(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret

000000000000041e <tjoin>:
{
 41e:	1101                	addi	sp,sp,-32
 420:	ec06                	sd	ra,24(sp)
 422:	e822                	sd	s0,16(sp)
 424:	e426                	sd	s1,8(sp)
 426:	e04a                	sd	s2,0(sp)
 428:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 42a:	00001797          	auipc	a5,0x1
 42e:	bf678793          	addi	a5,a5,-1034 # 1020 <threads>
 432:	00001697          	auipc	a3,0x1
 436:	c6e68693          	addi	a3,a3,-914 # 10a0 <base>
 43a:	a021                	j	442 <tjoin+0x24>
 43c:	07a1                	addi	a5,a5,8
 43e:	02d78b63          	beq	a5,a3,474 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 442:	6384                	ld	s1,0(a5)
 444:	dce5                	beqz	s1,43c <tjoin+0x1e>
 446:	0004c703          	lbu	a4,0(s1)
 44a:	fea719e3          	bne	a4,a0,43c <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 44e:	5cb8                	lw	a4,120(s1)
 450:	4799                	li	a5,6
 452:	4919                	li	s2,6
 454:	02f70263          	beq	a4,a5,478 <tjoin+0x5a>
        tyield();
 458:	00000097          	auipc	ra,0x0
 45c:	fa2080e7          	jalr	-94(ra) # 3fa <tyield>
    while (target_thread->state != EXITED) {
 460:	5cbc                	lw	a5,120(s1)
 462:	ff279be3          	bne	a5,s2,458 <tjoin+0x3a>
    return 0;
 466:	4501                	li	a0,0
}
 468:	60e2                	ld	ra,24(sp)
 46a:	6442                	ld	s0,16(sp)
 46c:	64a2                	ld	s1,8(sp)
 46e:	6902                	ld	s2,0(sp)
 470:	6105                	addi	sp,sp,32
 472:	8082                	ret
        return -1;
 474:	557d                	li	a0,-1
 476:	bfcd                	j	468 <tjoin+0x4a>
    return 0;
 478:	4501                	li	a0,0
 47a:	b7fd                	j	468 <tjoin+0x4a>

000000000000047c <twhoami>:

uint8 twhoami()
{
 47c:	1141                	addi	sp,sp,-16
 47e:	e422                	sd	s0,8(sp)
 480:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 482:	00001797          	auipc	a5,0x1
 486:	b8e7b783          	ld	a5,-1138(a5) # 1010 <current_thread>
 48a:	0007c503          	lbu	a0,0(a5)
 48e:	6422                	ld	s0,8(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret

0000000000000494 <tswtch>:
 494:	00153023          	sd	ra,0(a0)
 498:	00253423          	sd	sp,8(a0)
 49c:	e900                	sd	s0,16(a0)
 49e:	ed04                	sd	s1,24(a0)
 4a0:	03253023          	sd	s2,32(a0)
 4a4:	03353423          	sd	s3,40(a0)
 4a8:	03453823          	sd	s4,48(a0)
 4ac:	03553c23          	sd	s5,56(a0)
 4b0:	05653023          	sd	s6,64(a0)
 4b4:	05753423          	sd	s7,72(a0)
 4b8:	05853823          	sd	s8,80(a0)
 4bc:	05953c23          	sd	s9,88(a0)
 4c0:	07a53023          	sd	s10,96(a0)
 4c4:	07b53423          	sd	s11,104(a0)
 4c8:	0005b083          	ld	ra,0(a1)
 4cc:	0085b103          	ld	sp,8(a1)
 4d0:	6980                	ld	s0,16(a1)
 4d2:	6d84                	ld	s1,24(a1)
 4d4:	0205b903          	ld	s2,32(a1)
 4d8:	0285b983          	ld	s3,40(a1)
 4dc:	0305ba03          	ld	s4,48(a1)
 4e0:	0385ba83          	ld	s5,56(a1)
 4e4:	0405bb03          	ld	s6,64(a1)
 4e8:	0485bb83          	ld	s7,72(a1)
 4ec:	0505bc03          	ld	s8,80(a1)
 4f0:	0585bc83          	ld	s9,88(a1)
 4f4:	0605bd03          	ld	s10,96(a1)
 4f8:	0685bd83          	ld	s11,104(a1)
 4fc:	8082                	ret

00000000000004fe <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4fe:	1101                	addi	sp,sp,-32
 500:	ec06                	sd	ra,24(sp)
 502:	e822                	sd	s0,16(sp)
 504:	e426                	sd	s1,8(sp)
 506:	e04a                	sd	s2,0(sp)
 508:	1000                	addi	s0,sp,32
 50a:	84aa                	mv	s1,a0
 50c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 50e:	00000097          	auipc	ra,0x0
 512:	d1e080e7          	jalr	-738(ra) # 22c <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 516:	85ca                	mv	a1,s2
 518:	8526                	mv	a0,s1
 51a:	00000097          	auipc	ra,0x0
 51e:	ae6080e7          	jalr	-1306(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 522:	00000097          	auipc	ra,0x0
 526:	274080e7          	jalr	628(ra) # 796 <exit>

000000000000052a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 52a:	1141                	addi	sp,sp,-16
 52c:	e422                	sd	s0,8(sp)
 52e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 530:	87aa                	mv	a5,a0
 532:	0585                	addi	a1,a1,1
 534:	0785                	addi	a5,a5,1
 536:	fff5c703          	lbu	a4,-1(a1)
 53a:	fee78fa3          	sb	a4,-1(a5)
 53e:	fb75                	bnez	a4,532 <strcpy+0x8>
        ;
    return os;
}
 540:	6422                	ld	s0,8(sp)
 542:	0141                	addi	sp,sp,16
 544:	8082                	ret

0000000000000546 <strcmp>:

int strcmp(const char *p, const char *q)
{
 546:	1141                	addi	sp,sp,-16
 548:	e422                	sd	s0,8(sp)
 54a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 54c:	00054783          	lbu	a5,0(a0)
 550:	cb91                	beqz	a5,564 <strcmp+0x1e>
 552:	0005c703          	lbu	a4,0(a1)
 556:	00f71763          	bne	a4,a5,564 <strcmp+0x1e>
        p++, q++;
 55a:	0505                	addi	a0,a0,1
 55c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 55e:	00054783          	lbu	a5,0(a0)
 562:	fbe5                	bnez	a5,552 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 564:	0005c503          	lbu	a0,0(a1)
}
 568:	40a7853b          	subw	a0,a5,a0
 56c:	6422                	ld	s0,8(sp)
 56e:	0141                	addi	sp,sp,16
 570:	8082                	ret

0000000000000572 <strlen>:

uint strlen(const char *s)
{
 572:	1141                	addi	sp,sp,-16
 574:	e422                	sd	s0,8(sp)
 576:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 578:	00054783          	lbu	a5,0(a0)
 57c:	cf91                	beqz	a5,598 <strlen+0x26>
 57e:	0505                	addi	a0,a0,1
 580:	87aa                	mv	a5,a0
 582:	86be                	mv	a3,a5
 584:	0785                	addi	a5,a5,1
 586:	fff7c703          	lbu	a4,-1(a5)
 58a:	ff65                	bnez	a4,582 <strlen+0x10>
 58c:	40a6853b          	subw	a0,a3,a0
 590:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret
    for (n = 0; s[n]; n++)
 598:	4501                	li	a0,0
 59a:	bfe5                	j	592 <strlen+0x20>

000000000000059c <memset>:

void *
memset(void *dst, int c, uint n)
{
 59c:	1141                	addi	sp,sp,-16
 59e:	e422                	sd	s0,8(sp)
 5a0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5a2:	ca19                	beqz	a2,5b8 <memset+0x1c>
 5a4:	87aa                	mv	a5,a0
 5a6:	1602                	slli	a2,a2,0x20
 5a8:	9201                	srli	a2,a2,0x20
 5aa:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5ae:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5b2:	0785                	addi	a5,a5,1
 5b4:	fee79de3          	bne	a5,a4,5ae <memset+0x12>
    }
    return dst;
}
 5b8:	6422                	ld	s0,8(sp)
 5ba:	0141                	addi	sp,sp,16
 5bc:	8082                	ret

00000000000005be <strchr>:

char *
strchr(const char *s, char c)
{
 5be:	1141                	addi	sp,sp,-16
 5c0:	e422                	sd	s0,8(sp)
 5c2:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5c4:	00054783          	lbu	a5,0(a0)
 5c8:	cb99                	beqz	a5,5de <strchr+0x20>
        if (*s == c)
 5ca:	00f58763          	beq	a1,a5,5d8 <strchr+0x1a>
    for (; *s; s++)
 5ce:	0505                	addi	a0,a0,1
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	fbfd                	bnez	a5,5ca <strchr+0xc>
            return (char *)s;
    return 0;
 5d6:	4501                	li	a0,0
}
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret
    return 0;
 5de:	4501                	li	a0,0
 5e0:	bfe5                	j	5d8 <strchr+0x1a>

00000000000005e2 <gets>:

char *
gets(char *buf, int max)
{
 5e2:	711d                	addi	sp,sp,-96
 5e4:	ec86                	sd	ra,88(sp)
 5e6:	e8a2                	sd	s0,80(sp)
 5e8:	e4a6                	sd	s1,72(sp)
 5ea:	e0ca                	sd	s2,64(sp)
 5ec:	fc4e                	sd	s3,56(sp)
 5ee:	f852                	sd	s4,48(sp)
 5f0:	f456                	sd	s5,40(sp)
 5f2:	f05a                	sd	s6,32(sp)
 5f4:	ec5e                	sd	s7,24(sp)
 5f6:	1080                	addi	s0,sp,96
 5f8:	8baa                	mv	s7,a0
 5fa:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5fc:	892a                	mv	s2,a0
 5fe:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 600:	4aa9                	li	s5,10
 602:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 604:	89a6                	mv	s3,s1
 606:	2485                	addiw	s1,s1,1
 608:	0344d863          	bge	s1,s4,638 <gets+0x56>
        cc = read(0, &c, 1);
 60c:	4605                	li	a2,1
 60e:	faf40593          	addi	a1,s0,-81
 612:	4501                	li	a0,0
 614:	00000097          	auipc	ra,0x0
 618:	19a080e7          	jalr	410(ra) # 7ae <read>
        if (cc < 1)
 61c:	00a05e63          	blez	a0,638 <gets+0x56>
        buf[i++] = c;
 620:	faf44783          	lbu	a5,-81(s0)
 624:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 628:	01578763          	beq	a5,s5,636 <gets+0x54>
 62c:	0905                	addi	s2,s2,1
 62e:	fd679be3          	bne	a5,s6,604 <gets+0x22>
    for (i = 0; i + 1 < max;)
 632:	89a6                	mv	s3,s1
 634:	a011                	j	638 <gets+0x56>
 636:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 638:	99de                	add	s3,s3,s7
 63a:	00098023          	sb	zero,0(s3)
    return buf;
}
 63e:	855e                	mv	a0,s7
 640:	60e6                	ld	ra,88(sp)
 642:	6446                	ld	s0,80(sp)
 644:	64a6                	ld	s1,72(sp)
 646:	6906                	ld	s2,64(sp)
 648:	79e2                	ld	s3,56(sp)
 64a:	7a42                	ld	s4,48(sp)
 64c:	7aa2                	ld	s5,40(sp)
 64e:	7b02                	ld	s6,32(sp)
 650:	6be2                	ld	s7,24(sp)
 652:	6125                	addi	sp,sp,96
 654:	8082                	ret

0000000000000656 <stat>:

int stat(const char *n, struct stat *st)
{
 656:	1101                	addi	sp,sp,-32
 658:	ec06                	sd	ra,24(sp)
 65a:	e822                	sd	s0,16(sp)
 65c:	e426                	sd	s1,8(sp)
 65e:	e04a                	sd	s2,0(sp)
 660:	1000                	addi	s0,sp,32
 662:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 664:	4581                	li	a1,0
 666:	00000097          	auipc	ra,0x0
 66a:	170080e7          	jalr	368(ra) # 7d6 <open>
    if (fd < 0)
 66e:	02054563          	bltz	a0,698 <stat+0x42>
 672:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 674:	85ca                	mv	a1,s2
 676:	00000097          	auipc	ra,0x0
 67a:	178080e7          	jalr	376(ra) # 7ee <fstat>
 67e:	892a                	mv	s2,a0
    close(fd);
 680:	8526                	mv	a0,s1
 682:	00000097          	auipc	ra,0x0
 686:	13c080e7          	jalr	316(ra) # 7be <close>
    return r;
}
 68a:	854a                	mv	a0,s2
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	64a2                	ld	s1,8(sp)
 692:	6902                	ld	s2,0(sp)
 694:	6105                	addi	sp,sp,32
 696:	8082                	ret
        return -1;
 698:	597d                	li	s2,-1
 69a:	bfc5                	j	68a <stat+0x34>

000000000000069c <atoi>:

int atoi(const char *s)
{
 69c:	1141                	addi	sp,sp,-16
 69e:	e422                	sd	s0,8(sp)
 6a0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6a2:	00054683          	lbu	a3,0(a0)
 6a6:	fd06879b          	addiw	a5,a3,-48
 6aa:	0ff7f793          	zext.b	a5,a5
 6ae:	4625                	li	a2,9
 6b0:	02f66863          	bltu	a2,a5,6e0 <atoi+0x44>
 6b4:	872a                	mv	a4,a0
    n = 0;
 6b6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6b8:	0705                	addi	a4,a4,1
 6ba:	0025179b          	slliw	a5,a0,0x2
 6be:	9fa9                	addw	a5,a5,a0
 6c0:	0017979b          	slliw	a5,a5,0x1
 6c4:	9fb5                	addw	a5,a5,a3
 6c6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6ca:	00074683          	lbu	a3,0(a4)
 6ce:	fd06879b          	addiw	a5,a3,-48
 6d2:	0ff7f793          	zext.b	a5,a5
 6d6:	fef671e3          	bgeu	a2,a5,6b8 <atoi+0x1c>
    return n;
}
 6da:	6422                	ld	s0,8(sp)
 6dc:	0141                	addi	sp,sp,16
 6de:	8082                	ret
    n = 0;
 6e0:	4501                	li	a0,0
 6e2:	bfe5                	j	6da <atoi+0x3e>

00000000000006e4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6e4:	1141                	addi	sp,sp,-16
 6e6:	e422                	sd	s0,8(sp)
 6e8:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6ea:	02b57463          	bgeu	a0,a1,712 <memmove+0x2e>
    {
        while (n-- > 0)
 6ee:	00c05f63          	blez	a2,70c <memmove+0x28>
 6f2:	1602                	slli	a2,a2,0x20
 6f4:	9201                	srli	a2,a2,0x20
 6f6:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6fa:	872a                	mv	a4,a0
            *dst++ = *src++;
 6fc:	0585                	addi	a1,a1,1
 6fe:	0705                	addi	a4,a4,1
 700:	fff5c683          	lbu	a3,-1(a1)
 704:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 708:	fee79ae3          	bne	a5,a4,6fc <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 70c:	6422                	ld	s0,8(sp)
 70e:	0141                	addi	sp,sp,16
 710:	8082                	ret
        dst += n;
 712:	00c50733          	add	a4,a0,a2
        src += n;
 716:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 718:	fec05ae3          	blez	a2,70c <memmove+0x28>
 71c:	fff6079b          	addiw	a5,a2,-1
 720:	1782                	slli	a5,a5,0x20
 722:	9381                	srli	a5,a5,0x20
 724:	fff7c793          	not	a5,a5
 728:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 72a:	15fd                	addi	a1,a1,-1
 72c:	177d                	addi	a4,a4,-1
 72e:	0005c683          	lbu	a3,0(a1)
 732:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 736:	fee79ae3          	bne	a5,a4,72a <memmove+0x46>
 73a:	bfc9                	j	70c <memmove+0x28>

000000000000073c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 73c:	1141                	addi	sp,sp,-16
 73e:	e422                	sd	s0,8(sp)
 740:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 742:	ca05                	beqz	a2,772 <memcmp+0x36>
 744:	fff6069b          	addiw	a3,a2,-1
 748:	1682                	slli	a3,a3,0x20
 74a:	9281                	srli	a3,a3,0x20
 74c:	0685                	addi	a3,a3,1
 74e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 750:	00054783          	lbu	a5,0(a0)
 754:	0005c703          	lbu	a4,0(a1)
 758:	00e79863          	bne	a5,a4,768 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 75c:	0505                	addi	a0,a0,1
        p2++;
 75e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 760:	fed518e3          	bne	a0,a3,750 <memcmp+0x14>
    }
    return 0;
 764:	4501                	li	a0,0
 766:	a019                	j	76c <memcmp+0x30>
            return *p1 - *p2;
 768:	40e7853b          	subw	a0,a5,a4
}
 76c:	6422                	ld	s0,8(sp)
 76e:	0141                	addi	sp,sp,16
 770:	8082                	ret
    return 0;
 772:	4501                	li	a0,0
 774:	bfe5                	j	76c <memcmp+0x30>

0000000000000776 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 776:	1141                	addi	sp,sp,-16
 778:	e406                	sd	ra,8(sp)
 77a:	e022                	sd	s0,0(sp)
 77c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 77e:	00000097          	auipc	ra,0x0
 782:	f66080e7          	jalr	-154(ra) # 6e4 <memmove>
}
 786:	60a2                	ld	ra,8(sp)
 788:	6402                	ld	s0,0(sp)
 78a:	0141                	addi	sp,sp,16
 78c:	8082                	ret

000000000000078e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 78e:	4885                	li	a7,1
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <exit>:
.global exit
exit:
 li a7, SYS_exit
 796:	4889                	li	a7,2
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <wait>:
.global wait
wait:
 li a7, SYS_wait
 79e:	488d                	li	a7,3
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7a6:	4891                	li	a7,4
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <read>:
.global read
read:
 li a7, SYS_read
 7ae:	4895                	li	a7,5
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <write>:
.global write
write:
 li a7, SYS_write
 7b6:	48c1                	li	a7,16
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <close>:
.global close
close:
 li a7, SYS_close
 7be:	48d5                	li	a7,21
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7c6:	4899                	li	a7,6
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <exec>:
.global exec
exec:
 li a7, SYS_exec
 7ce:	489d                	li	a7,7
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <open>:
.global open
open:
 li a7, SYS_open
 7d6:	48bd                	li	a7,15
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7de:	48c5                	li	a7,17
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7e6:	48c9                	li	a7,18
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7ee:	48a1                	li	a7,8
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <link>:
.global link
link:
 li a7, SYS_link
 7f6:	48cd                	li	a7,19
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7fe:	48d1                	li	a7,20
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 806:	48a5                	li	a7,9
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <dup>:
.global dup
dup:
 li a7, SYS_dup
 80e:	48a9                	li	a7,10
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 816:	48ad                	li	a7,11
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 81e:	48b1                	li	a7,12
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 826:	48b5                	li	a7,13
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 82e:	48b9                	li	a7,14
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <ps>:
.global ps
ps:
 li a7, SYS_ps
 836:	48d9                	li	a7,22
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 83e:	48dd                	li	a7,23
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 846:	48e1                	li	a7,24
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 84e:	1101                	addi	sp,sp,-32
 850:	ec06                	sd	ra,24(sp)
 852:	e822                	sd	s0,16(sp)
 854:	1000                	addi	s0,sp,32
 856:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 85a:	4605                	li	a2,1
 85c:	fef40593          	addi	a1,s0,-17
 860:	00000097          	auipc	ra,0x0
 864:	f56080e7          	jalr	-170(ra) # 7b6 <write>
}
 868:	60e2                	ld	ra,24(sp)
 86a:	6442                	ld	s0,16(sp)
 86c:	6105                	addi	sp,sp,32
 86e:	8082                	ret

0000000000000870 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 870:	7139                	addi	sp,sp,-64
 872:	fc06                	sd	ra,56(sp)
 874:	f822                	sd	s0,48(sp)
 876:	f426                	sd	s1,40(sp)
 878:	f04a                	sd	s2,32(sp)
 87a:	ec4e                	sd	s3,24(sp)
 87c:	0080                	addi	s0,sp,64
 87e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 880:	c299                	beqz	a3,886 <printint+0x16>
 882:	0805c963          	bltz	a1,914 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 886:	2581                	sext.w	a1,a1
  neg = 0;
 888:	4881                	li	a7,0
 88a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 88e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 890:	2601                	sext.w	a2,a2
 892:	00000517          	auipc	a0,0x0
 896:	51e50513          	addi	a0,a0,1310 # db0 <digits>
 89a:	883a                	mv	a6,a4
 89c:	2705                	addiw	a4,a4,1
 89e:	02c5f7bb          	remuw	a5,a1,a2
 8a2:	1782                	slli	a5,a5,0x20
 8a4:	9381                	srli	a5,a5,0x20
 8a6:	97aa                	add	a5,a5,a0
 8a8:	0007c783          	lbu	a5,0(a5)
 8ac:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8b0:	0005879b          	sext.w	a5,a1
 8b4:	02c5d5bb          	divuw	a1,a1,a2
 8b8:	0685                	addi	a3,a3,1
 8ba:	fec7f0e3          	bgeu	a5,a2,89a <printint+0x2a>
  if(neg)
 8be:	00088c63          	beqz	a7,8d6 <printint+0x66>
    buf[i++] = '-';
 8c2:	fd070793          	addi	a5,a4,-48
 8c6:	00878733          	add	a4,a5,s0
 8ca:	02d00793          	li	a5,45
 8ce:	fef70823          	sb	a5,-16(a4)
 8d2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8d6:	02e05863          	blez	a4,906 <printint+0x96>
 8da:	fc040793          	addi	a5,s0,-64
 8de:	00e78933          	add	s2,a5,a4
 8e2:	fff78993          	addi	s3,a5,-1
 8e6:	99ba                	add	s3,s3,a4
 8e8:	377d                	addiw	a4,a4,-1
 8ea:	1702                	slli	a4,a4,0x20
 8ec:	9301                	srli	a4,a4,0x20
 8ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8f2:	fff94583          	lbu	a1,-1(s2)
 8f6:	8526                	mv	a0,s1
 8f8:	00000097          	auipc	ra,0x0
 8fc:	f56080e7          	jalr	-170(ra) # 84e <putc>
  while(--i >= 0)
 900:	197d                	addi	s2,s2,-1
 902:	ff3918e3          	bne	s2,s3,8f2 <printint+0x82>
}
 906:	70e2                	ld	ra,56(sp)
 908:	7442                	ld	s0,48(sp)
 90a:	74a2                	ld	s1,40(sp)
 90c:	7902                	ld	s2,32(sp)
 90e:	69e2                	ld	s3,24(sp)
 910:	6121                	addi	sp,sp,64
 912:	8082                	ret
    x = -xx;
 914:	40b005bb          	negw	a1,a1
    neg = 1;
 918:	4885                	li	a7,1
    x = -xx;
 91a:	bf85                	j	88a <printint+0x1a>

000000000000091c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 91c:	715d                	addi	sp,sp,-80
 91e:	e486                	sd	ra,72(sp)
 920:	e0a2                	sd	s0,64(sp)
 922:	fc26                	sd	s1,56(sp)
 924:	f84a                	sd	s2,48(sp)
 926:	f44e                	sd	s3,40(sp)
 928:	f052                	sd	s4,32(sp)
 92a:	ec56                	sd	s5,24(sp)
 92c:	e85a                	sd	s6,16(sp)
 92e:	e45e                	sd	s7,8(sp)
 930:	e062                	sd	s8,0(sp)
 932:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 934:	0005c903          	lbu	s2,0(a1)
 938:	18090c63          	beqz	s2,ad0 <vprintf+0x1b4>
 93c:	8aaa                	mv	s5,a0
 93e:	8bb2                	mv	s7,a2
 940:	00158493          	addi	s1,a1,1
  state = 0;
 944:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 946:	02500a13          	li	s4,37
 94a:	4b55                	li	s6,21
 94c:	a839                	j	96a <vprintf+0x4e>
        putc(fd, c);
 94e:	85ca                	mv	a1,s2
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	efc080e7          	jalr	-260(ra) # 84e <putc>
 95a:	a019                	j	960 <vprintf+0x44>
    } else if(state == '%'){
 95c:	01498d63          	beq	s3,s4,976 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 960:	0485                	addi	s1,s1,1
 962:	fff4c903          	lbu	s2,-1(s1)
 966:	16090563          	beqz	s2,ad0 <vprintf+0x1b4>
    if(state == 0){
 96a:	fe0999e3          	bnez	s3,95c <vprintf+0x40>
      if(c == '%'){
 96e:	ff4910e3          	bne	s2,s4,94e <vprintf+0x32>
        state = '%';
 972:	89d2                	mv	s3,s4
 974:	b7f5                	j	960 <vprintf+0x44>
      if(c == 'd'){
 976:	13490263          	beq	s2,s4,a9a <vprintf+0x17e>
 97a:	f9d9079b          	addiw	a5,s2,-99
 97e:	0ff7f793          	zext.b	a5,a5
 982:	12fb6563          	bltu	s6,a5,aac <vprintf+0x190>
 986:	f9d9079b          	addiw	a5,s2,-99
 98a:	0ff7f713          	zext.b	a4,a5
 98e:	10eb6f63          	bltu	s6,a4,aac <vprintf+0x190>
 992:	00271793          	slli	a5,a4,0x2
 996:	00000717          	auipc	a4,0x0
 99a:	3c270713          	addi	a4,a4,962 # d58 <malloc+0x18a>
 99e:	97ba                	add	a5,a5,a4
 9a0:	439c                	lw	a5,0(a5)
 9a2:	97ba                	add	a5,a5,a4
 9a4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9a6:	008b8913          	addi	s2,s7,8
 9aa:	4685                	li	a3,1
 9ac:	4629                	li	a2,10
 9ae:	000ba583          	lw	a1,0(s7)
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	ebc080e7          	jalr	-324(ra) # 870 <printint>
 9bc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	b745                	j	960 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9c2:	008b8913          	addi	s2,s7,8
 9c6:	4681                	li	a3,0
 9c8:	4629                	li	a2,10
 9ca:	000ba583          	lw	a1,0(s7)
 9ce:	8556                	mv	a0,s5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	ea0080e7          	jalr	-352(ra) # 870 <printint>
 9d8:	8bca                	mv	s7,s2
      state = 0;
 9da:	4981                	li	s3,0
 9dc:	b751                	j	960 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9de:	008b8913          	addi	s2,s7,8
 9e2:	4681                	li	a3,0
 9e4:	4641                	li	a2,16
 9e6:	000ba583          	lw	a1,0(s7)
 9ea:	8556                	mv	a0,s5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	e84080e7          	jalr	-380(ra) # 870 <printint>
 9f4:	8bca                	mv	s7,s2
      state = 0;
 9f6:	4981                	li	s3,0
 9f8:	b7a5                	j	960 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9fa:	008b8c13          	addi	s8,s7,8
 9fe:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a02:	03000593          	li	a1,48
 a06:	8556                	mv	a0,s5
 a08:	00000097          	auipc	ra,0x0
 a0c:	e46080e7          	jalr	-442(ra) # 84e <putc>
  putc(fd, 'x');
 a10:	07800593          	li	a1,120
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	e38080e7          	jalr	-456(ra) # 84e <putc>
 a1e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a20:	00000b97          	auipc	s7,0x0
 a24:	390b8b93          	addi	s7,s7,912 # db0 <digits>
 a28:	03c9d793          	srli	a5,s3,0x3c
 a2c:	97de                	add	a5,a5,s7
 a2e:	0007c583          	lbu	a1,0(a5)
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	e1a080e7          	jalr	-486(ra) # 84e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a3c:	0992                	slli	s3,s3,0x4
 a3e:	397d                	addiw	s2,s2,-1
 a40:	fe0914e3          	bnez	s2,a28 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a44:	8be2                	mv	s7,s8
      state = 0;
 a46:	4981                	li	s3,0
 a48:	bf21                	j	960 <vprintf+0x44>
        s = va_arg(ap, char*);
 a4a:	008b8993          	addi	s3,s7,8
 a4e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a52:	02090163          	beqz	s2,a74 <vprintf+0x158>
        while(*s != 0){
 a56:	00094583          	lbu	a1,0(s2)
 a5a:	c9a5                	beqz	a1,aca <vprintf+0x1ae>
          putc(fd, *s);
 a5c:	8556                	mv	a0,s5
 a5e:	00000097          	auipc	ra,0x0
 a62:	df0080e7          	jalr	-528(ra) # 84e <putc>
          s++;
 a66:	0905                	addi	s2,s2,1
        while(*s != 0){
 a68:	00094583          	lbu	a1,0(s2)
 a6c:	f9e5                	bnez	a1,a5c <vprintf+0x140>
        s = va_arg(ap, char*);
 a6e:	8bce                	mv	s7,s3
      state = 0;
 a70:	4981                	li	s3,0
 a72:	b5fd                	j	960 <vprintf+0x44>
          s = "(null)";
 a74:	00000917          	auipc	s2,0x0
 a78:	2dc90913          	addi	s2,s2,732 # d50 <malloc+0x182>
        while(*s != 0){
 a7c:	02800593          	li	a1,40
 a80:	bff1                	j	a5c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a82:	008b8913          	addi	s2,s7,8
 a86:	000bc583          	lbu	a1,0(s7)
 a8a:	8556                	mv	a0,s5
 a8c:	00000097          	auipc	ra,0x0
 a90:	dc2080e7          	jalr	-574(ra) # 84e <putc>
 a94:	8bca                	mv	s7,s2
      state = 0;
 a96:	4981                	li	s3,0
 a98:	b5e1                	j	960 <vprintf+0x44>
        putc(fd, c);
 a9a:	02500593          	li	a1,37
 a9e:	8556                	mv	a0,s5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	dae080e7          	jalr	-594(ra) # 84e <putc>
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	bd5d                	j	960 <vprintf+0x44>
        putc(fd, '%');
 aac:	02500593          	li	a1,37
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	d9c080e7          	jalr	-612(ra) # 84e <putc>
        putc(fd, c);
 aba:	85ca                	mv	a1,s2
 abc:	8556                	mv	a0,s5
 abe:	00000097          	auipc	ra,0x0
 ac2:	d90080e7          	jalr	-624(ra) # 84e <putc>
      state = 0;
 ac6:	4981                	li	s3,0
 ac8:	bd61                	j	960 <vprintf+0x44>
        s = va_arg(ap, char*);
 aca:	8bce                	mv	s7,s3
      state = 0;
 acc:	4981                	li	s3,0
 ace:	bd49                	j	960 <vprintf+0x44>
    }
  }
}
 ad0:	60a6                	ld	ra,72(sp)
 ad2:	6406                	ld	s0,64(sp)
 ad4:	74e2                	ld	s1,56(sp)
 ad6:	7942                	ld	s2,48(sp)
 ad8:	79a2                	ld	s3,40(sp)
 ada:	7a02                	ld	s4,32(sp)
 adc:	6ae2                	ld	s5,24(sp)
 ade:	6b42                	ld	s6,16(sp)
 ae0:	6ba2                	ld	s7,8(sp)
 ae2:	6c02                	ld	s8,0(sp)
 ae4:	6161                	addi	sp,sp,80
 ae6:	8082                	ret

0000000000000ae8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ae8:	715d                	addi	sp,sp,-80
 aea:	ec06                	sd	ra,24(sp)
 aec:	e822                	sd	s0,16(sp)
 aee:	1000                	addi	s0,sp,32
 af0:	e010                	sd	a2,0(s0)
 af2:	e414                	sd	a3,8(s0)
 af4:	e818                	sd	a4,16(s0)
 af6:	ec1c                	sd	a5,24(s0)
 af8:	03043023          	sd	a6,32(s0)
 afc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b00:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b04:	8622                	mv	a2,s0
 b06:	00000097          	auipc	ra,0x0
 b0a:	e16080e7          	jalr	-490(ra) # 91c <vprintf>
}
 b0e:	60e2                	ld	ra,24(sp)
 b10:	6442                	ld	s0,16(sp)
 b12:	6161                	addi	sp,sp,80
 b14:	8082                	ret

0000000000000b16 <printf>:

void
printf(const char *fmt, ...)
{
 b16:	711d                	addi	sp,sp,-96
 b18:	ec06                	sd	ra,24(sp)
 b1a:	e822                	sd	s0,16(sp)
 b1c:	1000                	addi	s0,sp,32
 b1e:	e40c                	sd	a1,8(s0)
 b20:	e810                	sd	a2,16(s0)
 b22:	ec14                	sd	a3,24(s0)
 b24:	f018                	sd	a4,32(s0)
 b26:	f41c                	sd	a5,40(s0)
 b28:	03043823          	sd	a6,48(s0)
 b2c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b30:	00840613          	addi	a2,s0,8
 b34:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b38:	85aa                	mv	a1,a0
 b3a:	4505                	li	a0,1
 b3c:	00000097          	auipc	ra,0x0
 b40:	de0080e7          	jalr	-544(ra) # 91c <vprintf>
}
 b44:	60e2                	ld	ra,24(sp)
 b46:	6442                	ld	s0,16(sp)
 b48:	6125                	addi	sp,sp,96
 b4a:	8082                	ret

0000000000000b4c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b4c:	1141                	addi	sp,sp,-16
 b4e:	e422                	sd	s0,8(sp)
 b50:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b52:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b56:	00000797          	auipc	a5,0x0
 b5a:	4c27b783          	ld	a5,1218(a5) # 1018 <freep>
 b5e:	a02d                	j	b88 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b60:	4618                	lw	a4,8(a2)
 b62:	9f2d                	addw	a4,a4,a1
 b64:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b68:	6398                	ld	a4,0(a5)
 b6a:	6310                	ld	a2,0(a4)
 b6c:	a83d                	j	baa <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b6e:	ff852703          	lw	a4,-8(a0)
 b72:	9f31                	addw	a4,a4,a2
 b74:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b76:	ff053683          	ld	a3,-16(a0)
 b7a:	a091                	j	bbe <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b7c:	6398                	ld	a4,0(a5)
 b7e:	00e7e463          	bltu	a5,a4,b86 <free+0x3a>
 b82:	00e6ea63          	bltu	a3,a4,b96 <free+0x4a>
{
 b86:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b88:	fed7fae3          	bgeu	a5,a3,b7c <free+0x30>
 b8c:	6398                	ld	a4,0(a5)
 b8e:	00e6e463          	bltu	a3,a4,b96 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b92:	fee7eae3          	bltu	a5,a4,b86 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b96:	ff852583          	lw	a1,-8(a0)
 b9a:	6390                	ld	a2,0(a5)
 b9c:	02059813          	slli	a6,a1,0x20
 ba0:	01c85713          	srli	a4,a6,0x1c
 ba4:	9736                	add	a4,a4,a3
 ba6:	fae60de3          	beq	a2,a4,b60 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 baa:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bae:	4790                	lw	a2,8(a5)
 bb0:	02061593          	slli	a1,a2,0x20
 bb4:	01c5d713          	srli	a4,a1,0x1c
 bb8:	973e                	add	a4,a4,a5
 bba:	fae68ae3          	beq	a3,a4,b6e <free+0x22>
        p->s.ptr = bp->s.ptr;
 bbe:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bc0:	00000717          	auipc	a4,0x0
 bc4:	44f73c23          	sd	a5,1112(a4) # 1018 <freep>
}
 bc8:	6422                	ld	s0,8(sp)
 bca:	0141                	addi	sp,sp,16
 bcc:	8082                	ret

0000000000000bce <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bce:	7139                	addi	sp,sp,-64
 bd0:	fc06                	sd	ra,56(sp)
 bd2:	f822                	sd	s0,48(sp)
 bd4:	f426                	sd	s1,40(sp)
 bd6:	f04a                	sd	s2,32(sp)
 bd8:	ec4e                	sd	s3,24(sp)
 bda:	e852                	sd	s4,16(sp)
 bdc:	e456                	sd	s5,8(sp)
 bde:	e05a                	sd	s6,0(sp)
 be0:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 be2:	02051493          	slli	s1,a0,0x20
 be6:	9081                	srli	s1,s1,0x20
 be8:	04bd                	addi	s1,s1,15
 bea:	8091                	srli	s1,s1,0x4
 bec:	0014899b          	addiw	s3,s1,1
 bf0:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bf2:	00000517          	auipc	a0,0x0
 bf6:	42653503          	ld	a0,1062(a0) # 1018 <freep>
 bfa:	c515                	beqz	a0,c26 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bfc:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bfe:	4798                	lw	a4,8(a5)
 c00:	02977f63          	bgeu	a4,s1,c3e <malloc+0x70>
    if (nu < 4096)
 c04:	8a4e                	mv	s4,s3
 c06:	0009871b          	sext.w	a4,s3
 c0a:	6685                	lui	a3,0x1
 c0c:	00d77363          	bgeu	a4,a3,c12 <malloc+0x44>
 c10:	6a05                	lui	s4,0x1
 c12:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c16:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c1a:	00000917          	auipc	s2,0x0
 c1e:	3fe90913          	addi	s2,s2,1022 # 1018 <freep>
    if (p == (char *)-1)
 c22:	5afd                	li	s5,-1
 c24:	a895                	j	c98 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c26:	00000797          	auipc	a5,0x0
 c2a:	47a78793          	addi	a5,a5,1146 # 10a0 <base>
 c2e:	00000717          	auipc	a4,0x0
 c32:	3ef73523          	sd	a5,1002(a4) # 1018 <freep>
 c36:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c38:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c3c:	b7e1                	j	c04 <malloc+0x36>
            if (p->s.size == nunits)
 c3e:	02e48c63          	beq	s1,a4,c76 <malloc+0xa8>
                p->s.size -= nunits;
 c42:	4137073b          	subw	a4,a4,s3
 c46:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c48:	02071693          	slli	a3,a4,0x20
 c4c:	01c6d713          	srli	a4,a3,0x1c
 c50:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c52:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c56:	00000717          	auipc	a4,0x0
 c5a:	3ca73123          	sd	a0,962(a4) # 1018 <freep>
            return (void *)(p + 1);
 c5e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c62:	70e2                	ld	ra,56(sp)
 c64:	7442                	ld	s0,48(sp)
 c66:	74a2                	ld	s1,40(sp)
 c68:	7902                	ld	s2,32(sp)
 c6a:	69e2                	ld	s3,24(sp)
 c6c:	6a42                	ld	s4,16(sp)
 c6e:	6aa2                	ld	s5,8(sp)
 c70:	6b02                	ld	s6,0(sp)
 c72:	6121                	addi	sp,sp,64
 c74:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c76:	6398                	ld	a4,0(a5)
 c78:	e118                	sd	a4,0(a0)
 c7a:	bff1                	j	c56 <malloc+0x88>
    hp->s.size = nu;
 c7c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c80:	0541                	addi	a0,a0,16
 c82:	00000097          	auipc	ra,0x0
 c86:	eca080e7          	jalr	-310(ra) # b4c <free>
    return freep;
 c8a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c8e:	d971                	beqz	a0,c62 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c90:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c92:	4798                	lw	a4,8(a5)
 c94:	fa9775e3          	bgeu	a4,s1,c3e <malloc+0x70>
        if (p == freep)
 c98:	00093703          	ld	a4,0(s2)
 c9c:	853e                	mv	a0,a5
 c9e:	fef719e3          	bne	a4,a5,c90 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ca2:	8552                	mv	a0,s4
 ca4:	00000097          	auipc	ra,0x0
 ca8:	b7a080e7          	jalr	-1158(ra) # 81e <sbrk>
    if (p == (char *)-1)
 cac:	fd5518e3          	bne	a0,s5,c7c <malloc+0xae>
                return 0;
 cb0:	4501                	li	a0,0
 cb2:	bf45                	j	c62 <malloc+0x94>
