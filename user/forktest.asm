
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	578080e7          	jalr	1400(ra) # 584 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	7ac080e7          	jalr	1964(ra) # 7c8 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00001517          	auipc	a0,0x1
  3e:	c8e50513          	addi	a0,a0,-882 # cc8 <malloc+0xe8>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	750080e7          	jalr	1872(ra) # 7a0 <fork>
    if(pid < 0)
  58:	02054763          	bltz	a0,86 <forktest+0x58>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00001517          	auipc	a0,0x1
  68:	c7450513          	addi	a0,a0,-908 # cd8 <malloc+0xf8>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	732080e7          	jalr	1842(ra) # 7a8 <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	72a080e7          	jalr	1834(ra) # 7a8 <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	71c080e7          	jalr	1820(ra) # 7b0 <wait>
  9c:	02054a63          	bltz	a0,d0 <forktest+0xa2>
  for(; n > 0; n--){
  a0:	34fd                	addiw	s1,s1,-1
  a2:	f8e5                	bnez	s1,92 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	70a080e7          	jalr	1802(ra) # 7b0 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	c7450513          	addi	a0,a0,-908 # d28 <malloc+0x148>
  bc:	00000097          	auipc	ra,0x0
  c0:	f44080e7          	jalr	-188(ra) # 0 <print>
}
  c4:	60e2                	ld	ra,24(sp)
  c6:	6442                	ld	s0,16(sp)
  c8:	64a2                	ld	s1,8(sp)
  ca:	6902                	ld	s2,0(sp)
  cc:	6105                	addi	sp,sp,32
  ce:	8082                	ret
      print("wait stopped early\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	c2850513          	addi	a0,a0,-984 # cf8 <malloc+0x118>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	6c6080e7          	jalr	1734(ra) # 7a8 <exit>
    print("wait got too many\n");
  ea:	00001517          	auipc	a0,0x1
  ee:	c2650513          	addi	a0,a0,-986 # d10 <malloc+0x130>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	6ac080e7          	jalr	1708(ra) # 7a8 <exit>

0000000000000104 <main>:

int
main(void)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  forktest();
 10c:	00000097          	auipc	ra,0x0
 110:	f22080e7          	jalr	-222(ra) # 2e <forktest>
  exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	692080e7          	jalr	1682(ra) # 7a8 <exit>

000000000000011e <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
    lk->name = name;
 124:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 126:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 12a:	57fd                	li	a5,-1
 12c:	00f50823          	sb	a5,16(a0)
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 136:	00054783          	lbu	a5,0(a0)
 13a:	e399                	bnez	a5,140 <holding+0xa>
 13c:	4501                	li	a0,0
}
 13e:	8082                	ret
{
 140:	1101                	addi	sp,sp,-32
 142:	ec06                	sd	ra,24(sp)
 144:	e822                	sd	s0,16(sp)
 146:	e426                	sd	s1,8(sp)
 148:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 14a:	01054483          	lbu	s1,16(a0)
 14e:	00000097          	auipc	ra,0x0
 152:	340080e7          	jalr	832(ra) # 48e <twhoami>
 156:	2501                	sext.w	a0,a0
 158:	40a48533          	sub	a0,s1,a0
 15c:	00153513          	seqz	a0,a0
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret

000000000000016a <acquire>:

void acquire(struct lock *lk)
{
 16a:	7179                	addi	sp,sp,-48
 16c:	f406                	sd	ra,40(sp)
 16e:	f022                	sd	s0,32(sp)
 170:	ec26                	sd	s1,24(sp)
 172:	e84a                	sd	s2,16(sp)
 174:	e44e                	sd	s3,8(sp)
 176:	e052                	sd	s4,0(sp)
 178:	1800                	addi	s0,sp,48
 17a:	8a2a                	mv	s4,a0
    if (holding(lk))
 17c:	00000097          	auipc	ra,0x0
 180:	fba080e7          	jalr	-70(ra) # 136 <holding>
 184:	e919                	bnez	a0,19a <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 186:	ffca7493          	andi	s1,s4,-4
 18a:	003a7913          	andi	s2,s4,3
 18e:	0039191b          	slliw	s2,s2,0x3
 192:	4985                	li	s3,1
 194:	012999bb          	sllw	s3,s3,s2
 198:	a015                	j	1bc <acquire+0x52>
        printf("re-acquiring lock we already hold");
 19a:	00001517          	auipc	a0,0x1
 19e:	b9e50513          	addi	a0,a0,-1122 # d38 <malloc+0x158>
 1a2:	00001097          	auipc	ra,0x1
 1a6:	986080e7          	jalr	-1658(ra) # b28 <printf>
        exit(-1);
 1aa:	557d                	li	a0,-1
 1ac:	00000097          	auipc	ra,0x0
 1b0:	5fc080e7          	jalr	1532(ra) # 7a8 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b4:	00000097          	auipc	ra,0x0
 1b8:	258080e7          	jalr	600(ra) # 40c <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1bc:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1c0:	0127d7bb          	srlw	a5,a5,s2
 1c4:	0ff7f793          	zext.b	a5,a5
 1c8:	f7f5                	bnez	a5,1b4 <acquire+0x4a>
    }

    __sync_synchronize();
 1ca:	0ff0000f          	fence

    lk->tid = twhoami();
 1ce:	00000097          	auipc	ra,0x0
 1d2:	2c0080e7          	jalr	704(ra) # 48e <twhoami>
 1d6:	00aa0823          	sb	a0,16(s4)
}
 1da:	70a2                	ld	ra,40(sp)
 1dc:	7402                	ld	s0,32(sp)
 1de:	64e2                	ld	s1,24(sp)
 1e0:	6942                	ld	s2,16(sp)
 1e2:	69a2                	ld	s3,8(sp)
 1e4:	6a02                	ld	s4,0(sp)
 1e6:	6145                	addi	sp,sp,48
 1e8:	8082                	ret

00000000000001ea <release>:

