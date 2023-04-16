
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
  10:	3a8080e7          	jalr	936(ra) # 3b4 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	5dc080e7          	jalr	1500(ra) # 5f8 <write>
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
  3e:	abe50513          	addi	a0,a0,-1346 # af8 <malloc+0xe8>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	580080e7          	jalr	1408(ra) # 5d0 <fork>
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
  68:	aa450513          	addi	a0,a0,-1372 # b08 <malloc+0xf8>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	562080e7          	jalr	1378(ra) # 5d8 <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	55a080e7          	jalr	1370(ra) # 5d8 <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	54c080e7          	jalr	1356(ra) # 5e0 <wait>
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
  aa:	53a080e7          	jalr	1338(ra) # 5e0 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	aa450513          	addi	a0,a0,-1372 # b58 <malloc+0x148>
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
  d4:	a5850513          	addi	a0,a0,-1448 # b28 <malloc+0x118>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	4f6080e7          	jalr	1270(ra) # 5d8 <exit>
    print("wait got too many\n");
  ea:	00001517          	auipc	a0,0x1
  ee:	a5650513          	addi	a0,a0,-1450 # b40 <malloc+0x130>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	4dc080e7          	jalr	1244(ra) # 5d8 <exit>

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
 11a:	4c2080e7          	jalr	1218(ra) # 5d8 <exit>

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
 152:	172080e7          	jalr	370(ra) # 2c0 <twhoami>
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
 19e:	9ce50513          	addi	a0,a0,-1586 # b68 <malloc+0x158>
 1a2:	00000097          	auipc	ra,0x0
 1a6:	7b6080e7          	jalr	1974(ra) # 958 <printf>
        exit(-1);
 1aa:	557d                	li	a0,-1
 1ac:	00000097          	auipc	ra,0x0
 1b0:	42c080e7          	jalr	1068(ra) # 5d8 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b4:	00000097          	auipc	ra,0x0
 1b8:	0f4080e7          	jalr	244(ra) # 2a8 <tyield>
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
 1d2:	0f2080e7          	jalr	242(ra) # 2c0 <twhoami>
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
 216:	096080e7          	jalr	150(ra) # 2a8 <tyield>
}
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	64a2                	ld	s1,8(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret
        printf("releasing lock we are not holding");
 224:	00001517          	auipc	a0,0x1
 228:	96c50513          	addi	a0,a0,-1684 # b90 <malloc+0x180>
 22c:	00000097          	auipc	ra,0x0
 230:	72c080e7          	jalr	1836(ra) # 958 <printf>
        exit(-1);
 234:	557d                	li	a0,-1
 236:	00000097          	auipc	ra,0x0
 23a:	3a2080e7          	jalr	930(ra) # 5d8 <exit>

000000000000023e <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 244:	00001717          	auipc	a4,0x1
 248:	9ec73703          	ld	a4,-1556(a4) # c30 <current_thread>
 24c:	47c1                	li	a5,16
 24e:	c319                	beqz	a4,254 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 250:	37fd                	addiw	a5,a5,-1
 252:	fff5                	bnez	a5,24e <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 25a:	7179                	addi	sp,sp,-48
 25c:	f406                	sd	ra,40(sp)
 25e:	f022                	sd	s0,32(sp)
 260:	ec26                	sd	s1,24(sp)
 262:	e84a                	sd	s2,16(sp)
 264:	e44e                	sd	s3,8(sp)
 266:	1800                	addi	s0,sp,48
 268:	84aa                	mv	s1,a0
 26a:	89b2                	mv	s3,a2
 26c:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 26e:	09000513          	li	a0,144
 272:	00000097          	auipc	ra,0x0
 276:	79e080e7          	jalr	1950(ra) # a10 <malloc>
 27a:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 27c:	478d                	li	a5,3
 27e:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 280:	609c                	ld	a5,0(s1)
 282:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 286:	609c                	ld	a5,0(s1)
 288:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 28c:	70a2                	ld	ra,40(sp)
 28e:	7402                	ld	s0,32(sp)
 290:	64e2                	ld	s1,24(sp)
 292:	6942                	ld	s2,16(sp)
 294:	69a2                	ld	s3,8(sp)
 296:	6145                	addi	sp,sp,48
 298:	8082                	ret

000000000000029a <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 2a0:	4501                	li	a0,0
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <tyield>:

void tyield()
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 2ae:	00001797          	auipc	a5,0x1
 2b2:	9827b783          	ld	a5,-1662(a5) # c30 <current_thread>
 2b6:	470d                	li	a4,3
 2b8:	dfb8                	sw	a4,120(a5)
    tsched();
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <twhoami>:

uint8 twhoami()
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 2c6:	4501                	li	a0,0
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <tswtch>:
 2ce:	00153023          	sd	ra,0(a0)
 2d2:	00253423          	sd	sp,8(a0)
 2d6:	e900                	sd	s0,16(a0)
 2d8:	ed04                	sd	s1,24(a0)
 2da:	03253023          	sd	s2,32(a0)
 2de:	03353423          	sd	s3,40(a0)
 2e2:	03453823          	sd	s4,48(a0)
 2e6:	03553c23          	sd	s5,56(a0)
 2ea:	05653023          	sd	s6,64(a0)
 2ee:	05753423          	sd	s7,72(a0)
 2f2:	05853823          	sd	s8,80(a0)
 2f6:	05953c23          	sd	s9,88(a0)
 2fa:	07a53023          	sd	s10,96(a0)
 2fe:	07b53423          	sd	s11,104(a0)
 302:	0005b083          	ld	ra,0(a1)
 306:	0085b103          	ld	sp,8(a1)
 30a:	6980                	ld	s0,16(a1)
 30c:	6d84                	ld	s1,24(a1)
 30e:	0205b903          	ld	s2,32(a1)
 312:	0285b983          	ld	s3,40(a1)
 316:	0305ba03          	ld	s4,48(a1)
 31a:	0385ba83          	ld	s5,56(a1)
 31e:	0405bb03          	ld	s6,64(a1)
 322:	0485bb83          	ld	s7,72(a1)
 326:	0505bc03          	ld	s8,80(a1)
 32a:	0585bc83          	ld	s9,88(a1)
 32e:	0605bd03          	ld	s10,96(a1)
 332:	0685bd83          	ld	s11,104(a1)
 336:	8082                	ret

0000000000000338 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 338:	1101                	addi	sp,sp,-32
 33a:	ec06                	sd	ra,24(sp)
 33c:	e822                	sd	s0,16(sp)
 33e:	e426                	sd	s1,8(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	addi	s0,sp,32
 344:	84aa                	mv	s1,a0
 346:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 348:	09000513          	li	a0,144
 34c:	00000097          	auipc	ra,0x0
 350:	6c4080e7          	jalr	1732(ra) # a10 <malloc>

    main_thread->tid = 0;
 354:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 358:	85ca                	mv	a1,s2
 35a:	8526                	mv	a0,s1
 35c:	00000097          	auipc	ra,0x0
 360:	da8080e7          	jalr	-600(ra) # 104 <main>
    exit(res);
 364:	00000097          	auipc	ra,0x0
 368:	274080e7          	jalr	628(ra) # 5d8 <exit>

000000000000036c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 372:	87aa                	mv	a5,a0
 374:	0585                	addi	a1,a1,1
 376:	0785                	addi	a5,a5,1
 378:	fff5c703          	lbu	a4,-1(a1)
 37c:	fee78fa3          	sb	a4,-1(a5)
 380:	fb75                	bnez	a4,374 <strcpy+0x8>
        ;
    return os;
}
 382:	6422                	ld	s0,8(sp)
 384:	0141                	addi	sp,sp,16
 386:	8082                	ret

0000000000000388 <strcmp>:

int strcmp(const char *p, const char *q)
{
 388:	1141                	addi	sp,sp,-16
 38a:	e422                	sd	s0,8(sp)
 38c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 38e:	00054783          	lbu	a5,0(a0)
 392:	cb91                	beqz	a5,3a6 <strcmp+0x1e>
 394:	0005c703          	lbu	a4,0(a1)
 398:	00f71763          	bne	a4,a5,3a6 <strcmp+0x1e>
        p++, q++;
 39c:	0505                	addi	a0,a0,1
 39e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	fbe5                	bnez	a5,394 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 3a6:	0005c503          	lbu	a0,0(a1)
}
 3aa:	40a7853b          	subw	a0,a5,a0
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret

00000000000003b4 <strlen>:

uint strlen(const char *s)
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e422                	sd	s0,8(sp)
 3b8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 3ba:	00054783          	lbu	a5,0(a0)
 3be:	cf91                	beqz	a5,3da <strlen+0x26>
 3c0:	0505                	addi	a0,a0,1
 3c2:	87aa                	mv	a5,a0
 3c4:	86be                	mv	a3,a5
 3c6:	0785                	addi	a5,a5,1
 3c8:	fff7c703          	lbu	a4,-1(a5)
 3cc:	ff65                	bnez	a4,3c4 <strlen+0x10>
 3ce:	40a6853b          	subw	a0,a3,a0
 3d2:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret
    for (n = 0; s[n]; n++)
 3da:	4501                	li	a0,0
 3dc:	bfe5                	j	3d4 <strlen+0x20>

00000000000003de <memset>:

void *
memset(void *dst, int c, uint n)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 3e4:	ca19                	beqz	a2,3fa <memset+0x1c>
 3e6:	87aa                	mv	a5,a0
 3e8:	1602                	slli	a2,a2,0x20
 3ea:	9201                	srli	a2,a2,0x20
 3ec:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 3f0:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 3f4:	0785                	addi	a5,a5,1
 3f6:	fee79de3          	bne	a5,a4,3f0 <memset+0x12>
    }
    return dst;
}
 3fa:	6422                	ld	s0,8(sp)
 3fc:	0141                	addi	sp,sp,16
 3fe:	8082                	ret

0000000000000400 <strchr>:

char *
strchr(const char *s, char c)
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
    for (; *s; s++)
 406:	00054783          	lbu	a5,0(a0)
 40a:	cb99                	beqz	a5,420 <strchr+0x20>
        if (*s == c)
 40c:	00f58763          	beq	a1,a5,41a <strchr+0x1a>
    for (; *s; s++)
 410:	0505                	addi	a0,a0,1
 412:	00054783          	lbu	a5,0(a0)
 416:	fbfd                	bnez	a5,40c <strchr+0xc>
            return (char *)s;
    return 0;
 418:	4501                	li	a0,0
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret
    return 0;
 420:	4501                	li	a0,0
 422:	bfe5                	j	41a <strchr+0x1a>

0000000000000424 <gets>:

char *
gets(char *buf, int max)
{
 424:	711d                	addi	sp,sp,-96
 426:	ec86                	sd	ra,88(sp)
 428:	e8a2                	sd	s0,80(sp)
 42a:	e4a6                	sd	s1,72(sp)
 42c:	e0ca                	sd	s2,64(sp)
 42e:	fc4e                	sd	s3,56(sp)
 430:	f852                	sd	s4,48(sp)
 432:	f456                	sd	s5,40(sp)
 434:	f05a                	sd	s6,32(sp)
 436:	ec5e                	sd	s7,24(sp)
 438:	1080                	addi	s0,sp,96
 43a:	8baa                	mv	s7,a0
 43c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 43e:	892a                	mv	s2,a0
 440:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 442:	4aa9                	li	s5,10
 444:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 446:	89a6                	mv	s3,s1
 448:	2485                	addiw	s1,s1,1
 44a:	0344d863          	bge	s1,s4,47a <gets+0x56>
        cc = read(0, &c, 1);
 44e:	4605                	li	a2,1
 450:	faf40593          	addi	a1,s0,-81
 454:	4501                	li	a0,0
 456:	00000097          	auipc	ra,0x0
 45a:	19a080e7          	jalr	410(ra) # 5f0 <read>
        if (cc < 1)
 45e:	00a05e63          	blez	a0,47a <gets+0x56>
        buf[i++] = c;
 462:	faf44783          	lbu	a5,-81(s0)
 466:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 46a:	01578763          	beq	a5,s5,478 <gets+0x54>
 46e:	0905                	addi	s2,s2,1
 470:	fd679be3          	bne	a5,s6,446 <gets+0x22>
    for (i = 0; i + 1 < max;)
 474:	89a6                	mv	s3,s1
 476:	a011                	j	47a <gets+0x56>
 478:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 47a:	99de                	add	s3,s3,s7
 47c:	00098023          	sb	zero,0(s3)
    return buf;
}
 480:	855e                	mv	a0,s7
 482:	60e6                	ld	ra,88(sp)
 484:	6446                	ld	s0,80(sp)
 486:	64a6                	ld	s1,72(sp)
 488:	6906                	ld	s2,64(sp)
 48a:	79e2                	ld	s3,56(sp)
 48c:	7a42                	ld	s4,48(sp)
 48e:	7aa2                	ld	s5,40(sp)
 490:	7b02                	ld	s6,32(sp)
 492:	6be2                	ld	s7,24(sp)
 494:	6125                	addi	sp,sp,96
 496:	8082                	ret