void release(struct lock *lk)
{
 1ea:	1101                	addi	sp,sp,-32
 1ec:	ec06                	sd	ra,24(sp)
 1ee:	e822                	sd	s0,16(sp)
 1f0:	e426                	sd	s1,8(sp)
 1f2:	1000                	addi	s0,sp,32
 1f4:	84aa                	mv	s1,a0
    if (!holding(lk))
 1f6:	00000097          	auipc	ra,0x0
 1fa:	f40080e7          	jalr	-192(ra) # 136 <holding>
 1fe:	c11d                	beqz	a0,224 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 200:	57fd                	li	a5,-1
 202:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 206:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 20a:	0ff0000f          	fence
 20e:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 212:	00000097          	auipc	ra,0x0
 216:	1fa080e7          	jalr	506(ra) # 40c <tyield>
}
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	64a2                	ld	s1,8(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret
        printf("releasing lock we are not holding");
 224:	00001517          	auipc	a0,0x1
 228:	b3c50513          	addi	a0,a0,-1220 # d60 <malloc+0x180>
 22c:	00001097          	auipc	ra,0x1
 230:	8fc080e7          	jalr	-1796(ra) # b28 <printf>
        exit(-1);
 234:	557d                	li	a0,-1
 236:	00000097          	auipc	ra,0x0
 23a:	572080e7          	jalr	1394(ra) # 7a8 <exit>

000000000000023e <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 23e:	1141                	addi	sp,sp,-16
 240:	e406                	sd	ra,8(sp)
 242:	e022                	sd	s0,0(sp)
 244:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 246:	09800513          	li	a0,152
 24a:	00001097          	auipc	ra,0x1
 24e:	996080e7          	jalr	-1642(ra) # be0 <malloc>

    main_thread->tid = next_tid;
 252:	00001797          	auipc	a5,0x1
 256:	baa78793          	addi	a5,a5,-1110 # dfc <next_tid>
 25a:	4398                	lw	a4,0(a5)
 25c:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 260:	4398                	lw	a4,0(a5)
 262:	2705                	addiw	a4,a4,1
 264:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 266:	4791                	li	a5,4
 268:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 26a:	00001797          	auipc	a5,0x1
 26e:	b8a7bb23          	sd	a0,-1130(a5) # e00 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 272:	00001797          	auipc	a5,0x1
 276:	b9e78793          	addi	a5,a5,-1122 # e10 <threads>
 27a:	00001717          	auipc	a4,0x1
 27e:	c1670713          	addi	a4,a4,-1002 # e90 <base>
        threads[i] = NULL;
 282:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 286:	07a1                	addi	a5,a5,8
 288:	fee79de3          	bne	a5,a4,282 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 28c:	00001797          	auipc	a5,0x1
 290:	b8a7b223          	sd	a0,-1148(a5) # e10 <threads>
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 29c:	00001517          	auipc	a0,0x1
 2a0:	b6453503          	ld	a0,-1180(a0) # e00 <current_thread>
 2a4:	00001717          	auipc	a4,0x1
 2a8:	b6c70713          	addi	a4,a4,-1172 # e10 <threads>
    for (int i = 0; i < 16; i++) {
 2ac:	4781                	li	a5,0
 2ae:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 2b0:	6314                	ld	a3,0(a4)
 2b2:	00a68763          	beq	a3,a0,2c0 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 2b6:	2785                	addiw	a5,a5,1
 2b8:	0721                	addi	a4,a4,8
 2ba:	fec79be3          	bne	a5,a2,2b0 <tsched+0x14>
    int current_index = 0;
 2be:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 2c0:	0017869b          	addiw	a3,a5,1
 2c4:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2c8:	00001817          	auipc	a6,0x1
 2cc:	b4880813          	addi	a6,a6,-1208 # e10 <threads>
 2d0:	488d                	li	a7,3
 2d2:	a021                	j	2da <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 2d4:	2685                	addiw	a3,a3,1
 2d6:	04c68363          	beq	a3,a2,31c <tsched+0x80>
        int next_index = (current_index + i) % 16;
 2da:	41f6d71b          	sraiw	a4,a3,0x1f
 2de:	01c7571b          	srliw	a4,a4,0x1c
 2e2:	00d707bb          	addw	a5,a4,a3
 2e6:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2e8:	9f99                	subw	a5,a5,a4
 2ea:	078e                	slli	a5,a5,0x3
 2ec:	97c2                	add	a5,a5,a6
 2ee:	638c                	ld	a1,0(a5)
 2f0:	d1f5                	beqz	a1,2d4 <tsched+0x38>
 2f2:	5dbc                	lw	a5,120(a1)
 2f4:	ff1790e3          	bne	a5,a7,2d4 <tsched+0x38>
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e406                	sd	ra,8(sp)
 2fc:	e022                	sd	s0,0(sp)
 2fe:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 300:	00001797          	auipc	a5,0x1
 304:	b0b7b023          	sd	a1,-1280(a5) # e00 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 308:	05a1                	addi	a1,a1,8
 30a:	0521                	addi	a0,a0,8
 30c:	00000097          	auipc	ra,0x0
 310:	19a080e7          	jalr	410(ra) # 4a6 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
 31c:	8082                	ret

000000000000031e <thread_wrapper>:
{
 31e:	1101                	addi	sp,sp,-32
 320:	ec06                	sd	ra,24(sp)
 322:	e822                	sd	s0,16(sp)
 324:	e426                	sd	s1,8(sp)
 326:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 328:	00001497          	auipc	s1,0x1
 32c:	ad848493          	addi	s1,s1,-1320 # e00 <current_thread>
 330:	609c                	ld	a5,0(s1)
 332:	6b9c                	ld	a5,16(a5)
    func(arg);
 334:	6398                	ld	a4,0(a5)
 336:	6788                	ld	a0,8(a5)
 338:	9702                	jalr	a4
    current_thread->state = EXITED;
 33a:	609c                	ld	a5,0(s1)
 33c:	4719                	li	a4,6
 33e:	dfb8                	sw	a4,120(a5)
    tsched();
 340:	00000097          	auipc	ra,0x0
 344:	f5c080e7          	jalr	-164(ra) # 29c <tsched>
}
 348:	60e2                	ld	ra,24(sp)
 34a:	6442                	ld	s0,16(sp)
 34c:	64a2                	ld	s1,8(sp)
 34e:	6105                	addi	sp,sp,32
 350:	8082                	ret

0000000000000352 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 352:	7179                	addi	sp,sp,-48
 354:	f406                	sd	ra,40(sp)
 356:	f022                	sd	s0,32(sp)
 358:	ec26                	sd	s1,24(sp)
 35a:	e84a                	sd	s2,16(sp)
 35c:	e44e                	sd	s3,8(sp)
 35e:	1800                	addi	s0,sp,48
 360:	84aa                	mv	s1,a0
 362:	8932                	mv	s2,a2
 364:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 366:	09800513          	li	a0,152
 36a:	00001097          	auipc	ra,0x1
 36e:	876080e7          	jalr	-1930(ra) # be0 <malloc>
 372:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 374:	478d                	li	a5,3
 376:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 378:	609c                	ld	a5,0(s1)
 37a:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 37e:	609c                	ld	a5,0(s1)
 380:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 384:	6098                	ld	a4,0(s1)
 386:	00001797          	auipc	a5,0x1
 38a:	a7678793          	addi	a5,a5,-1418 # dfc <next_tid>
 38e:	4394                	lw	a3,0(a5)
 390:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 394:	4398                	lw	a4,0(a5)
 396:	2705                	addiw	a4,a4,1
 398:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 39a:	6505                	lui	a0,0x1
 39c:	00001097          	auipc	ra,0x1
 3a0:	844080e7          	jalr	-1980(ra) # be0 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 3a4:	6785                	lui	a5,0x1
 3a6:	00a78733          	add	a4,a5,a0
 3aa:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 3ae:	17c1                	addi	a5,a5,-16 # ff0 <__BSS_END__+0x150>
 3b0:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 3b2:	01253023          	sd	s2,0(a0) # 1000 <__BSS_END__+0x160>

    (*thread)->tcontext.sp = stack_top;
 3b6:	609c                	ld	a5,0(s1)
 3b8:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 3ba:	609c                	ld	a5,0(s1)
 3bc:	00000717          	auipc	a4,0x0
 3c0:	f6270713          	addi	a4,a4,-158 # 31e <thread_wrapper>
 3c4:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 3c6:	00001717          	auipc	a4,0x1
 3ca:	a4a70713          	addi	a4,a4,-1462 # e10 <threads>
 3ce:	4781                	li	a5,0
 3d0:	4641                	li	a2,16
        if (threads[i] == NULL) {
 3d2:	6314                	ld	a3,0(a4)
 3d4:	c29d                	beqz	a3,3fa <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 3d6:	2785                	addiw	a5,a5,1
 3d8:	0721                	addi	a4,a4,8
 3da:	fec79ce3          	bne	a5,a2,3d2 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 3de:	6088                	ld	a0,0(s1)
 3e0:	00000097          	auipc	ra,0x0
 3e4:	77e080e7          	jalr	1918(ra) # b5e <free>
        *thread = NULL;
 3e8:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 3ec:	70a2                	ld	ra,40(sp)
 3ee:	7402                	ld	s0,32(sp)
 3f0:	64e2                	ld	s1,24(sp)
 3f2:	6942                	ld	s2,16(sp)
 3f4:	69a2                	ld	s3,8(sp)
 3f6:	6145                	addi	sp,sp,48
 3f8:	8082                	ret
            threads[i] = *thread;
 3fa:	6094                	ld	a3,0(s1)
 3fc:	078e                	slli	a5,a5,0x3
 3fe:	00001717          	auipc	a4,0x1
 402:	a1270713          	addi	a4,a4,-1518 # e10 <threads>
 406:	97ba                	add	a5,a5,a4
 408:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 40a:	b7cd                	j	3ec <tcreate+0x9a>

000000000000040c <tyield>:
    return 0;
}


void tyield()
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e406                	sd	ra,8(sp)
 410:	e022                	sd	s0,0(sp)
 412:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 414:	00001797          	auipc	a5,0x1
 418:	9ec7b783          	ld	a5,-1556(a5) # e00 <current_thread>
 41c:	470d                	li	a4,3
 41e:	dfb8                	sw	a4,120(a5)
    tsched();
 420:	00000097          	auipc	ra,0x0
 424:	e7c080e7          	jalr	-388(ra) # 29c <tsched>
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret

0000000000000430 <tjoin>:
{
 430:	1101                	addi	sp,sp,-32
 432:	ec06                	sd	ra,24(sp)
 434:	e822                	sd	s0,16(sp)
 436:	e426                	sd	s1,8(sp)
 438:	e04a                	sd	s2,0(sp)
 43a:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 43c:	00001797          	auipc	a5,0x1
 440:	9d478793          	addi	a5,a5,-1580 # e10 <threads>
 444:	00001697          	auipc	a3,0x1
 448:	a4c68693          	addi	a3,a3,-1460 # e90 <base>
 44c:	a021                	j	454 <tjoin+0x24>
 44e:	07a1                	addi	a5,a5,8
 450:	02d78b63          	beq	a5,a3,486 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 454:	6384                	ld	s1,0(a5)
 456:	dce5                	beqz	s1,44e <tjoin+0x1e>
 458:	0004c703          	lbu	a4,0(s1)
 45c:	fea719e3          	bne	a4,a0,44e <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 460:	5cb8                	lw	a4,120(s1)
 462:	4799                	li	a5,6
 464:	4919                	li	s2,6
 466:	02f70263          	beq	a4,a5,48a <tjoin+0x5a>
        tyield();
 46a:	00000097          	auipc	ra,0x0
 46e:	fa2080e7          	jalr	-94(ra) # 40c <tyield>
    while (target_thread->state != EXITED) {
 472:	5cbc                	lw	a5,120(s1)
 474:	ff279be3          	bne	a5,s2,46a <tjoin+0x3a>
    return 0;
 478:	4501                	li	a0,0
}
 47a:	60e2                	ld	ra,24(sp)
 47c:	6442                	ld	s0,16(sp)
 47e:	64a2                	ld	s1,8(sp)
 480:	6902                	ld	s2,0(sp)
 482:	6105                	addi	sp,sp,32
 484:	8082                	ret
        return -1;
 486:	557d                	li	a0,-1
 488:	bfcd                	j	47a <tjoin+0x4a>
    return 0;
 48a:	4501                	li	a0,0
 48c:	b7fd                	j	47a <tjoin+0x4a>

000000000000048e <twhoami>:

uint8 twhoami()
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 494:	00001797          	auipc	a5,0x1
 498:	96c7b783          	ld	a5,-1684(a5) # e00 <current_thread>
 49c:	0007c503          	lbu	a0,0(a5)
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret

00000000000004a6 <tswtch>:
 4a6:	00153023          	sd	ra,0(a0)
 4aa:	00253423          	sd	sp,8(a0)
 4ae:	e900                	sd	s0,16(a0)
 4b0:	ed04                	sd	s1,24(a0)
 4b2:	03253023          	sd	s2,32(a0)
 4b6:	03353423          	sd	s3,40(a0)
 4ba:	03453823          	sd	s4,48(a0)
 4be:	03553c23          	sd	s5,56(a0)
 4c2:	05653023          	sd	s6,64(a0)
 4c6:	05753423          	sd	s7,72(a0)
 4ca:	05853823          	sd	s8,80(a0)
 4ce:	05953c23          	sd	s9,88(a0)
 4d2:	07a53023          	sd	s10,96(a0)
 4d6:	07b53423          	sd	s11,104(a0)
 4da:	0005b083          	ld	ra,0(a1)
 4de:	0085b103          	ld	sp,8(a1)
 4e2:	6980                	ld	s0,16(a1)
 4e4:	6d84                	ld	s1,24(a1)
 4e6:	0205b903          	ld	s2,32(a1)
 4ea:	0285b983          	ld	s3,40(a1)
 4ee:	0305ba03          	ld	s4,48(a1)
 4f2:	0385ba83          	ld	s5,56(a1)
 4f6:	0405bb03          	ld	s6,64(a1)
 4fa:	0485bb83          	ld	s7,72(a1)
 4fe:	0505bc03          	ld	s8,80(a1)
 502:	0585bc83          	ld	s9,88(a1)
 506:	0605bd03          	ld	s10,96(a1)
 50a:	0685bd83          	ld	s11,104(a1)
 50e:	8082                	ret

0000000000000510 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 510:	1101                	addi	sp,sp,-32
 512:	ec06                	sd	ra,24(sp)
 514:	e822                	sd	s0,16(sp)
 516:	e426                	sd	s1,8(sp)
 518:	e04a                	sd	s2,0(sp)
 51a:	1000                	addi	s0,sp,32
 51c:	84aa                	mv	s1,a0
 51e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 520:	00000097          	auipc	ra,0x0
 524:	d1e080e7          	jalr	-738(ra) # 23e <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 528:	85ca                	mv	a1,s2
 52a:	8526                	mv	a0,s1
 52c:	00000097          	auipc	ra,0x0
 530:	bd8080e7          	jalr	-1064(ra) # 104 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 534:	00000097          	auipc	ra,0x0
 538:	274080e7          	jalr	628(ra) # 7a8 <exit>

000000000000053c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 53c:	1141                	addi	sp,sp,-16
 53e:	e422                	sd	s0,8(sp)
 540:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 542:	87aa                	mv	a5,a0
 544:	0585                	addi	a1,a1,1
 546:	0785                	addi	a5,a5,1
 548:	fff5c703          	lbu	a4,-1(a1)
 54c:	fee78fa3          	sb	a4,-1(a5)
 550:	fb75                	bnez	a4,544 <strcpy+0x8>
        ;
    return os;
}
 552:	6422                	ld	s0,8(sp)
 554:	0141                	addi	sp,sp,16
 556:	8082                	ret

0000000000000558 <strcmp>:

int strcmp(const char *p, const char *q)
{
 558:	1141                	addi	sp,sp,-16
 55a:	e422                	sd	s0,8(sp)
 55c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 55e:	00054783          	lbu	a5,0(a0)
 562:	cb91                	beqz	a5,576 <strcmp+0x1e>
 564:	0005c703          	lbu	a4,0(a1)
 568:	00f71763          	bne	a4,a5,576 <strcmp+0x1e>
        p++, q++;
 56c:	0505                	addi	a0,a0,1
 56e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 570:	00054783          	lbu	a5,0(a0)
 574:	fbe5                	bnez	a5,564 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 576:	0005c503          	lbu	a0,0(a1)
}
 57a:	40a7853b          	subw	a0,a5,a0
 57e:	6422                	ld	s0,8(sp)
 580:	0141                	addi	sp,sp,16
 582:	8082                	ret

0000000000000584 <strlen>:

uint strlen(const char *s)
{
 584:	1141                	addi	sp,sp,-16
 586:	e422                	sd	s0,8(sp)
 588:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 58a:	00054783          	lbu	a5,0(a0)
 58e:	cf91                	beqz	a5,5aa <strlen+0x26>
 590:	0505                	addi	a0,a0,1
 592:	87aa                	mv	a5,a0
 594:	86be                	mv	a3,a5
 596:	0785                	addi	a5,a5,1
 598:	fff7c703          	lbu	a4,-1(a5)
 59c:	ff65                	bnez	a4,594 <strlen+0x10>
 59e:	40a6853b          	subw	a0,a3,a0
 5a2:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
    for (n = 0; s[n]; n++)
 5aa:	4501                	li	a0,0
 5ac:	bfe5                	j	5a4 <strlen+0x20>

00000000000005ae <memset>:

void *
memset(void *dst, int c, uint n)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e422                	sd	s0,8(sp)
 5b2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5b4:	ca19                	beqz	a2,5ca <memset+0x1c>
 5b6:	87aa                	mv	a5,a0
 5b8:	1602                	slli	a2,a2,0x20
 5ba:	9201                	srli	a2,a2,0x20
 5bc:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5c0:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5c4:	0785                	addi	a5,a5,1
 5c6:	fee79de3          	bne	a5,a4,5c0 <memset+0x12>
    }
    return dst;
}
 5ca:	6422                	ld	s0,8(sp)
 5cc:	0141                	addi	sp,sp,16
 5ce:	8082                	ret

00000000000005d0 <strchr>:

char *
strchr(const char *s, char c)
{
 5d0:	1141                	addi	sp,sp,-16
 5d2:	e422                	sd	s0,8(sp)
 5d4:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5d6:	00054783          	lbu	a5,0(a0)
 5da:	cb99                	beqz	a5,5f0 <strchr+0x20>
        if (*s == c)
 5dc:	00f58763          	beq	a1,a5,5ea <strchr+0x1a>
    for (; *s; s++)
 5e0:	0505                	addi	a0,a0,1
 5e2:	00054783          	lbu	a5,0(a0)
 5e6:	fbfd                	bnez	a5,5dc <strchr+0xc>
            return (char *)s;
    return 0;
 5e8:	4501                	li	a0,0
}
 5ea:	6422                	ld	s0,8(sp)
 5ec:	0141                	addi	sp,sp,16
 5ee:	8082                	ret
    return 0;
 5f0:	4501                	li	a0,0
 5f2:	bfe5                	j	5ea <strchr+0x1a>

00000000000005f4 <gets>:

char *
gets(char *buf, int max)
{
 5f4:	711d                	addi	sp,sp,-96
 5f6:	ec86                	sd	ra,88(sp)
 5f8:	e8a2                	sd	s0,80(sp)
 5fa:	e4a6                	sd	s1,72(sp)
 5fc:	e0ca                	sd	s2,64(sp)
 5fe:	fc4e                	sd	s3,56(sp)
 600:	f852                	sd	s4,48(sp)
 602:	f456                	sd	s5,40(sp)
 604:	f05a                	sd	s6,32(sp)
 606:	ec5e                	sd	s7,24(sp)
 608:	1080                	addi	s0,sp,96
 60a:	8baa                	mv	s7,a0
 60c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 60e:	892a                	mv	s2,a0
 610:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 612:	4aa9                	li	s5,10
 614:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 616:	89a6                	mv	s3,s1
 618:	2485                	addiw	s1,s1,1
 61a:	0344d863          	bge	s1,s4,64a <gets+0x56>
        cc = read(0, &c, 1);
 61e:	4605                	li	a2,1
 620:	faf40593          	addi	a1,s0,-81
 624:	4501                	li	a0,0
 626:	00000097          	auipc	ra,0x0
 62a:	19a080e7          	jalr	410(ra) # 7c0 <read>
        if (cc < 1)
 62e:	00a05e63          	blez	a0,64a <gets+0x56>
        buf[i++] = c;
 632:	faf44783          	lbu	a5,-81(s0)
 636:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 63a:	01578763          	beq	a5,s5,648 <gets+0x54>
 63e:	0905                	addi	s2,s2,1
 640:	fd679be3          	bne	a5,s6,616 <gets+0x22>
    for (i = 0; i + 1 < max;)
 644:	89a6                	mv	s3,s1
 646:	a011                	j	64a <gets+0x56>
 648:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 64a:	99de                	add	s3,s3,s7
 64c:	00098023          	sb	zero,0(s3)
    return buf;
}
 650:	855e                	mv	a0,s7
 652:	60e6                	ld	ra,88(sp)
 654:	6446                	ld	s0,80(sp)
 656:	64a6                	ld	s1,72(sp)
 658:	6906                	ld	s2,64(sp)
 65a:	79e2                	ld	s3,56(sp)
 65c:	7a42                	ld	s4,48(sp)
 65e:	7aa2                	ld	s5,40(sp)
 660:	7b02                	ld	s6,32(sp)
 662:	6be2                	ld	s7,24(sp)
 664:	6125                	addi	sp,sp,96
 666:	8082                	ret

0000000000000668 <stat>:

int stat(const char *n, struct stat *st)
{
 668:	1101                	addi	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	e426                	sd	s1,8(sp)
 670:	e04a                	sd	s2,0(sp)
 672:	1000                	addi	s0,sp,32
 674:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 676:	4581                	li	a1,0
 678:	00000097          	auipc	ra,0x0
 67c:	170080e7          	jalr	368(ra) # 7e8 <open>
    if (fd < 0)
 680:	02054563          	bltz	a0,6aa <stat+0x42>
 684:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 686:	85ca                	mv	a1,s2
 688:	00000097          	auipc	ra,0x0
 68c:	178080e7          	jalr	376(ra) # 800 <fstat>
 690:	892a                	mv	s2,a0
    close(fd);
 692:	8526                	mv	a0,s1
 694:	00000097          	auipc	ra,0x0
 698:	13c080e7          	jalr	316(ra) # 7d0 <close>
    return r;
}
 69c:	854a                	mv	a0,s2
 69e:	60e2                	ld	ra,24(sp)
 6a0:	6442                	ld	s0,16(sp)
 6a2:	64a2                	ld	s1,8(sp)
 6a4:	6902                	ld	s2,0(sp)
 6a6:	6105                	addi	sp,sp,32
 6a8:	8082                	ret
        return -1;
 6aa:	597d                	li	s2,-1
 6ac:	bfc5                	j	69c <stat+0x34>

00000000000006ae <atoi>:

int atoi(const char *s)
{
 6ae:	1141                	addi	sp,sp,-16
 6b0:	e422                	sd	s0,8(sp)
 6b2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6b4:	00054683          	lbu	a3,0(a0)
 6b8:	fd06879b          	addiw	a5,a3,-48
 6bc:	0ff7f793          	zext.b	a5,a5
 6c0:	4625                	li	a2,9
 6c2:	02f66863          	bltu	a2,a5,6f2 <atoi+0x44>
 6c6:	872a                	mv	a4,a0
    n = 0;
 6c8:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6ca:	0705                	addi	a4,a4,1
 6cc:	0025179b          	slliw	a5,a0,0x2
 6d0:	9fa9                	addw	a5,a5,a0
 6d2:	0017979b          	slliw	a5,a5,0x1
 6d6:	9fb5                	addw	a5,a5,a3
 6d8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6dc:	00074683          	lbu	a3,0(a4)
 6e0:	fd06879b          	addiw	a5,a3,-48
 6e4:	0ff7f793          	zext.b	a5,a5
 6e8:	fef671e3          	bgeu	a2,a5,6ca <atoi+0x1c>
    return n;
}
 6ec:	6422                	ld	s0,8(sp)
 6ee:	0141                	addi	sp,sp,16
 6f0:	8082                	ret
    n = 0;
 6f2:	4501                	li	a0,0
 6f4:	bfe5                	j	6ec <atoi+0x3e>

00000000000006f6 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6f6:	1141                	addi	sp,sp,-16
 6f8:	e422                	sd	s0,8(sp)
 6fa:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6fc:	02b57463          	bgeu	a0,a1,724 <memmove+0x2e>
    {
        while (n-- > 0)
 700:	00c05f63          	blez	a2,71e <memmove+0x28>
 704:	1602                	slli	a2,a2,0x20
 706:	9201                	srli	a2,a2,0x20
 708:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 70c:	872a                	mv	a4,a0
            *dst++ = *src++;
 70e:	0585                	addi	a1,a1,1
 710:	0705                	addi	a4,a4,1
 712:	fff5c683          	lbu	a3,-1(a1)
 716:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 71a:	fee79ae3          	bne	a5,a4,70e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 71e:	6422                	ld	s0,8(sp)
 720:	0141                	addi	sp,sp,16
 722:	8082                	ret
        dst += n;
 724:	00c50733          	add	a4,a0,a2
        src += n;
 728:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 72a:	fec05ae3          	blez	a2,71e <memmove+0x28>
 72e:	fff6079b          	addiw	a5,a2,-1
 732:	1782                	slli	a5,a5,0x20
 734:	9381                	srli	a5,a5,0x20
 736:	fff7c793          	not	a5,a5
 73a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 73c:	15fd                	addi	a1,a1,-1
 73e:	177d                	addi	a4,a4,-1
 740:	0005c683          	lbu	a3,0(a1)
 744:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 748:	fee79ae3          	bne	a5,a4,73c <memmove+0x46>
 74c:	bfc9                	j	71e <memmove+0x28>

000000000000074e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 74e:	1141                	addi	sp,sp,-16
 750:	e422                	sd	s0,8(sp)
 752:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 754:	ca05                	beqz	a2,784 <memcmp+0x36>
 756:	fff6069b          	addiw	a3,a2,-1
 75a:	1682                	slli	a3,a3,0x20
 75c:	9281                	srli	a3,a3,0x20
 75e:	0685                	addi	a3,a3,1
 760:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 762:	00054783          	lbu	a5,0(a0)
 766:	0005c703          	lbu	a4,0(a1)
 76a:	00e79863          	bne	a5,a4,77a <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 76e:	0505                	addi	a0,a0,1
        p2++;
 770:	0585                	addi	a1,a1,1
    while (n-- > 0)
 772:	fed518e3          	bne	a0,a3,762 <memcmp+0x14>
    }
    return 0;
 776:	4501                	li	a0,0
 778:	a019                	j	77e <memcmp+0x30>
            return *p1 - *p2;
 77a:	40e7853b          	subw	a0,a5,a4
}
 77e:	6422                	ld	s0,8(sp)
 780:	0141                	addi	sp,sp,16
 782:	8082                	ret
    return 0;
 784:	4501                	li	a0,0
 786:	bfe5                	j	77e <memcmp+0x30>

0000000000000788 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 788:	1141                	addi	sp,sp,-16
 78a:	e406                	sd	ra,8(sp)
 78c:	e022                	sd	s0,0(sp)
 78e:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 790:	00000097          	auipc	ra,0x0
 794:	f66080e7          	jalr	-154(ra) # 6f6 <memmove>
}
 798:	60a2                	ld	ra,8(sp)
 79a:	6402                	ld	s0,0(sp)
 79c:	0141                	addi	sp,sp,16
 79e:	8082                	ret

00000000000007a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7a0:	4885                	li	a7,1
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7a8:	4889                	li	a7,2
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7b0:	488d                	li	a7,3
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7b8:	4891                	li	a7,4
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <read>:
.global read
read:
 li a7, SYS_read
 7c0:	4895                	li	a7,5
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <write>:
.global write
write:
 li a7, SYS_write
 7c8:	48c1                	li	a7,16
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <close>:
.global close
close:
 li a7, SYS_close
 7d0:	48d5                	li	a7,21
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7d8:	4899                	li	a7,6
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7e0:	489d                	li	a7,7
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <open>:
.global open
open:
 li a7, SYS_open
 7e8:	48bd                	li	a7,15
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7f0:	48c5                	li	a7,17
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7f8:	48c9                	li	a7,18
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 800:	48a1                	li	a7,8
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <link>:
.global link
link:
 li a7, SYS_link
 808:	48cd                	li	a7,19
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 810:	48d1                	li	a7,20
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 818:	48a5                	li	a7,9
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <dup>:
.global dup
dup:
 li a7, SYS_dup
 820:	48a9                	li	a7,10
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 828:	48ad                	li	a7,11
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 830:	48b1                	li	a7,12
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 838:	48b5                	li	a7,13
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 840:	48b9                	li	a7,14
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <ps>:
.global ps
ps:
 li a7, SYS_ps
 848:	48d9                	li	a7,22
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 850:	48dd                	li	a7,23
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 858:	48e1                	li	a7,24
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 860:	1101                	addi	sp,sp,-32
 862:	ec06                	sd	ra,24(sp)
 864:	e822                	sd	s0,16(sp)
 866:	1000                	addi	s0,sp,32
 868:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 86c:	4605                	li	a2,1
 86e:	fef40593          	addi	a1,s0,-17
 872:	00000097          	auipc	ra,0x0
 876:	f56080e7          	jalr	-170(ra) # 7c8 <write>
}
 87a:	60e2                	ld	ra,24(sp)
 87c:	6442                	ld	s0,16(sp)
 87e:	6105                	addi	sp,sp,32
 880:	8082                	ret