0000000000000498 <stat>:

int stat(const char *n, struct stat *st)
{
 498:	1101                	addi	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	e426                	sd	s1,8(sp)
 4a0:	e04a                	sd	s2,0(sp)
 4a2:	1000                	addi	s0,sp,32
 4a4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 4a6:	4581                	li	a1,0
 4a8:	00000097          	auipc	ra,0x0
 4ac:	170080e7          	jalr	368(ra) # 618 <open>
    if (fd < 0)
 4b0:	02054563          	bltz	a0,4da <stat+0x42>
 4b4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 4b6:	85ca                	mv	a1,s2
 4b8:	00000097          	auipc	ra,0x0
 4bc:	178080e7          	jalr	376(ra) # 630 <fstat>
 4c0:	892a                	mv	s2,a0
    close(fd);
 4c2:	8526                	mv	a0,s1
 4c4:	00000097          	auipc	ra,0x0
 4c8:	13c080e7          	jalr	316(ra) # 600 <close>
    return r;
}
 4cc:	854a                	mv	a0,s2
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	64a2                	ld	s1,8(sp)
 4d4:	6902                	ld	s2,0(sp)
 4d6:	6105                	addi	sp,sp,32
 4d8:	8082                	ret
        return -1;
 4da:	597d                	li	s2,-1
 4dc:	bfc5                	j	4cc <stat+0x34>

00000000000004de <atoi>:

int atoi(const char *s)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4e4:	00054683          	lbu	a3,0(a0)
 4e8:	fd06879b          	addiw	a5,a3,-48
 4ec:	0ff7f793          	zext.b	a5,a5
 4f0:	4625                	li	a2,9
 4f2:	02f66863          	bltu	a2,a5,522 <atoi+0x44>
 4f6:	872a                	mv	a4,a0
    n = 0;
 4f8:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4fa:	0705                	addi	a4,a4,1
 4fc:	0025179b          	slliw	a5,a0,0x2
 500:	9fa9                	addw	a5,a5,a0
 502:	0017979b          	slliw	a5,a5,0x1
 506:	9fb5                	addw	a5,a5,a3
 508:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 50c:	00074683          	lbu	a3,0(a4)
 510:	fd06879b          	addiw	a5,a3,-48
 514:	0ff7f793          	zext.b	a5,a5
 518:	fef671e3          	bgeu	a2,a5,4fa <atoi+0x1c>
    return n;
}
 51c:	6422                	ld	s0,8(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret
    n = 0;
 522:	4501                	li	a0,0
 524:	bfe5                	j	51c <atoi+0x3e>

0000000000000526 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 526:	1141                	addi	sp,sp,-16
 528:	e422                	sd	s0,8(sp)
 52a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 52c:	02b57463          	bgeu	a0,a1,554 <memmove+0x2e>
    {
        while (n-- > 0)
 530:	00c05f63          	blez	a2,54e <memmove+0x28>
 534:	1602                	slli	a2,a2,0x20
 536:	9201                	srli	a2,a2,0x20
 538:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 53c:	872a                	mv	a4,a0
            *dst++ = *src++;
 53e:	0585                	addi	a1,a1,1
 540:	0705                	addi	a4,a4,1
 542:	fff5c683          	lbu	a3,-1(a1)
 546:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 54a:	fee79ae3          	bne	a5,a4,53e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 54e:	6422                	ld	s0,8(sp)
 550:	0141                	addi	sp,sp,16
 552:	8082                	ret
        dst += n;
 554:	00c50733          	add	a4,a0,a2
        src += n;
 558:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 55a:	fec05ae3          	blez	a2,54e <memmove+0x28>
 55e:	fff6079b          	addiw	a5,a2,-1
 562:	1782                	slli	a5,a5,0x20
 564:	9381                	srli	a5,a5,0x20
 566:	fff7c793          	not	a5,a5
 56a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 56c:	15fd                	addi	a1,a1,-1
 56e:	177d                	addi	a4,a4,-1
 570:	0005c683          	lbu	a3,0(a1)
 574:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 578:	fee79ae3          	bne	a5,a4,56c <memmove+0x46>
 57c:	bfc9                	j	54e <memmove+0x28>

000000000000057e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 57e:	1141                	addi	sp,sp,-16
 580:	e422                	sd	s0,8(sp)
 582:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 584:	ca05                	beqz	a2,5b4 <memcmp+0x36>
 586:	fff6069b          	addiw	a3,a2,-1
 58a:	1682                	slli	a3,a3,0x20
 58c:	9281                	srli	a3,a3,0x20
 58e:	0685                	addi	a3,a3,1
 590:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 592:	00054783          	lbu	a5,0(a0)
 596:	0005c703          	lbu	a4,0(a1)
 59a:	00e79863          	bne	a5,a4,5aa <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 59e:	0505                	addi	a0,a0,1
        p2++;
 5a0:	0585                	addi	a1,a1,1
    while (n-- > 0)
 5a2:	fed518e3          	bne	a0,a3,592 <memcmp+0x14>
    }
    return 0;
 5a6:	4501                	li	a0,0
 5a8:	a019                	j	5ae <memcmp+0x30>
            return *p1 - *p2;
 5aa:	40e7853b          	subw	a0,a5,a4
}
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret
    return 0;
 5b4:	4501                	li	a0,0
 5b6:	bfe5                	j	5ae <memcmp+0x30>

00000000000005b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5b8:	1141                	addi	sp,sp,-16
 5ba:	e406                	sd	ra,8(sp)
 5bc:	e022                	sd	s0,0(sp)
 5be:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 5c0:	00000097          	auipc	ra,0x0
 5c4:	f66080e7          	jalr	-154(ra) # 526 <memmove>
}
 5c8:	60a2                	ld	ra,8(sp)
 5ca:	6402                	ld	s0,0(sp)
 5cc:	0141                	addi	sp,sp,16
 5ce:	8082                	ret

00000000000005d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5d0:	4885                	li	a7,1
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d8:	4889                	li	a7,2
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5e0:	488d                	li	a7,3
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e8:	4891                	li	a7,4
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <read>:
.global read
read:
 li a7, SYS_read
 5f0:	4895                	li	a7,5
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <write>:
.global write
write:
 li a7, SYS_write
 5f8:	48c1                	li	a7,16
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <close>:
.global close
close:
 li a7, SYS_close
 600:	48d5                	li	a7,21
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <kill>:
.global kill
kill:
 li a7, SYS_kill
 608:	4899                	li	a7,6
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <exec>:
.global exec
exec:
 li a7, SYS_exec
 610:	489d                	li	a7,7
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <open>:
.global open
open:
 li a7, SYS_open
 618:	48bd                	li	a7,15
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 620:	48c5                	li	a7,17
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 628:	48c9                	li	a7,18
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 630:	48a1                	li	a7,8
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <link>:
.global link
link:
 li a7, SYS_link
 638:	48cd                	li	a7,19
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 640:	48d1                	li	a7,20
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 648:	48a5                	li	a7,9
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <dup>:
.global dup
dup:
 li a7, SYS_dup
 650:	48a9                	li	a7,10
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 658:	48ad                	li	a7,11
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 660:	48b1                	li	a7,12
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 668:	48b5                	li	a7,13
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 670:	48b9                	li	a7,14
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <ps>:
.global ps
ps:
 li a7, SYS_ps
 678:	48d9                	li	a7,22
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 680:	48dd                	li	a7,23
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 688:	48e1                	li	a7,24
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 690:	1101                	addi	sp,sp,-32
 692:	ec06                	sd	ra,24(sp)
 694:	e822                	sd	s0,16(sp)
 696:	1000                	addi	s0,sp,32
 698:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 69c:	4605                	li	a2,1
 69e:	fef40593          	addi	a1,s0,-17
 6a2:	00000097          	auipc	ra,0x0
 6a6:	f56080e7          	jalr	-170(ra) # 5f8 <write>
}
 6aa:	60e2                	ld	ra,24(sp)
 6ac:	6442                	ld	s0,16(sp)
 6ae:	6105                	addi	sp,sp,32
 6b0:	8082                	ret