0000000000000882 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 882:	7139                	addi	sp,sp,-64
 884:	fc06                	sd	ra,56(sp)
 886:	f822                	sd	s0,48(sp)
 888:	f426                	sd	s1,40(sp)
 88a:	f04a                	sd	s2,32(sp)
 88c:	ec4e                	sd	s3,24(sp)
 88e:	0080                	addi	s0,sp,64
 890:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 892:	c299                	beqz	a3,898 <printint+0x16>
 894:	0805c963          	bltz	a1,926 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 898:	2581                	sext.w	a1,a1
  neg = 0;
 89a:	4881                	li	a7,0
 89c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8a0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8a2:	2601                	sext.w	a2,a2
 8a4:	00000517          	auipc	a0,0x0
 8a8:	54450513          	addi	a0,a0,1348 # de8 <digits>
 8ac:	883a                	mv	a6,a4
 8ae:	2705                	addiw	a4,a4,1
 8b0:	02c5f7bb          	remuw	a5,a1,a2
 8b4:	1782                	slli	a5,a5,0x20
 8b6:	9381                	srli	a5,a5,0x20
 8b8:	97aa                	add	a5,a5,a0
 8ba:	0007c783          	lbu	a5,0(a5)
 8be:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8c2:	0005879b          	sext.w	a5,a1
 8c6:	02c5d5bb          	divuw	a1,a1,a2
 8ca:	0685                	addi	a3,a3,1
 8cc:	fec7f0e3          	bgeu	a5,a2,8ac <printint+0x2a>
  if(neg)
 8d0:	00088c63          	beqz	a7,8e8 <printint+0x66>
    buf[i++] = '-';
 8d4:	fd070793          	addi	a5,a4,-48
 8d8:	00878733          	add	a4,a5,s0
 8dc:	02d00793          	li	a5,45
 8e0:	fef70823          	sb	a5,-16(a4)
 8e4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8e8:	02e05863          	blez	a4,918 <printint+0x96>
 8ec:	fc040793          	addi	a5,s0,-64
 8f0:	00e78933          	add	s2,a5,a4
 8f4:	fff78993          	addi	s3,a5,-1
 8f8:	99ba                	add	s3,s3,a4
 8fa:	377d                	addiw	a4,a4,-1
 8fc:	1702                	slli	a4,a4,0x20
 8fe:	9301                	srli	a4,a4,0x20
 900:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 904:	fff94583          	lbu	a1,-1(s2)
 908:	8526                	mv	a0,s1
 90a:	00000097          	auipc	ra,0x0
 90e:	f56080e7          	jalr	-170(ra) # 860 <putc>
  while(--i >= 0)
 912:	197d                	addi	s2,s2,-1
 914:	ff3918e3          	bne	s2,s3,904 <printint+0x82>
}
 918:	70e2                	ld	ra,56(sp)
 91a:	7442                	ld	s0,48(sp)
 91c:	74a2                	ld	s1,40(sp)
 91e:	7902                	ld	s2,32(sp)
 920:	69e2                	ld	s3,24(sp)
 922:	6121                	addi	sp,sp,64
 924:	8082                	ret
    x = -xx;
 926:	40b005bb          	negw	a1,a1
    neg = 1;
 92a:	4885                	li	a7,1
    x = -xx;
 92c:	bf85                	j	89c <printint+0x1a>