00000000000006b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b2:	7139                	addi	sp,sp,-64
 6b4:	fc06                	sd	ra,56(sp)
 6b6:	f822                	sd	s0,48(sp)
 6b8:	f426                	sd	s1,40(sp)
 6ba:	f04a                	sd	s2,32(sp)
 6bc:	ec4e                	sd	s3,24(sp)
 6be:	0080                	addi	s0,sp,64
 6c0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6c2:	c299                	beqz	a3,6c8 <printint+0x16>
 6c4:	0805c963          	bltz	a1,756 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c8:	2581                	sext.w	a1,a1
  neg = 0;
 6ca:	4881                	li	a7,0
 6cc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6d2:	2601                	sext.w	a2,a2
 6d4:	00000517          	auipc	a0,0x0
 6d8:	54450513          	addi	a0,a0,1348 # c18 <digits>
 6dc:	883a                	mv	a6,a4
 6de:	2705                	addiw	a4,a4,1
 6e0:	02c5f7bb          	remuw	a5,a1,a2
 6e4:	1782                	slli	a5,a5,0x20
 6e6:	9381                	srli	a5,a5,0x20
 6e8:	97aa                	add	a5,a5,a0
 6ea:	0007c783          	lbu	a5,0(a5)
 6ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6f2:	0005879b          	sext.w	a5,a1
 6f6:	02c5d5bb          	divuw	a1,a1,a2
 6fa:	0685                	addi	a3,a3,1
 6fc:	fec7f0e3          	bgeu	a5,a2,6dc <printint+0x2a>
  if(neg)
 700:	00088c63          	beqz	a7,718 <printint+0x66>
    buf[i++] = '-';
 704:	fd070793          	addi	a5,a4,-48
 708:	00878733          	add	a4,a5,s0
 70c:	02d00793          	li	a5,45
 710:	fef70823          	sb	a5,-16(a4)
 714:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 718:	02e05863          	blez	a4,748 <printint+0x96>
 71c:	fc040793          	addi	a5,s0,-64
 720:	00e78933          	add	s2,a5,a4
 724:	fff78993          	addi	s3,a5,-1
 728:	99ba                	add	s3,s3,a4
 72a:	377d                	addiw	a4,a4,-1
 72c:	1702                	slli	a4,a4,0x20
 72e:	9301                	srli	a4,a4,0x20
 730:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 734:	fff94583          	lbu	a1,-1(s2)
 738:	8526                	mv	a0,s1
 73a:	00000097          	auipc	ra,0x0
 73e:	f56080e7          	jalr	-170(ra) # 690 <putc>
  while(--i >= 0)
 742:	197d                	addi	s2,s2,-1
 744:	ff3918e3          	bne	s2,s3,734 <printint+0x82>
}
 748:	70e2                	ld	ra,56(sp)
 74a:	7442                	ld	s0,48(sp)
 74c:	74a2                	ld	s1,40(sp)
 74e:	7902                	ld	s2,32(sp)
 750:	69e2                	ld	s3,24(sp)
 752:	6121                	addi	sp,sp,64
 754:	8082                	ret
    x = -xx;
 756:	40b005bb          	negw	a1,a1
    neg = 1;
 75a:	4885                	li	a7,1
    x = -xx;
 75c:	bf85                	j	6cc <printint+0x1a>

000000000000075e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 75e:	715d                	addi	sp,sp,-80
 760:	e486                	sd	ra,72(sp)
 762:	e0a2                	sd	s0,64(sp)
 764:	fc26                	sd	s1,56(sp)
 766:	f84a                	sd	s2,48(sp)
 768:	f44e                	sd	s3,40(sp)
 76a:	f052                	sd	s4,32(sp)
 76c:	ec56                	sd	s5,24(sp)
 76e:	e85a                	sd	s6,16(sp)
 770:	e45e                	sd	s7,8(sp)
 772:	e062                	sd	s8,0(sp)
 774:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 776:	0005c903          	lbu	s2,0(a1)
 77a:	18090c63          	beqz	s2,912 <vprintf+0x1b4>
 77e:	8aaa                	mv	s5,a0
 780:	8bb2                	mv	s7,a2
 782:	00158493          	addi	s1,a1,1
  state = 0;
 786:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 788:	02500a13          	li	s4,37
 78c:	4b55                	li	s6,21
 78e:	a839                	j	7ac <vprintf+0x4e>
        putc(fd, c);
 790:	85ca                	mv	a1,s2
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	efc080e7          	jalr	-260(ra) # 690 <putc>
 79c:	a019                	j	7a2 <vprintf+0x44>
    } else if(state == '%'){
 79e:	01498d63          	beq	s3,s4,7b8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 7a2:	0485                	addi	s1,s1,1
 7a4:	fff4c903          	lbu	s2,-1(s1)
 7a8:	16090563          	beqz	s2,912 <vprintf+0x1b4>
    if(state == 0){
 7ac:	fe0999e3          	bnez	s3,79e <vprintf+0x40>
      if(c == '%'){
 7b0:	ff4910e3          	bne	s2,s4,790 <vprintf+0x32>
        state = '%';
 7b4:	89d2                	mv	s3,s4
 7b6:	b7f5                	j	7a2 <vprintf+0x44>
      if(c == 'd'){
 7b8:	13490263          	beq	s2,s4,8dc <vprintf+0x17e>
 7bc:	f9d9079b          	addiw	a5,s2,-99
 7c0:	0ff7f793          	zext.b	a5,a5
 7c4:	12fb6563          	bltu	s6,a5,8ee <vprintf+0x190>
 7c8:	f9d9079b          	addiw	a5,s2,-99
 7cc:	0ff7f713          	zext.b	a4,a5
 7d0:	10eb6f63          	bltu	s6,a4,8ee <vprintf+0x190>
 7d4:	00271793          	slli	a5,a4,0x2
 7d8:	00000717          	auipc	a4,0x0
 7dc:	3e870713          	addi	a4,a4,1000 # bc0 <malloc+0x1b0>
 7e0:	97ba                	add	a5,a5,a4
 7e2:	439c                	lw	a5,0(a5)
 7e4:	97ba                	add	a5,a5,a4
 7e6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7e8:	008b8913          	addi	s2,s7,8
 7ec:	4685                	li	a3,1
 7ee:	4629                	li	a2,10
 7f0:	000ba583          	lw	a1,0(s7)
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	ebc080e7          	jalr	-324(ra) # 6b2 <printint>
 7fe:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 800:	4981                	li	s3,0
 802:	b745                	j	7a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 804:	008b8913          	addi	s2,s7,8
 808:	4681                	li	a3,0
 80a:	4629                	li	a2,10
 80c:	000ba583          	lw	a1,0(s7)
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	ea0080e7          	jalr	-352(ra) # 6b2 <printint>
 81a:	8bca                	mv	s7,s2
      state = 0;
 81c:	4981                	li	s3,0
 81e:	b751                	j	7a2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 820:	008b8913          	addi	s2,s7,8
 824:	4681                	li	a3,0
 826:	4641                	li	a2,16
 828:	000ba583          	lw	a1,0(s7)
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	e84080e7          	jalr	-380(ra) # 6b2 <printint>
 836:	8bca                	mv	s7,s2
      state = 0;
 838:	4981                	li	s3,0
 83a:	b7a5                	j	7a2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 83c:	008b8c13          	addi	s8,s7,8
 840:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 844:	03000593          	li	a1,48
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	e46080e7          	jalr	-442(ra) # 690 <putc>
  putc(fd, 'x');
 852:	07800593          	li	a1,120
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e38080e7          	jalr	-456(ra) # 690 <putc>
 860:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 862:	00000b97          	auipc	s7,0x0
 866:	3b6b8b93          	addi	s7,s7,950 # c18 <digits>
 86a:	03c9d793          	srli	a5,s3,0x3c
 86e:	97de                	add	a5,a5,s7
 870:	0007c583          	lbu	a1,0(a5)
 874:	8556                	mv	a0,s5
 876:	00000097          	auipc	ra,0x0
 87a:	e1a080e7          	jalr	-486(ra) # 690 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87e:	0992                	slli	s3,s3,0x4
 880:	397d                	addiw	s2,s2,-1
 882:	fe0914e3          	bnez	s2,86a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 886:	8be2                	mv	s7,s8
      state = 0;
 888:	4981                	li	s3,0
 88a:	bf21                	j	7a2 <vprintf+0x44>
        s = va_arg(ap, char*);
 88c:	008b8993          	addi	s3,s7,8
 890:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 894:	02090163          	beqz	s2,8b6 <vprintf+0x158>
        while(*s != 0){
 898:	00094583          	lbu	a1,0(s2)
 89c:	c9a5                	beqz	a1,90c <vprintf+0x1ae>
          putc(fd, *s);
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	df0080e7          	jalr	-528(ra) # 690 <putc>
          s++;
 8a8:	0905                	addi	s2,s2,1
        while(*s != 0){
 8aa:	00094583          	lbu	a1,0(s2)
 8ae:	f9e5                	bnez	a1,89e <vprintf+0x140>
        s = va_arg(ap, char*);
 8b0:	8bce                	mv	s7,s3
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	b5fd                	j	7a2 <vprintf+0x44>
          s = "(null)";
 8b6:	00000917          	auipc	s2,0x0
 8ba:	30290913          	addi	s2,s2,770 # bb8 <malloc+0x1a8>
        while(*s != 0){
 8be:	02800593          	li	a1,40
 8c2:	bff1                	j	89e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 8c4:	008b8913          	addi	s2,s7,8
 8c8:	000bc583          	lbu	a1,0(s7)
 8cc:	8556                	mv	a0,s5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	dc2080e7          	jalr	-574(ra) # 690 <putc>
 8d6:	8bca                	mv	s7,s2
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	b5e1                	j	7a2 <vprintf+0x44>
        putc(fd, c);
 8dc:	02500593          	li	a1,37
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	dae080e7          	jalr	-594(ra) # 690 <putc>
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	bd5d                	j	7a2 <vprintf+0x44>
        putc(fd, '%');
 8ee:	02500593          	li	a1,37
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	d9c080e7          	jalr	-612(ra) # 690 <putc>
        putc(fd, c);
 8fc:	85ca                	mv	a1,s2
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	d90080e7          	jalr	-624(ra) # 690 <putc>
      state = 0;
 908:	4981                	li	s3,0
 90a:	bd61                	j	7a2 <vprintf+0x44>
        s = va_arg(ap, char*);
 90c:	8bce                	mv	s7,s3
      state = 0;
 90e:	4981                	li	s3,0
 910:	bd49                	j	7a2 <vprintf+0x44>
    }
  }
}
 912:	60a6                	ld	ra,72(sp)
 914:	6406                	ld	s0,64(sp)
 916:	74e2                	ld	s1,56(sp)
 918:	7942                	ld	s2,48(sp)
 91a:	79a2                	ld	s3,40(sp)
 91c:	7a02                	ld	s4,32(sp)
 91e:	6ae2                	ld	s5,24(sp)
 920:	6b42                	ld	s6,16(sp)
 922:	6ba2                	ld	s7,8(sp)
 924:	6c02                	ld	s8,0(sp)
 926:	6161                	addi	sp,sp,80
 928:	8082                	ret

000000000000092a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 92a:	715d                	addi	sp,sp,-80
 92c:	ec06                	sd	ra,24(sp)
 92e:	e822                	sd	s0,16(sp)
 930:	1000                	addi	s0,sp,32
 932:	e010                	sd	a2,0(s0)
 934:	e414                	sd	a3,8(s0)
 936:	e818                	sd	a4,16(s0)
 938:	ec1c                	sd	a5,24(s0)
 93a:	03043023          	sd	a6,32(s0)
 93e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 942:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 946:	8622                	mv	a2,s0
 948:	00000097          	auipc	ra,0x0
 94c:	e16080e7          	jalr	-490(ra) # 75e <vprintf>
}
 950:	60e2                	ld	ra,24(sp)
 952:	6442                	ld	s0,16(sp)
 954:	6161                	addi	sp,sp,80
 956:	8082                	ret

0000000000000958 <printf>:

void
printf(const char *fmt, ...)
{
 958:	711d                	addi	sp,sp,-96
 95a:	ec06                	sd	ra,24(sp)
 95c:	e822                	sd	s0,16(sp)
 95e:	1000                	addi	s0,sp,32
 960:	e40c                	sd	a1,8(s0)
 962:	e810                	sd	a2,16(s0)
 964:	ec14                	sd	a3,24(s0)
 966:	f018                	sd	a4,32(s0)
 968:	f41c                	sd	a5,40(s0)
 96a:	03043823          	sd	a6,48(s0)
 96e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 972:	00840613          	addi	a2,s0,8
 976:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 97a:	85aa                	mv	a1,a0
 97c:	4505                	li	a0,1
 97e:	00000097          	auipc	ra,0x0
 982:	de0080e7          	jalr	-544(ra) # 75e <vprintf>
}
 986:	60e2                	ld	ra,24(sp)
 988:	6442                	ld	s0,16(sp)
 98a:	6125                	addi	sp,sp,96
 98c:	8082                	ret

000000000000098e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 98e:	1141                	addi	sp,sp,-16
 990:	e422                	sd	s0,8(sp)
 992:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 994:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 998:	00000797          	auipc	a5,0x0
 99c:	2a07b783          	ld	a5,672(a5) # c38 <freep>
 9a0:	a02d                	j	9ca <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 9a2:	4618                	lw	a4,8(a2)
 9a4:	9f2d                	addw	a4,a4,a1
 9a6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 9aa:	6398                	ld	a4,0(a5)
 9ac:	6310                	ld	a2,0(a4)
 9ae:	a83d                	j	9ec <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 9b0:	ff852703          	lw	a4,-8(a0)
 9b4:	9f31                	addw	a4,a4,a2
 9b6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 9b8:	ff053683          	ld	a3,-16(a0)
 9bc:	a091                	j	a00 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9be:	6398                	ld	a4,0(a5)
 9c0:	00e7e463          	bltu	a5,a4,9c8 <free+0x3a>
 9c4:	00e6ea63          	bltu	a3,a4,9d8 <free+0x4a>
{
 9c8:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ca:	fed7fae3          	bgeu	a5,a3,9be <free+0x30>
 9ce:	6398                	ld	a4,0(a5)
 9d0:	00e6e463          	bltu	a3,a4,9d8 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d4:	fee7eae3          	bltu	a5,a4,9c8 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 9d8:	ff852583          	lw	a1,-8(a0)
 9dc:	6390                	ld	a2,0(a5)
 9de:	02059813          	slli	a6,a1,0x20
 9e2:	01c85713          	srli	a4,a6,0x1c
 9e6:	9736                	add	a4,a4,a3
 9e8:	fae60de3          	beq	a2,a4,9a2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9ec:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 9f0:	4790                	lw	a2,8(a5)
 9f2:	02061593          	slli	a1,a2,0x20
 9f6:	01c5d713          	srli	a4,a1,0x1c
 9fa:	973e                	add	a4,a4,a5
 9fc:	fae68ae3          	beq	a3,a4,9b0 <free+0x22>
        p->s.ptr = bp->s.ptr;
 a00:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 a02:	00000717          	auipc	a4,0x0
 a06:	22f73b23          	sd	a5,566(a4) # c38 <freep>
}
 a0a:	6422                	ld	s0,8(sp)
 a0c:	0141                	addi	sp,sp,16
 a0e:	8082                	ret

0000000000000a10 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 a10:	7139                	addi	sp,sp,-64
 a12:	fc06                	sd	ra,56(sp)
 a14:	f822                	sd	s0,48(sp)
 a16:	f426                	sd	s1,40(sp)
 a18:	f04a                	sd	s2,32(sp)
 a1a:	ec4e                	sd	s3,24(sp)
 a1c:	e852                	sd	s4,16(sp)
 a1e:	e456                	sd	s5,8(sp)
 a20:	e05a                	sd	s6,0(sp)
 a22:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 a24:	02051493          	slli	s1,a0,0x20
 a28:	9081                	srli	s1,s1,0x20
 a2a:	04bd                	addi	s1,s1,15
 a2c:	8091                	srli	s1,s1,0x4
 a2e:	0014899b          	addiw	s3,s1,1
 a32:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 a34:	00000517          	auipc	a0,0x0
 a38:	20453503          	ld	a0,516(a0) # c38 <freep>
 a3c:	c515                	beqz	a0,a68 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a3e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 a40:	4798                	lw	a4,8(a5)
 a42:	02977f63          	bgeu	a4,s1,a80 <malloc+0x70>
    if (nu < 4096)
 a46:	8a4e                	mv	s4,s3
 a48:	0009871b          	sext.w	a4,s3
 a4c:	6685                	lui	a3,0x1
 a4e:	00d77363          	bgeu	a4,a3,a54 <malloc+0x44>
 a52:	6a05                	lui	s4,0x1
 a54:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a58:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a5c:	00000917          	auipc	s2,0x0
 a60:	1dc90913          	addi	s2,s2,476 # c38 <freep>
    if (p == (char *)-1)
 a64:	5afd                	li	s5,-1
 a66:	a895                	j	ada <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 a68:	00000797          	auipc	a5,0x0
 a6c:	1d878793          	addi	a5,a5,472 # c40 <base>
 a70:	00000717          	auipc	a4,0x0
 a74:	1cf73423          	sd	a5,456(a4) # c38 <freep>
 a78:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a7a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a7e:	b7e1                	j	a46 <malloc+0x36>
            if (p->s.size == nunits)
 a80:	02e48c63          	beq	s1,a4,ab8 <malloc+0xa8>
                p->s.size -= nunits;
 a84:	4137073b          	subw	a4,a4,s3
 a88:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a8a:	02071693          	slli	a3,a4,0x20
 a8e:	01c6d713          	srli	a4,a3,0x1c
 a92:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a94:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a98:	00000717          	auipc	a4,0x0
 a9c:	1aa73023          	sd	a0,416(a4) # c38 <freep>
            return (void *)(p + 1);
 aa0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 aa4:	70e2                	ld	ra,56(sp)
 aa6:	7442                	ld	s0,48(sp)
 aa8:	74a2                	ld	s1,40(sp)
 aaa:	7902                	ld	s2,32(sp)
 aac:	69e2                	ld	s3,24(sp)
 aae:	6a42                	ld	s4,16(sp)
 ab0:	6aa2                	ld	s5,8(sp)
 ab2:	6b02                	ld	s6,0(sp)
 ab4:	6121                	addi	sp,sp,64
 ab6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 ab8:	6398                	ld	a4,0(a5)
 aba:	e118                	sd	a4,0(a0)
 abc:	bff1                	j	a98 <malloc+0x88>
    hp->s.size = nu;
 abe:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 ac2:	0541                	addi	a0,a0,16
 ac4:	00000097          	auipc	ra,0x0
 ac8:	eca080e7          	jalr	-310(ra) # 98e <free>
    return freep;
 acc:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 ad0:	d971                	beqz	a0,aa4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ad2:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ad4:	4798                	lw	a4,8(a5)
 ad6:	fa9775e3          	bgeu	a4,s1,a80 <malloc+0x70>
        if (p == freep)
 ada:	00093703          	ld	a4,0(s2)
 ade:	853e                	mv	a0,a5
 ae0:	fef719e3          	bne	a4,a5,ad2 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ae4:	8552                	mv	a0,s4
 ae6:	00000097          	auipc	ra,0x0
 aea:	b7a080e7          	jalr	-1158(ra) # 660 <sbrk>
    if (p == (char *)-1)
 aee:	fd5518e3          	bne	a0,s5,abe <malloc+0xae>
                return 0;
 af2:	4501                	li	a0,0
 af4:	bf45                	j	aa4 <malloc+0x94>