000000000000092e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 92e:	715d                	addi	sp,sp,-80
 930:	e486                	sd	ra,72(sp)
 932:	e0a2                	sd	s0,64(sp)
 934:	fc26                	sd	s1,56(sp)
 936:	f84a                	sd	s2,48(sp)
 938:	f44e                	sd	s3,40(sp)
 93a:	f052                	sd	s4,32(sp)
 93c:	ec56                	sd	s5,24(sp)
 93e:	e85a                	sd	s6,16(sp)
 940:	e45e                	sd	s7,8(sp)
 942:	e062                	sd	s8,0(sp)
 944:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 946:	0005c903          	lbu	s2,0(a1)
 94a:	18090c63          	beqz	s2,ae2 <vprintf+0x1b4>
 94e:	8aaa                	mv	s5,a0
 950:	8bb2                	mv	s7,a2
 952:	00158493          	addi	s1,a1,1
  state = 0;
 956:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 958:	02500a13          	li	s4,37
 95c:	4b55                	li	s6,21
 95e:	a839                	j	97c <vprintf+0x4e>
        putc(fd, c);
 960:	85ca                	mv	a1,s2
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	efc080e7          	jalr	-260(ra) # 860 <putc>
 96c:	a019                	j	972 <vprintf+0x44>
    } else if(state == '%'){
 96e:	01498d63          	beq	s3,s4,988 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 972:	0485                	addi	s1,s1,1
 974:	fff4c903          	lbu	s2,-1(s1)
 978:	16090563          	beqz	s2,ae2 <vprintf+0x1b4>
    if(state == 0){
 97c:	fe0999e3          	bnez	s3,96e <vprintf+0x40>
      if(c == '%'){
 980:	ff4910e3          	bne	s2,s4,960 <vprintf+0x32>
        state = '%';
 984:	89d2                	mv	s3,s4
 986:	b7f5                	j	972 <vprintf+0x44>
      if(c == 'd'){
 988:	13490263          	beq	s2,s4,aac <vprintf+0x17e>
 98c:	f9d9079b          	addiw	a5,s2,-99
 990:	0ff7f793          	zext.b	a5,a5
 994:	12fb6563          	bltu	s6,a5,abe <vprintf+0x190>
 998:	f9d9079b          	addiw	a5,s2,-99
 99c:	0ff7f713          	zext.b	a4,a5
 9a0:	10eb6f63          	bltu	s6,a4,abe <vprintf+0x190>
 9a4:	00271793          	slli	a5,a4,0x2
 9a8:	00000717          	auipc	a4,0x0
 9ac:	3e870713          	addi	a4,a4,1000 # d90 <malloc+0x1b0>
 9b0:	97ba                	add	a5,a5,a4
 9b2:	439c                	lw	a5,0(a5)
 9b4:	97ba                	add	a5,a5,a4
 9b6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9b8:	008b8913          	addi	s2,s7,8
 9bc:	4685                	li	a3,1
 9be:	4629                	li	a2,10
 9c0:	000ba583          	lw	a1,0(s7)
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	ebc080e7          	jalr	-324(ra) # 882 <printint>
 9ce:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	b745                	j	972 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d4:	008b8913          	addi	s2,s7,8
 9d8:	4681                	li	a3,0
 9da:	4629                	li	a2,10
 9dc:	000ba583          	lw	a1,0(s7)
 9e0:	8556                	mv	a0,s5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	ea0080e7          	jalr	-352(ra) # 882 <printint>
 9ea:	8bca                	mv	s7,s2
      state = 0;
 9ec:	4981                	li	s3,0
 9ee:	b751                	j	972 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9f0:	008b8913          	addi	s2,s7,8
 9f4:	4681                	li	a3,0
 9f6:	4641                	li	a2,16
 9f8:	000ba583          	lw	a1,0(s7)
 9fc:	8556                	mv	a0,s5
 9fe:	00000097          	auipc	ra,0x0
 a02:	e84080e7          	jalr	-380(ra) # 882 <printint>
 a06:	8bca                	mv	s7,s2
      state = 0;
 a08:	4981                	li	s3,0
 a0a:	b7a5                	j	972 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a0c:	008b8c13          	addi	s8,s7,8
 a10:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a14:	03000593          	li	a1,48
 a18:	8556                	mv	a0,s5
 a1a:	00000097          	auipc	ra,0x0
 a1e:	e46080e7          	jalr	-442(ra) # 860 <putc>
  putc(fd, 'x');
 a22:	07800593          	li	a1,120
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	e38080e7          	jalr	-456(ra) # 860 <putc>
 a30:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a32:	00000b97          	auipc	s7,0x0
 a36:	3b6b8b93          	addi	s7,s7,950 # de8 <digits>
 a3a:	03c9d793          	srli	a5,s3,0x3c
 a3e:	97de                	add	a5,a5,s7
 a40:	0007c583          	lbu	a1,0(a5)
 a44:	8556                	mv	a0,s5
 a46:	00000097          	auipc	ra,0x0
 a4a:	e1a080e7          	jalr	-486(ra) # 860 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a4e:	0992                	slli	s3,s3,0x4
 a50:	397d                	addiw	s2,s2,-1
 a52:	fe0914e3          	bnez	s2,a3a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a56:	8be2                	mv	s7,s8
      state = 0;
 a58:	4981                	li	s3,0
 a5a:	bf21                	j	972 <vprintf+0x44>
        s = va_arg(ap, char*);
 a5c:	008b8993          	addi	s3,s7,8
 a60:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a64:	02090163          	beqz	s2,a86 <vprintf+0x158>
        while(*s != 0){
 a68:	00094583          	lbu	a1,0(s2)
 a6c:	c9a5                	beqz	a1,adc <vprintf+0x1ae>
          putc(fd, *s);
 a6e:	8556                	mv	a0,s5
 a70:	00000097          	auipc	ra,0x0
 a74:	df0080e7          	jalr	-528(ra) # 860 <putc>
          s++;
 a78:	0905                	addi	s2,s2,1
        while(*s != 0){
 a7a:	00094583          	lbu	a1,0(s2)
 a7e:	f9e5                	bnez	a1,a6e <vprintf+0x140>
        s = va_arg(ap, char*);
 a80:	8bce                	mv	s7,s3
      state = 0;
 a82:	4981                	li	s3,0
 a84:	b5fd                	j	972 <vprintf+0x44>
          s = "(null)";
 a86:	00000917          	auipc	s2,0x0
 a8a:	30290913          	addi	s2,s2,770 # d88 <malloc+0x1a8>
        while(*s != 0){
 a8e:	02800593          	li	a1,40
 a92:	bff1                	j	a6e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a94:	008b8913          	addi	s2,s7,8
 a98:	000bc583          	lbu	a1,0(s7)
 a9c:	8556                	mv	a0,s5
 a9e:	00000097          	auipc	ra,0x0
 aa2:	dc2080e7          	jalr	-574(ra) # 860 <putc>
 aa6:	8bca                	mv	s7,s2
      state = 0;
 aa8:	4981                	li	s3,0
 aaa:	b5e1                	j	972 <vprintf+0x44>
        putc(fd, c);
 aac:	02500593          	li	a1,37
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	dae080e7          	jalr	-594(ra) # 860 <putc>
      state = 0;
 aba:	4981                	li	s3,0
 abc:	bd5d                	j	972 <vprintf+0x44>
        putc(fd, '%');
 abe:	02500593          	li	a1,37
 ac2:	8556                	mv	a0,s5
 ac4:	00000097          	auipc	ra,0x0
 ac8:	d9c080e7          	jalr	-612(ra) # 860 <putc>
        putc(fd, c);
 acc:	85ca                	mv	a1,s2
 ace:	8556                	mv	a0,s5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	d90080e7          	jalr	-624(ra) # 860 <putc>
      state = 0;
 ad8:	4981                	li	s3,0
 ada:	bd61                	j	972 <vprintf+0x44>
        s = va_arg(ap, char*);
 adc:	8bce                	mv	s7,s3
      state = 0;
 ade:	4981                	li	s3,0
 ae0:	bd49                	j	972 <vprintf+0x44>
    }
  }
}
 ae2:	60a6                	ld	ra,72(sp)
 ae4:	6406                	ld	s0,64(sp)
 ae6:	74e2                	ld	s1,56(sp)
 ae8:	7942                	ld	s2,48(sp)
 aea:	79a2                	ld	s3,40(sp)
 aec:	7a02                	ld	s4,32(sp)
 aee:	6ae2                	ld	s5,24(sp)
 af0:	6b42                	ld	s6,16(sp)
 af2:	6ba2                	ld	s7,8(sp)
 af4:	6c02                	ld	s8,0(sp)
 af6:	6161                	addi	sp,sp,80
 af8:	8082                	ret

0000000000000afa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 afa:	715d                	addi	sp,sp,-80
 afc:	ec06                	sd	ra,24(sp)
 afe:	e822                	sd	s0,16(sp)
 b00:	1000                	addi	s0,sp,32
 b02:	e010                	sd	a2,0(s0)
 b04:	e414                	sd	a3,8(s0)
 b06:	e818                	sd	a4,16(s0)
 b08:	ec1c                	sd	a5,24(s0)
 b0a:	03043023          	sd	a6,32(s0)
 b0e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b12:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b16:	8622                	mv	a2,s0
 b18:	00000097          	auipc	ra,0x0
 b1c:	e16080e7          	jalr	-490(ra) # 92e <vprintf>
}
 b20:	60e2                	ld	ra,24(sp)
 b22:	6442                	ld	s0,16(sp)
 b24:	6161                	addi	sp,sp,80
 b26:	8082                	ret

0000000000000b28 <printf>:

void
printf(const char *fmt, ...)
{
 b28:	711d                	addi	sp,sp,-96
 b2a:	ec06                	sd	ra,24(sp)
 b2c:	e822                	sd	s0,16(sp)
 b2e:	1000                	addi	s0,sp,32
 b30:	e40c                	sd	a1,8(s0)
 b32:	e810                	sd	a2,16(s0)
 b34:	ec14                	sd	a3,24(s0)
 b36:	f018                	sd	a4,32(s0)
 b38:	f41c                	sd	a5,40(s0)
 b3a:	03043823          	sd	a6,48(s0)
 b3e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b42:	00840613          	addi	a2,s0,8
 b46:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b4a:	85aa                	mv	a1,a0
 b4c:	4505                	li	a0,1
 b4e:	00000097          	auipc	ra,0x0
 b52:	de0080e7          	jalr	-544(ra) # 92e <vprintf>
}
 b56:	60e2                	ld	ra,24(sp)
 b58:	6442                	ld	s0,16(sp)
 b5a:	6125                	addi	sp,sp,96
 b5c:	8082                	ret

0000000000000b5e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b5e:	1141                	addi	sp,sp,-16
 b60:	e422                	sd	s0,8(sp)
 b62:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b64:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b68:	00000797          	auipc	a5,0x0
 b6c:	2a07b783          	ld	a5,672(a5) # e08 <freep>
 b70:	a02d                	j	b9a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b72:	4618                	lw	a4,8(a2)
 b74:	9f2d                	addw	a4,a4,a1
 b76:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b7a:	6398                	ld	a4,0(a5)
 b7c:	6310                	ld	a2,0(a4)
 b7e:	a83d                	j	bbc <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b80:	ff852703          	lw	a4,-8(a0)
 b84:	9f31                	addw	a4,a4,a2
 b86:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b88:	ff053683          	ld	a3,-16(a0)
 b8c:	a091                	j	bd0 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8e:	6398                	ld	a4,0(a5)
 b90:	00e7e463          	bltu	a5,a4,b98 <free+0x3a>
 b94:	00e6ea63          	bltu	a3,a4,ba8 <free+0x4a>
{
 b98:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9a:	fed7fae3          	bgeu	a5,a3,b8e <free+0x30>
 b9e:	6398                	ld	a4,0(a5)
 ba0:	00e6e463          	bltu	a3,a4,ba8 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ba4:	fee7eae3          	bltu	a5,a4,b98 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ba8:	ff852583          	lw	a1,-8(a0)
 bac:	6390                	ld	a2,0(a5)
 bae:	02059813          	slli	a6,a1,0x20
 bb2:	01c85713          	srli	a4,a6,0x1c
 bb6:	9736                	add	a4,a4,a3
 bb8:	fae60de3          	beq	a2,a4,b72 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bbc:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bc0:	4790                	lw	a2,8(a5)
 bc2:	02061593          	slli	a1,a2,0x20
 bc6:	01c5d713          	srli	a4,a1,0x1c
 bca:	973e                	add	a4,a4,a5
 bcc:	fae68ae3          	beq	a3,a4,b80 <free+0x22>
        p->s.ptr = bp->s.ptr;
 bd0:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bd2:	00000717          	auipc	a4,0x0
 bd6:	22f73b23          	sd	a5,566(a4) # e08 <freep>
}
 bda:	6422                	ld	s0,8(sp)
 bdc:	0141                	addi	sp,sp,16
 bde:	8082                	ret

0000000000000be0 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 be0:	7139                	addi	sp,sp,-64
 be2:	fc06                	sd	ra,56(sp)
 be4:	f822                	sd	s0,48(sp)
 be6:	f426                	sd	s1,40(sp)
 be8:	f04a                	sd	s2,32(sp)
 bea:	ec4e                	sd	s3,24(sp)
 bec:	e852                	sd	s4,16(sp)
 bee:	e456                	sd	s5,8(sp)
 bf0:	e05a                	sd	s6,0(sp)
 bf2:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bf4:	02051493          	slli	s1,a0,0x20
 bf8:	9081                	srli	s1,s1,0x20
 bfa:	04bd                	addi	s1,s1,15
 bfc:	8091                	srli	s1,s1,0x4
 bfe:	0014899b          	addiw	s3,s1,1
 c02:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c04:	00000517          	auipc	a0,0x0
 c08:	20453503          	ld	a0,516(a0) # e08 <freep>
 c0c:	c515                	beqz	a0,c38 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c0e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c10:	4798                	lw	a4,8(a5)
 c12:	02977f63          	bgeu	a4,s1,c50 <malloc+0x70>
    if (nu < 4096)
 c16:	8a4e                	mv	s4,s3
 c18:	0009871b          	sext.w	a4,s3
 c1c:	6685                	lui	a3,0x1
 c1e:	00d77363          	bgeu	a4,a3,c24 <malloc+0x44>
 c22:	6a05                	lui	s4,0x1
 c24:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c28:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c2c:	00000917          	auipc	s2,0x0
 c30:	1dc90913          	addi	s2,s2,476 # e08 <freep>
    if (p == (char *)-1)
 c34:	5afd                	li	s5,-1
 c36:	a895                	j	caa <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c38:	00000797          	auipc	a5,0x0
 c3c:	25878793          	addi	a5,a5,600 # e90 <base>
 c40:	00000717          	auipc	a4,0x0
 c44:	1cf73423          	sd	a5,456(a4) # e08 <freep>
 c48:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c4a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c4e:	b7e1                	j	c16 <malloc+0x36>
            if (p->s.size == nunits)
 c50:	02e48c63          	beq	s1,a4,c88 <malloc+0xa8>
                p->s.size -= nunits;
 c54:	4137073b          	subw	a4,a4,s3
 c58:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c5a:	02071693          	slli	a3,a4,0x20
 c5e:	01c6d713          	srli	a4,a3,0x1c
 c62:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c64:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c68:	00000717          	auipc	a4,0x0
 c6c:	1aa73023          	sd	a0,416(a4) # e08 <freep>
            return (void *)(p + 1);
 c70:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c74:	70e2                	ld	ra,56(sp)
 c76:	7442                	ld	s0,48(sp)
 c78:	74a2                	ld	s1,40(sp)
 c7a:	7902                	ld	s2,32(sp)
 c7c:	69e2                	ld	s3,24(sp)
 c7e:	6a42                	ld	s4,16(sp)
 c80:	6aa2                	ld	s5,8(sp)
 c82:	6b02                	ld	s6,0(sp)
 c84:	6121                	addi	sp,sp,64
 c86:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c88:	6398                	ld	a4,0(a5)
 c8a:	e118                	sd	a4,0(a0)
 c8c:	bff1                	j	c68 <malloc+0x88>
    hp->s.size = nu;
 c8e:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c92:	0541                	addi	a0,a0,16
 c94:	00000097          	auipc	ra,0x0
 c98:	eca080e7          	jalr	-310(ra) # b5e <free>
    return freep;
 c9c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 ca0:	d971                	beqz	a0,c74 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ca2:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ca4:	4798                	lw	a4,8(a5)
 ca6:	fa9775e3          	bgeu	a4,s1,c50 <malloc+0x70>
        if (p == freep)
 caa:	00093703          	ld	a4,0(s2)
 cae:	853e                	mv	a0,a5
 cb0:	fef719e3          	bne	a4,a5,ca2 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cb4:	8552                	mv	a0,s4
 cb6:	00000097          	auipc	ra,0x0
 cba:	b7a080e7          	jalr	-1158(ra) # 830 <sbrk>
    if (p == (char *)-1)
 cbe:	fd5518e3          	bne	a0,s5,c8e <malloc+0xae>
                return 0;
 cc2:	4501                	li	a0,0
 cc4:	bf45                	j	c74 <malloc+0x94>
