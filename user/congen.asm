
user/_congen:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:
#include "user/user.h"

#define N 5

void print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
    write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	4fc080e7          	jalr	1276(ra) # 508 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	730080e7          	jalr	1840(ra) # 74c <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void forktest(void)
{
  2e:	7139                	addi	sp,sp,-64
  30:	fc06                	sd	ra,56(sp)
  32:	f822                	sd	s0,48(sp)
  34:	f426                	sd	s1,40(sp)
  36:	f04a                	sd	s2,32(sp)
  38:	ec4e                	sd	s3,24(sp)
  3a:	e852                	sd	s4,16(sp)
  3c:	e456                	sd	s5,8(sp)
  3e:	e05a                	sd	s6,0(sp)
  40:	0080                	addi	s0,sp,64
    int n, pid;

    print("fork test\n");
  42:	00001517          	auipc	a0,0x1
  46:	c0e50513          	addi	a0,a0,-1010 # c50 <malloc+0xec>
  4a:	00000097          	auipc	ra,0x0
  4e:	fb6080e7          	jalr	-74(ra) # 0 <print>

    for (n = 0; n < N; n++)
  52:	4a01                	li	s4,0
  54:	4495                	li	s1,5
    {
        pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	6ce080e7          	jalr	1742(ra) # 724 <fork>
  5e:	892a                	mv	s2,a0
        if (pid < 0)
            break;
        if (pid == 0)
  60:	00a05563          	blez	a0,6a <forktest+0x3c>
    for (n = 0; n < N; n++)
  64:	2a05                	addiw	s4,s4,1
  66:	fe9a18e3          	bne	s4,s1,56 <forktest+0x28>
            break;
    }

    for (unsigned long long i = 0; i < 1000; i++)
  6a:	4481                	li	s1,0
        {
            printf("CHILD %d: %d\n", n, i);
        }
        else
        {
            printf("PARENT: %d\n", i);
  6c:	00001b17          	auipc	s6,0x1
  70:	c04b0b13          	addi	s6,s6,-1020 # c70 <malloc+0x10c>
            printf("CHILD %d: %d\n", n, i);
  74:	00001a97          	auipc	s5,0x1
  78:	beca8a93          	addi	s5,s5,-1044 # c60 <malloc+0xfc>
    for (unsigned long long i = 0; i < 1000; i++)
  7c:	3e800993          	li	s3,1000
  80:	a811                	j	94 <forktest+0x66>
            printf("PARENT: %d\n", i);
  82:	85a6                	mv	a1,s1
  84:	855a                	mv	a0,s6
  86:	00001097          	auipc	ra,0x1
  8a:	a26080e7          	jalr	-1498(ra) # aac <printf>
    for (unsigned long long i = 0; i < 1000; i++)
  8e:	0485                	addi	s1,s1,1
  90:	01348c63          	beq	s1,s3,a8 <forktest+0x7a>
        if (pid == 0)
  94:	fe0917e3          	bnez	s2,82 <forktest+0x54>
            printf("CHILD %d: %d\n", n, i);
  98:	8626                	mv	a2,s1
  9a:	85d2                	mv	a1,s4
  9c:	8556                	mv	a0,s5
  9e:	00001097          	auipc	ra,0x1
  a2:	a0e080e7          	jalr	-1522(ra) # aac <printf>
  a6:	b7e5                	j	8e <forktest+0x60>
        }
    }

    print("fork test OK\n");
  a8:	00001517          	auipc	a0,0x1
  ac:	bd850513          	addi	a0,a0,-1064 # c80 <malloc+0x11c>
  b0:	00000097          	auipc	ra,0x0
  b4:	f50080e7          	jalr	-176(ra) # 0 <print>
}
  b8:	70e2                	ld	ra,56(sp)
  ba:	7442                	ld	s0,48(sp)
  bc:	74a2                	ld	s1,40(sp)
  be:	7902                	ld	s2,32(sp)
  c0:	69e2                	ld	s3,24(sp)
  c2:	6a42                	ld	s4,16(sp)
  c4:	6aa2                	ld	s5,8(sp)
  c6:	6b02                	ld	s6,0(sp)
  c8:	6121                	addi	sp,sp,64
  ca:	8082                	ret

00000000000000cc <main>:

int main(void)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	addi	s0,sp,16
    forktest();
  d4:	00000097          	auipc	ra,0x0
  d8:	f5a080e7          	jalr	-166(ra) # 2e <forktest>
    exit(0);
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	64e080e7          	jalr	1614(ra) # 72c <exit>

00000000000000e6 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
    lk->name = name;
  ec:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  ee:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  f2:	57fd                	li	a5,-1
  f4:	00f50823          	sb	a5,16(a0)
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	addi	sp,sp,16
  fc:	8082                	ret

00000000000000fe <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  fe:	00054783          	lbu	a5,0(a0)
 102:	e399                	bnez	a5,108 <holding+0xa>
 104:	4501                	li	a0,0
}
 106:	8082                	ret
{
 108:	1101                	addi	sp,sp,-32
 10a:	ec06                	sd	ra,24(sp)
 10c:	e822                	sd	s0,16(sp)
 10e:	e426                	sd	s1,8(sp)
 110:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 112:	01054483          	lbu	s1,16(a0)
 116:	00000097          	auipc	ra,0x0
 11a:	2c4080e7          	jalr	708(ra) # 3da <twhoami>
 11e:	2501                	sext.w	a0,a0
 120:	40a48533          	sub	a0,s1,a0
 124:	00153513          	seqz	a0,a0
}
 128:	60e2                	ld	ra,24(sp)
 12a:	6442                	ld	s0,16(sp)
 12c:	64a2                	ld	s1,8(sp)
 12e:	6105                	addi	sp,sp,32
 130:	8082                	ret

0000000000000132 <acquire>:

void acquire(struct lock *lk)
{
 132:	7179                	addi	sp,sp,-48
 134:	f406                	sd	ra,40(sp)
 136:	f022                	sd	s0,32(sp)
 138:	ec26                	sd	s1,24(sp)
 13a:	e84a                	sd	s2,16(sp)
 13c:	e44e                	sd	s3,8(sp)
 13e:	e052                	sd	s4,0(sp)
 140:	1800                	addi	s0,sp,48
 142:	8a2a                	mv	s4,a0
    if (holding(lk))
 144:	00000097          	auipc	ra,0x0
 148:	fba080e7          	jalr	-70(ra) # fe <holding>
 14c:	e919                	bnez	a0,162 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 14e:	ffca7493          	andi	s1,s4,-4
 152:	003a7913          	andi	s2,s4,3
 156:	0039191b          	slliw	s2,s2,0x3
 15a:	4985                	li	s3,1
 15c:	012999bb          	sllw	s3,s3,s2
 160:	a015                	j	184 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 162:	00001517          	auipc	a0,0x1
 166:	b2e50513          	addi	a0,a0,-1234 # c90 <malloc+0x12c>
 16a:	00001097          	auipc	ra,0x1
 16e:	942080e7          	jalr	-1726(ra) # aac <printf>
        exit(-1);
 172:	557d                	li	a0,-1
 174:	00000097          	auipc	ra,0x0
 178:	5b8080e7          	jalr	1464(ra) # 72c <exit>
    {
        // give up the cpu for other threads
        tyield();
 17c:	00000097          	auipc	ra,0x0
 180:	1dc080e7          	jalr	476(ra) # 358 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 184:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 188:	0127d7bb          	srlw	a5,a5,s2
 18c:	0ff7f793          	zext.b	a5,a5
 190:	f7f5                	bnez	a5,17c <acquire+0x4a>
    }

    __sync_synchronize();
 192:	0ff0000f          	fence

    lk->tid = twhoami();
 196:	00000097          	auipc	ra,0x0
 19a:	244080e7          	jalr	580(ra) # 3da <twhoami>
 19e:	00aa0823          	sb	a0,16(s4)
}
 1a2:	70a2                	ld	ra,40(sp)
 1a4:	7402                	ld	s0,32(sp)
 1a6:	64e2                	ld	s1,24(sp)
 1a8:	6942                	ld	s2,16(sp)
 1aa:	69a2                	ld	s3,8(sp)
 1ac:	6a02                	ld	s4,0(sp)
 1ae:	6145                	addi	sp,sp,48
 1b0:	8082                	ret

00000000000001b2 <release>:

void release(struct lock *lk)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e426                	sd	s1,8(sp)
 1ba:	1000                	addi	s0,sp,32
 1bc:	84aa                	mv	s1,a0
    if (!holding(lk))
 1be:	00000097          	auipc	ra,0x0
 1c2:	f40080e7          	jalr	-192(ra) # fe <holding>
 1c6:	c11d                	beqz	a0,1ec <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1c8:	57fd                	li	a5,-1
 1ca:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1ce:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1d2:	0ff0000f          	fence
 1d6:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1da:	00000097          	auipc	ra,0x0
 1de:	17e080e7          	jalr	382(ra) # 358 <tyield>
}
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	64a2                	ld	s1,8(sp)
 1e8:	6105                	addi	sp,sp,32
 1ea:	8082                	ret
        printf("releasing lock we are not holding");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	acc50513          	addi	a0,a0,-1332 # cb8 <malloc+0x154>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	8b8080e7          	jalr	-1864(ra) # aac <printf>
        exit(-1);
 1fc:	557d                	li	a0,-1
 1fe:	00000097          	auipc	ra,0x0
 202:	52e080e7          	jalr	1326(ra) # 72c <exit>

0000000000000206 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 206:	00001517          	auipc	a0,0x1
 20a:	e0a53503          	ld	a0,-502(a0) # 1010 <current_thread>
 20e:	00001717          	auipc	a4,0x1
 212:	e1270713          	addi	a4,a4,-494 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 216:	4781                	li	a5,0
 218:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 21a:	6314                	ld	a3,0(a4)
 21c:	00a68763          	beq	a3,a0,22a <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 220:	2785                	addiw	a5,a5,1
 222:	0721                	addi	a4,a4,8
 224:	fec79be3          	bne	a5,a2,21a <tsched+0x14>
    int current_index = 0;
 228:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 22a:	0017869b          	addiw	a3,a5,1
 22e:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 232:	00001817          	auipc	a6,0x1
 236:	dee80813          	addi	a6,a6,-530 # 1020 <threads>
 23a:	488d                	li	a7,3
 23c:	a021                	j	244 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 23e:	2685                	addiw	a3,a3,1
 240:	04c68363          	beq	a3,a2,286 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 244:	41f6d71b          	sraiw	a4,a3,0x1f
 248:	01c7571b          	srliw	a4,a4,0x1c
 24c:	00d707bb          	addw	a5,a4,a3
 250:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 252:	9f99                	subw	a5,a5,a4
 254:	078e                	slli	a5,a5,0x3
 256:	97c2                	add	a5,a5,a6
 258:	638c                	ld	a1,0(a5)
 25a:	d1f5                	beqz	a1,23e <tsched+0x38>
 25c:	5dbc                	lw	a5,120(a1)
 25e:	ff1790e3          	bne	a5,a7,23e <tsched+0x38>
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 26a:	00001797          	auipc	a5,0x1
 26e:	dab7b323          	sd	a1,-602(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 272:	05a1                	addi	a1,a1,8
 274:	0521                	addi	a0,a0,8
 276:	00000097          	auipc	ra,0x0
 27a:	17c080e7          	jalr	380(ra) # 3f2 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 27e:	60a2                	ld	ra,8(sp)
 280:	6402                	ld	s0,0(sp)
 282:	0141                	addi	sp,sp,16
 284:	8082                	ret
 286:	8082                	ret

0000000000000288 <thread_wrapper>:
{
 288:	1101                	addi	sp,sp,-32
 28a:	ec06                	sd	ra,24(sp)
 28c:	e822                	sd	s0,16(sp)
 28e:	e426                	sd	s1,8(sp)
 290:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 292:	00001497          	auipc	s1,0x1
 296:	d7e48493          	addi	s1,s1,-642 # 1010 <current_thread>
 29a:	609c                	ld	a5,0(s1)
 29c:	67d8                	ld	a4,136(a5)
 29e:	63c8                	ld	a0,128(a5)
 2a0:	9702                	jalr	a4
    current_thread->state = EXITED;
 2a2:	609c                	ld	a5,0(s1)
 2a4:	4719                	li	a4,6
 2a6:	dfb8                	sw	a4,120(a5)
    tsched();
 2a8:	00000097          	auipc	ra,0x0
 2ac:	f5e080e7          	jalr	-162(ra) # 206 <tsched>
}
 2b0:	60e2                	ld	ra,24(sp)
 2b2:	6442                	ld	s0,16(sp)
 2b4:	64a2                	ld	s1,8(sp)
 2b6:	6105                	addi	sp,sp,32
 2b8:	8082                	ret

00000000000002ba <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2ba:	7179                	addi	sp,sp,-48
 2bc:	f406                	sd	ra,40(sp)
 2be:	f022                	sd	s0,32(sp)
 2c0:	ec26                	sd	s1,24(sp)
 2c2:	e84a                	sd	s2,16(sp)
 2c4:	e44e                	sd	s3,8(sp)
 2c6:	1800                	addi	s0,sp,48
 2c8:	84aa                	mv	s1,a0
 2ca:	89b2                	mv	s3,a2
 2cc:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2ce:	09800513          	li	a0,152
 2d2:	00001097          	auipc	ra,0x1
 2d6:	892080e7          	jalr	-1902(ra) # b64 <malloc>
 2da:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2dc:	478d                	li	a5,3
 2de:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2e0:	609c                	ld	a5,0(s1)
 2e2:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2e6:	609c                	ld	a5,0(s1)
 2e8:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 2ec:	6098                	ld	a4,0(s1)
 2ee:	00001797          	auipc	a5,0x1
 2f2:	d1278793          	addi	a5,a5,-750 # 1000 <next_tid>
 2f6:	4394                	lw	a3,0(a5)
 2f8:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2fc:	4398                	lw	a4,0(a5)
 2fe:	2705                	addiw	a4,a4,1
 300:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 302:	6505                	lui	a0,0x1
 304:	00001097          	auipc	ra,0x1
 308:	860080e7          	jalr	-1952(ra) # b64 <malloc>
 30c:	609c                	ld	a5,0(s1)
 30e:	6705                	lui	a4,0x1
 310:	953a                	add	a0,a0,a4
 312:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 314:	609c                	ld	a5,0(s1)
 316:	00000717          	auipc	a4,0x0
 31a:	f7270713          	addi	a4,a4,-142 # 288 <thread_wrapper>
 31e:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 320:	00001717          	auipc	a4,0x1
 324:	d0070713          	addi	a4,a4,-768 # 1020 <threads>
 328:	4781                	li	a5,0
 32a:	4641                	li	a2,16
        if (threads[i] == NULL) {
 32c:	6314                	ld	a3,0(a4)
 32e:	ce81                	beqz	a3,346 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 330:	2785                	addiw	a5,a5,1
 332:	0721                	addi	a4,a4,8
 334:	fec79ce3          	bne	a5,a2,32c <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 338:	70a2                	ld	ra,40(sp)
 33a:	7402                	ld	s0,32(sp)
 33c:	64e2                	ld	s1,24(sp)
 33e:	6942                	ld	s2,16(sp)
 340:	69a2                	ld	s3,8(sp)
 342:	6145                	addi	sp,sp,48
 344:	8082                	ret
            threads[i] = *thread;
 346:	6094                	ld	a3,0(s1)
 348:	078e                	slli	a5,a5,0x3
 34a:	00001717          	auipc	a4,0x1
 34e:	cd670713          	addi	a4,a4,-810 # 1020 <threads>
 352:	97ba                	add	a5,a5,a4
 354:	e394                	sd	a3,0(a5)
            break;
 356:	b7cd                	j	338 <tcreate+0x7e>

0000000000000358 <tyield>:
    return 0;
}


void tyield()
{
 358:	1141                	addi	sp,sp,-16
 35a:	e406                	sd	ra,8(sp)
 35c:	e022                	sd	s0,0(sp)
 35e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 360:	00001797          	auipc	a5,0x1
 364:	cb07b783          	ld	a5,-848(a5) # 1010 <current_thread>
 368:	470d                	li	a4,3
 36a:	dfb8                	sw	a4,120(a5)
    tsched();
 36c:	00000097          	auipc	ra,0x0
 370:	e9a080e7          	jalr	-358(ra) # 206 <tsched>
}
 374:	60a2                	ld	ra,8(sp)
 376:	6402                	ld	s0,0(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <tjoin>:
{
 37c:	1101                	addi	sp,sp,-32
 37e:	ec06                	sd	ra,24(sp)
 380:	e822                	sd	s0,16(sp)
 382:	e426                	sd	s1,8(sp)
 384:	e04a                	sd	s2,0(sp)
 386:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 388:	00001797          	auipc	a5,0x1
 38c:	c9878793          	addi	a5,a5,-872 # 1020 <threads>
 390:	00001697          	auipc	a3,0x1
 394:	d1068693          	addi	a3,a3,-752 # 10a0 <base>
 398:	a021                	j	3a0 <tjoin+0x24>
 39a:	07a1                	addi	a5,a5,8
 39c:	02d78b63          	beq	a5,a3,3d2 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3a0:	6384                	ld	s1,0(a5)
 3a2:	dce5                	beqz	s1,39a <tjoin+0x1e>
 3a4:	0004c703          	lbu	a4,0(s1)
 3a8:	fea719e3          	bne	a4,a0,39a <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3ac:	5cb8                	lw	a4,120(s1)
 3ae:	4799                	li	a5,6
 3b0:	4919                	li	s2,6
 3b2:	02f70263          	beq	a4,a5,3d6 <tjoin+0x5a>
        tyield();
 3b6:	00000097          	auipc	ra,0x0
 3ba:	fa2080e7          	jalr	-94(ra) # 358 <tyield>
    while (target_thread->state != EXITED) {
 3be:	5cbc                	lw	a5,120(s1)
 3c0:	ff279be3          	bne	a5,s2,3b6 <tjoin+0x3a>
    return 0;
 3c4:	4501                	li	a0,0
}
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	64a2                	ld	s1,8(sp)
 3cc:	6902                	ld	s2,0(sp)
 3ce:	6105                	addi	sp,sp,32
 3d0:	8082                	ret
        return -1;
 3d2:	557d                	li	a0,-1
 3d4:	bfcd                	j	3c6 <tjoin+0x4a>
    return 0;
 3d6:	4501                	li	a0,0
 3d8:	b7fd                	j	3c6 <tjoin+0x4a>

00000000000003da <twhoami>:

uint8 twhoami()
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3e0:	00001797          	auipc	a5,0x1
 3e4:	c307b783          	ld	a5,-976(a5) # 1010 <current_thread>
 3e8:	0007c503          	lbu	a0,0(a5)
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <tswtch>:
 3f2:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 3f6:	00253423          	sd	sp,8(a0)
 3fa:	e900                	sd	s0,16(a0)
 3fc:	ed04                	sd	s1,24(a0)
 3fe:	03253023          	sd	s2,32(a0)
 402:	03353423          	sd	s3,40(a0)
 406:	03453823          	sd	s4,48(a0)
 40a:	03553c23          	sd	s5,56(a0)
 40e:	05653023          	sd	s6,64(a0)
 412:	05753423          	sd	s7,72(a0)
 416:	05853823          	sd	s8,80(a0)
 41a:	05953c23          	sd	s9,88(a0)
 41e:	07a53023          	sd	s10,96(a0)
 422:	07b53423          	sd	s11,104(a0)
 426:	0005b083          	ld	ra,0(a1)
 42a:	0085b103          	ld	sp,8(a1)
 42e:	6980                	ld	s0,16(a1)
 430:	6d84                	ld	s1,24(a1)
 432:	0205b903          	ld	s2,32(a1)
 436:	0285b983          	ld	s3,40(a1)
 43a:	0305ba03          	ld	s4,48(a1)
 43e:	0385ba83          	ld	s5,56(a1)
 442:	0405bb03          	ld	s6,64(a1)
 446:	0485bb83          	ld	s7,72(a1)
 44a:	0505bc03          	ld	s8,80(a1)
 44e:	0585bc83          	ld	s9,88(a1)
 452:	0605bd03          	ld	s10,96(a1)
 456:	0685bd83          	ld	s11,104(a1)
 45a:	8082                	ret

000000000000045c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 45c:	1101                	addi	sp,sp,-32
 45e:	ec06                	sd	ra,24(sp)
 460:	e822                	sd	s0,16(sp)
 462:	e426                	sd	s1,8(sp)
 464:	e04a                	sd	s2,0(sp)
 466:	1000                	addi	s0,sp,32
 468:	84aa                	mv	s1,a0
 46a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 46c:	09800513          	li	a0,152
 470:	00000097          	auipc	ra,0x0
 474:	6f4080e7          	jalr	1780(ra) # b64 <malloc>

    main_thread->tid = 1;
 478:	4785                	li	a5,1
 47a:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 47e:	4791                	li	a5,4
 480:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 482:	00001797          	auipc	a5,0x1
 486:	b8a7b723          	sd	a0,-1138(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 48a:	00001797          	auipc	a5,0x1
 48e:	b9678793          	addi	a5,a5,-1130 # 1020 <threads>
 492:	00001717          	auipc	a4,0x1
 496:	c0e70713          	addi	a4,a4,-1010 # 10a0 <base>
        threads[i] = NULL;
 49a:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 49e:	07a1                	addi	a5,a5,8
 4a0:	fee79de3          	bne	a5,a4,49a <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4a4:	00001797          	auipc	a5,0x1
 4a8:	b6a7be23          	sd	a0,-1156(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4ac:	85ca                	mv	a1,s2
 4ae:	8526                	mv	a0,s1
 4b0:	00000097          	auipc	ra,0x0
 4b4:	c1c080e7          	jalr	-996(ra) # cc <main>
    //tsched();

    exit(res);
 4b8:	00000097          	auipc	ra,0x0
 4bc:	274080e7          	jalr	628(ra) # 72c <exit>

00000000000004c0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4c6:	87aa                	mv	a5,a0
 4c8:	0585                	addi	a1,a1,1
 4ca:	0785                	addi	a5,a5,1
 4cc:	fff5c703          	lbu	a4,-1(a1)
 4d0:	fee78fa3          	sb	a4,-1(a5)
 4d4:	fb75                	bnez	a4,4c8 <strcpy+0x8>
        ;
    return os;
}
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <strcmp>:

int strcmp(const char *p, const char *q)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	cb91                	beqz	a5,4fa <strcmp+0x1e>
 4e8:	0005c703          	lbu	a4,0(a1)
 4ec:	00f71763          	bne	a4,a5,4fa <strcmp+0x1e>
        p++, q++;
 4f0:	0505                	addi	a0,a0,1
 4f2:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4f4:	00054783          	lbu	a5,0(a0)
 4f8:	fbe5                	bnez	a5,4e8 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4fa:	0005c503          	lbu	a0,0(a1)
}
 4fe:	40a7853b          	subw	a0,a5,a0
 502:	6422                	ld	s0,8(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret

0000000000000508 <strlen>:

uint strlen(const char *s)
{
 508:	1141                	addi	sp,sp,-16
 50a:	e422                	sd	s0,8(sp)
 50c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 50e:	00054783          	lbu	a5,0(a0)
 512:	cf91                	beqz	a5,52e <strlen+0x26>
 514:	0505                	addi	a0,a0,1
 516:	87aa                	mv	a5,a0
 518:	86be                	mv	a3,a5
 51a:	0785                	addi	a5,a5,1
 51c:	fff7c703          	lbu	a4,-1(a5)
 520:	ff65                	bnez	a4,518 <strlen+0x10>
 522:	40a6853b          	subw	a0,a3,a0
 526:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
    for (n = 0; s[n]; n++)
 52e:	4501                	li	a0,0
 530:	bfe5                	j	528 <strlen+0x20>

0000000000000532 <memset>:

void *
memset(void *dst, int c, uint n)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 538:	ca19                	beqz	a2,54e <memset+0x1c>
 53a:	87aa                	mv	a5,a0
 53c:	1602                	slli	a2,a2,0x20
 53e:	9201                	srli	a2,a2,0x20
 540:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 544:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 548:	0785                	addi	a5,a5,1
 54a:	fee79de3          	bne	a5,a4,544 <memset+0x12>
    }
    return dst;
}
 54e:	6422                	ld	s0,8(sp)
 550:	0141                	addi	sp,sp,16
 552:	8082                	ret

0000000000000554 <strchr>:

char *
strchr(const char *s, char c)
{
 554:	1141                	addi	sp,sp,-16
 556:	e422                	sd	s0,8(sp)
 558:	0800                	addi	s0,sp,16
    for (; *s; s++)
 55a:	00054783          	lbu	a5,0(a0)
 55e:	cb99                	beqz	a5,574 <strchr+0x20>
        if (*s == c)
 560:	00f58763          	beq	a1,a5,56e <strchr+0x1a>
    for (; *s; s++)
 564:	0505                	addi	a0,a0,1
 566:	00054783          	lbu	a5,0(a0)
 56a:	fbfd                	bnez	a5,560 <strchr+0xc>
            return (char *)s;
    return 0;
 56c:	4501                	li	a0,0
}
 56e:	6422                	ld	s0,8(sp)
 570:	0141                	addi	sp,sp,16
 572:	8082                	ret
    return 0;
 574:	4501                	li	a0,0
 576:	bfe5                	j	56e <strchr+0x1a>

0000000000000578 <gets>:

char *
gets(char *buf, int max)
{
 578:	711d                	addi	sp,sp,-96
 57a:	ec86                	sd	ra,88(sp)
 57c:	e8a2                	sd	s0,80(sp)
 57e:	e4a6                	sd	s1,72(sp)
 580:	e0ca                	sd	s2,64(sp)
 582:	fc4e                	sd	s3,56(sp)
 584:	f852                	sd	s4,48(sp)
 586:	f456                	sd	s5,40(sp)
 588:	f05a                	sd	s6,32(sp)
 58a:	ec5e                	sd	s7,24(sp)
 58c:	1080                	addi	s0,sp,96
 58e:	8baa                	mv	s7,a0
 590:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 592:	892a                	mv	s2,a0
 594:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 596:	4aa9                	li	s5,10
 598:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 59a:	89a6                	mv	s3,s1
 59c:	2485                	addiw	s1,s1,1
 59e:	0344d863          	bge	s1,s4,5ce <gets+0x56>
        cc = read(0, &c, 1);
 5a2:	4605                	li	a2,1
 5a4:	faf40593          	addi	a1,s0,-81
 5a8:	4501                	li	a0,0
 5aa:	00000097          	auipc	ra,0x0
 5ae:	19a080e7          	jalr	410(ra) # 744 <read>
        if (cc < 1)
 5b2:	00a05e63          	blez	a0,5ce <gets+0x56>
        buf[i++] = c;
 5b6:	faf44783          	lbu	a5,-81(s0)
 5ba:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5be:	01578763          	beq	a5,s5,5cc <gets+0x54>
 5c2:	0905                	addi	s2,s2,1
 5c4:	fd679be3          	bne	a5,s6,59a <gets+0x22>
    for (i = 0; i + 1 < max;)
 5c8:	89a6                	mv	s3,s1
 5ca:	a011                	j	5ce <gets+0x56>
 5cc:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5ce:	99de                	add	s3,s3,s7
 5d0:	00098023          	sb	zero,0(s3)
    return buf;
}
 5d4:	855e                	mv	a0,s7
 5d6:	60e6                	ld	ra,88(sp)
 5d8:	6446                	ld	s0,80(sp)
 5da:	64a6                	ld	s1,72(sp)
 5dc:	6906                	ld	s2,64(sp)
 5de:	79e2                	ld	s3,56(sp)
 5e0:	7a42                	ld	s4,48(sp)
 5e2:	7aa2                	ld	s5,40(sp)
 5e4:	7b02                	ld	s6,32(sp)
 5e6:	6be2                	ld	s7,24(sp)
 5e8:	6125                	addi	sp,sp,96
 5ea:	8082                	ret

00000000000005ec <stat>:

int stat(const char *n, struct stat *st)
{
 5ec:	1101                	addi	sp,sp,-32
 5ee:	ec06                	sd	ra,24(sp)
 5f0:	e822                	sd	s0,16(sp)
 5f2:	e426                	sd	s1,8(sp)
 5f4:	e04a                	sd	s2,0(sp)
 5f6:	1000                	addi	s0,sp,32
 5f8:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5fa:	4581                	li	a1,0
 5fc:	00000097          	auipc	ra,0x0
 600:	170080e7          	jalr	368(ra) # 76c <open>
    if (fd < 0)
 604:	02054563          	bltz	a0,62e <stat+0x42>
 608:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 60a:	85ca                	mv	a1,s2
 60c:	00000097          	auipc	ra,0x0
 610:	178080e7          	jalr	376(ra) # 784 <fstat>
 614:	892a                	mv	s2,a0
    close(fd);
 616:	8526                	mv	a0,s1
 618:	00000097          	auipc	ra,0x0
 61c:	13c080e7          	jalr	316(ra) # 754 <close>
    return r;
}
 620:	854a                	mv	a0,s2
 622:	60e2                	ld	ra,24(sp)
 624:	6442                	ld	s0,16(sp)
 626:	64a2                	ld	s1,8(sp)
 628:	6902                	ld	s2,0(sp)
 62a:	6105                	addi	sp,sp,32
 62c:	8082                	ret
        return -1;
 62e:	597d                	li	s2,-1
 630:	bfc5                	j	620 <stat+0x34>

0000000000000632 <atoi>:

int atoi(const char *s)
{
 632:	1141                	addi	sp,sp,-16
 634:	e422                	sd	s0,8(sp)
 636:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 638:	00054683          	lbu	a3,0(a0)
 63c:	fd06879b          	addiw	a5,a3,-48
 640:	0ff7f793          	zext.b	a5,a5
 644:	4625                	li	a2,9
 646:	02f66863          	bltu	a2,a5,676 <atoi+0x44>
 64a:	872a                	mv	a4,a0
    n = 0;
 64c:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 64e:	0705                	addi	a4,a4,1
 650:	0025179b          	slliw	a5,a0,0x2
 654:	9fa9                	addw	a5,a5,a0
 656:	0017979b          	slliw	a5,a5,0x1
 65a:	9fb5                	addw	a5,a5,a3
 65c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 660:	00074683          	lbu	a3,0(a4)
 664:	fd06879b          	addiw	a5,a3,-48
 668:	0ff7f793          	zext.b	a5,a5
 66c:	fef671e3          	bgeu	a2,a5,64e <atoi+0x1c>
    return n;
}
 670:	6422                	ld	s0,8(sp)
 672:	0141                	addi	sp,sp,16
 674:	8082                	ret
    n = 0;
 676:	4501                	li	a0,0
 678:	bfe5                	j	670 <atoi+0x3e>

000000000000067a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 67a:	1141                	addi	sp,sp,-16
 67c:	e422                	sd	s0,8(sp)
 67e:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 680:	02b57463          	bgeu	a0,a1,6a8 <memmove+0x2e>
    {
        while (n-- > 0)
 684:	00c05f63          	blez	a2,6a2 <memmove+0x28>
 688:	1602                	slli	a2,a2,0x20
 68a:	9201                	srli	a2,a2,0x20
 68c:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 690:	872a                	mv	a4,a0
            *dst++ = *src++;
 692:	0585                	addi	a1,a1,1
 694:	0705                	addi	a4,a4,1
 696:	fff5c683          	lbu	a3,-1(a1)
 69a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 69e:	fee79ae3          	bne	a5,a4,692 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6a2:	6422                	ld	s0,8(sp)
 6a4:	0141                	addi	sp,sp,16
 6a6:	8082                	ret
        dst += n;
 6a8:	00c50733          	add	a4,a0,a2
        src += n;
 6ac:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6ae:	fec05ae3          	blez	a2,6a2 <memmove+0x28>
 6b2:	fff6079b          	addiw	a5,a2,-1
 6b6:	1782                	slli	a5,a5,0x20
 6b8:	9381                	srli	a5,a5,0x20
 6ba:	fff7c793          	not	a5,a5
 6be:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6c0:	15fd                	addi	a1,a1,-1
 6c2:	177d                	addi	a4,a4,-1
 6c4:	0005c683          	lbu	a3,0(a1)
 6c8:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6cc:	fee79ae3          	bne	a5,a4,6c0 <memmove+0x46>
 6d0:	bfc9                	j	6a2 <memmove+0x28>

00000000000006d2 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6d2:	1141                	addi	sp,sp,-16
 6d4:	e422                	sd	s0,8(sp)
 6d6:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6d8:	ca05                	beqz	a2,708 <memcmp+0x36>
 6da:	fff6069b          	addiw	a3,a2,-1
 6de:	1682                	slli	a3,a3,0x20
 6e0:	9281                	srli	a3,a3,0x20
 6e2:	0685                	addi	a3,a3,1
 6e4:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6e6:	00054783          	lbu	a5,0(a0)
 6ea:	0005c703          	lbu	a4,0(a1)
 6ee:	00e79863          	bne	a5,a4,6fe <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6f2:	0505                	addi	a0,a0,1
        p2++;
 6f4:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6f6:	fed518e3          	bne	a0,a3,6e6 <memcmp+0x14>
    }
    return 0;
 6fa:	4501                	li	a0,0
 6fc:	a019                	j	702 <memcmp+0x30>
            return *p1 - *p2;
 6fe:	40e7853b          	subw	a0,a5,a4
}
 702:	6422                	ld	s0,8(sp)
 704:	0141                	addi	sp,sp,16
 706:	8082                	ret
    return 0;
 708:	4501                	li	a0,0
 70a:	bfe5                	j	702 <memcmp+0x30>

000000000000070c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 70c:	1141                	addi	sp,sp,-16
 70e:	e406                	sd	ra,8(sp)
 710:	e022                	sd	s0,0(sp)
 712:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 714:	00000097          	auipc	ra,0x0
 718:	f66080e7          	jalr	-154(ra) # 67a <memmove>
}
 71c:	60a2                	ld	ra,8(sp)
 71e:	6402                	ld	s0,0(sp)
 720:	0141                	addi	sp,sp,16
 722:	8082                	ret

0000000000000724 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 724:	4885                	li	a7,1
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <exit>:
.global exit
exit:
 li a7, SYS_exit
 72c:	4889                	li	a7,2
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <wait>:
.global wait
wait:
 li a7, SYS_wait
 734:	488d                	li	a7,3
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 73c:	4891                	li	a7,4
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <read>:
.global read
read:
 li a7, SYS_read
 744:	4895                	li	a7,5
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <write>:
.global write
write:
 li a7, SYS_write
 74c:	48c1                	li	a7,16
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <close>:
.global close
close:
 li a7, SYS_close
 754:	48d5                	li	a7,21
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <kill>:
.global kill
kill:
 li a7, SYS_kill
 75c:	4899                	li	a7,6
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <exec>:
.global exec
exec:
 li a7, SYS_exec
 764:	489d                	li	a7,7
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <open>:
.global open
open:
 li a7, SYS_open
 76c:	48bd                	li	a7,15
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 774:	48c5                	li	a7,17
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 77c:	48c9                	li	a7,18
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 784:	48a1                	li	a7,8
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <link>:
.global link
link:
 li a7, SYS_link
 78c:	48cd                	li	a7,19
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 794:	48d1                	li	a7,20
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 79c:	48a5                	li	a7,9
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7a4:	48a9                	li	a7,10
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ac:	48ad                	li	a7,11
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7b4:	48b1                	li	a7,12
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7bc:	48b5                	li	a7,13
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7c4:	48b9                	li	a7,14
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <ps>:
.global ps
ps:
 li a7, SYS_ps
 7cc:	48d9                	li	a7,22
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7d4:	48dd                	li	a7,23
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7dc:	48e1                	li	a7,24
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7e4:	1101                	addi	sp,sp,-32
 7e6:	ec06                	sd	ra,24(sp)
 7e8:	e822                	sd	s0,16(sp)
 7ea:	1000                	addi	s0,sp,32
 7ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7f0:	4605                	li	a2,1
 7f2:	fef40593          	addi	a1,s0,-17
 7f6:	00000097          	auipc	ra,0x0
 7fa:	f56080e7          	jalr	-170(ra) # 74c <write>
}
 7fe:	60e2                	ld	ra,24(sp)
 800:	6442                	ld	s0,16(sp)
 802:	6105                	addi	sp,sp,32
 804:	8082                	ret

0000000000000806 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 806:	7139                	addi	sp,sp,-64
 808:	fc06                	sd	ra,56(sp)
 80a:	f822                	sd	s0,48(sp)
 80c:	f426                	sd	s1,40(sp)
 80e:	f04a                	sd	s2,32(sp)
 810:	ec4e                	sd	s3,24(sp)
 812:	0080                	addi	s0,sp,64
 814:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 816:	c299                	beqz	a3,81c <printint+0x16>
 818:	0805c963          	bltz	a1,8aa <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 81c:	2581                	sext.w	a1,a1
  neg = 0;
 81e:	4881                	li	a7,0
 820:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 824:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 826:	2601                	sext.w	a2,a2
 828:	00000517          	auipc	a0,0x0
 82c:	51850513          	addi	a0,a0,1304 # d40 <digits>
 830:	883a                	mv	a6,a4
 832:	2705                	addiw	a4,a4,1
 834:	02c5f7bb          	remuw	a5,a1,a2
 838:	1782                	slli	a5,a5,0x20
 83a:	9381                	srli	a5,a5,0x20
 83c:	97aa                	add	a5,a5,a0
 83e:	0007c783          	lbu	a5,0(a5)
 842:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 846:	0005879b          	sext.w	a5,a1
 84a:	02c5d5bb          	divuw	a1,a1,a2
 84e:	0685                	addi	a3,a3,1
 850:	fec7f0e3          	bgeu	a5,a2,830 <printint+0x2a>
  if(neg)
 854:	00088c63          	beqz	a7,86c <printint+0x66>
    buf[i++] = '-';
 858:	fd070793          	addi	a5,a4,-48
 85c:	00878733          	add	a4,a5,s0
 860:	02d00793          	li	a5,45
 864:	fef70823          	sb	a5,-16(a4)
 868:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 86c:	02e05863          	blez	a4,89c <printint+0x96>
 870:	fc040793          	addi	a5,s0,-64
 874:	00e78933          	add	s2,a5,a4
 878:	fff78993          	addi	s3,a5,-1
 87c:	99ba                	add	s3,s3,a4
 87e:	377d                	addiw	a4,a4,-1
 880:	1702                	slli	a4,a4,0x20
 882:	9301                	srli	a4,a4,0x20
 884:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 888:	fff94583          	lbu	a1,-1(s2)
 88c:	8526                	mv	a0,s1
 88e:	00000097          	auipc	ra,0x0
 892:	f56080e7          	jalr	-170(ra) # 7e4 <putc>
  while(--i >= 0)
 896:	197d                	addi	s2,s2,-1
 898:	ff3918e3          	bne	s2,s3,888 <printint+0x82>
}
 89c:	70e2                	ld	ra,56(sp)
 89e:	7442                	ld	s0,48(sp)
 8a0:	74a2                	ld	s1,40(sp)
 8a2:	7902                	ld	s2,32(sp)
 8a4:	69e2                	ld	s3,24(sp)
 8a6:	6121                	addi	sp,sp,64
 8a8:	8082                	ret
    x = -xx;
 8aa:	40b005bb          	negw	a1,a1
    neg = 1;
 8ae:	4885                	li	a7,1
    x = -xx;
 8b0:	bf85                	j	820 <printint+0x1a>

00000000000008b2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8b2:	715d                	addi	sp,sp,-80
 8b4:	e486                	sd	ra,72(sp)
 8b6:	e0a2                	sd	s0,64(sp)
 8b8:	fc26                	sd	s1,56(sp)
 8ba:	f84a                	sd	s2,48(sp)
 8bc:	f44e                	sd	s3,40(sp)
 8be:	f052                	sd	s4,32(sp)
 8c0:	ec56                	sd	s5,24(sp)
 8c2:	e85a                	sd	s6,16(sp)
 8c4:	e45e                	sd	s7,8(sp)
 8c6:	e062                	sd	s8,0(sp)
 8c8:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8ca:	0005c903          	lbu	s2,0(a1)
 8ce:	18090c63          	beqz	s2,a66 <vprintf+0x1b4>
 8d2:	8aaa                	mv	s5,a0
 8d4:	8bb2                	mv	s7,a2
 8d6:	00158493          	addi	s1,a1,1
  state = 0;
 8da:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8dc:	02500a13          	li	s4,37
 8e0:	4b55                	li	s6,21
 8e2:	a839                	j	900 <vprintf+0x4e>
        putc(fd, c);
 8e4:	85ca                	mv	a1,s2
 8e6:	8556                	mv	a0,s5
 8e8:	00000097          	auipc	ra,0x0
 8ec:	efc080e7          	jalr	-260(ra) # 7e4 <putc>
 8f0:	a019                	j	8f6 <vprintf+0x44>
    } else if(state == '%'){
 8f2:	01498d63          	beq	s3,s4,90c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8f6:	0485                	addi	s1,s1,1
 8f8:	fff4c903          	lbu	s2,-1(s1)
 8fc:	16090563          	beqz	s2,a66 <vprintf+0x1b4>
    if(state == 0){
 900:	fe0999e3          	bnez	s3,8f2 <vprintf+0x40>
      if(c == '%'){
 904:	ff4910e3          	bne	s2,s4,8e4 <vprintf+0x32>
        state = '%';
 908:	89d2                	mv	s3,s4
 90a:	b7f5                	j	8f6 <vprintf+0x44>
      if(c == 'd'){
 90c:	13490263          	beq	s2,s4,a30 <vprintf+0x17e>
 910:	f9d9079b          	addiw	a5,s2,-99
 914:	0ff7f793          	zext.b	a5,a5
 918:	12fb6563          	bltu	s6,a5,a42 <vprintf+0x190>
 91c:	f9d9079b          	addiw	a5,s2,-99
 920:	0ff7f713          	zext.b	a4,a5
 924:	10eb6f63          	bltu	s6,a4,a42 <vprintf+0x190>
 928:	00271793          	slli	a5,a4,0x2
 92c:	00000717          	auipc	a4,0x0
 930:	3bc70713          	addi	a4,a4,956 # ce8 <malloc+0x184>
 934:	97ba                	add	a5,a5,a4
 936:	439c                	lw	a5,0(a5)
 938:	97ba                	add	a5,a5,a4
 93a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 93c:	008b8913          	addi	s2,s7,8
 940:	4685                	li	a3,1
 942:	4629                	li	a2,10
 944:	000ba583          	lw	a1,0(s7)
 948:	8556                	mv	a0,s5
 94a:	00000097          	auipc	ra,0x0
 94e:	ebc080e7          	jalr	-324(ra) # 806 <printint>
 952:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 954:	4981                	li	s3,0
 956:	b745                	j	8f6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 958:	008b8913          	addi	s2,s7,8
 95c:	4681                	li	a3,0
 95e:	4629                	li	a2,10
 960:	000ba583          	lw	a1,0(s7)
 964:	8556                	mv	a0,s5
 966:	00000097          	auipc	ra,0x0
 96a:	ea0080e7          	jalr	-352(ra) # 806 <printint>
 96e:	8bca                	mv	s7,s2
      state = 0;
 970:	4981                	li	s3,0
 972:	b751                	j	8f6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 974:	008b8913          	addi	s2,s7,8
 978:	4681                	li	a3,0
 97a:	4641                	li	a2,16
 97c:	000ba583          	lw	a1,0(s7)
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	e84080e7          	jalr	-380(ra) # 806 <printint>
 98a:	8bca                	mv	s7,s2
      state = 0;
 98c:	4981                	li	s3,0
 98e:	b7a5                	j	8f6 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 990:	008b8c13          	addi	s8,s7,8
 994:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 998:	03000593          	li	a1,48
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	e46080e7          	jalr	-442(ra) # 7e4 <putc>
  putc(fd, 'x');
 9a6:	07800593          	li	a1,120
 9aa:	8556                	mv	a0,s5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	e38080e7          	jalr	-456(ra) # 7e4 <putc>
 9b4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9b6:	00000b97          	auipc	s7,0x0
 9ba:	38ab8b93          	addi	s7,s7,906 # d40 <digits>
 9be:	03c9d793          	srli	a5,s3,0x3c
 9c2:	97de                	add	a5,a5,s7
 9c4:	0007c583          	lbu	a1,0(a5)
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	e1a080e7          	jalr	-486(ra) # 7e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9d2:	0992                	slli	s3,s3,0x4
 9d4:	397d                	addiw	s2,s2,-1
 9d6:	fe0914e3          	bnez	s2,9be <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9da:	8be2                	mv	s7,s8
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bf21                	j	8f6 <vprintf+0x44>
        s = va_arg(ap, char*);
 9e0:	008b8993          	addi	s3,s7,8
 9e4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9e8:	02090163          	beqz	s2,a0a <vprintf+0x158>
        while(*s != 0){
 9ec:	00094583          	lbu	a1,0(s2)
 9f0:	c9a5                	beqz	a1,a60 <vprintf+0x1ae>
          putc(fd, *s);
 9f2:	8556                	mv	a0,s5
 9f4:	00000097          	auipc	ra,0x0
 9f8:	df0080e7          	jalr	-528(ra) # 7e4 <putc>
          s++;
 9fc:	0905                	addi	s2,s2,1
        while(*s != 0){
 9fe:	00094583          	lbu	a1,0(s2)
 a02:	f9e5                	bnez	a1,9f2 <vprintf+0x140>
        s = va_arg(ap, char*);
 a04:	8bce                	mv	s7,s3
      state = 0;
 a06:	4981                	li	s3,0
 a08:	b5fd                	j	8f6 <vprintf+0x44>
          s = "(null)";
 a0a:	00000917          	auipc	s2,0x0
 a0e:	2d690913          	addi	s2,s2,726 # ce0 <malloc+0x17c>
        while(*s != 0){
 a12:	02800593          	li	a1,40
 a16:	bff1                	j	9f2 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a18:	008b8913          	addi	s2,s7,8
 a1c:	000bc583          	lbu	a1,0(s7)
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	dc2080e7          	jalr	-574(ra) # 7e4 <putc>
 a2a:	8bca                	mv	s7,s2
      state = 0;
 a2c:	4981                	li	s3,0
 a2e:	b5e1                	j	8f6 <vprintf+0x44>
        putc(fd, c);
 a30:	02500593          	li	a1,37
 a34:	8556                	mv	a0,s5
 a36:	00000097          	auipc	ra,0x0
 a3a:	dae080e7          	jalr	-594(ra) # 7e4 <putc>
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	bd5d                	j	8f6 <vprintf+0x44>
        putc(fd, '%');
 a42:	02500593          	li	a1,37
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	d9c080e7          	jalr	-612(ra) # 7e4 <putc>
        putc(fd, c);
 a50:	85ca                	mv	a1,s2
 a52:	8556                	mv	a0,s5
 a54:	00000097          	auipc	ra,0x0
 a58:	d90080e7          	jalr	-624(ra) # 7e4 <putc>
      state = 0;
 a5c:	4981                	li	s3,0
 a5e:	bd61                	j	8f6 <vprintf+0x44>
        s = va_arg(ap, char*);
 a60:	8bce                	mv	s7,s3
      state = 0;
 a62:	4981                	li	s3,0
 a64:	bd49                	j	8f6 <vprintf+0x44>
    }
  }
}
 a66:	60a6                	ld	ra,72(sp)
 a68:	6406                	ld	s0,64(sp)
 a6a:	74e2                	ld	s1,56(sp)
 a6c:	7942                	ld	s2,48(sp)
 a6e:	79a2                	ld	s3,40(sp)
 a70:	7a02                	ld	s4,32(sp)
 a72:	6ae2                	ld	s5,24(sp)
 a74:	6b42                	ld	s6,16(sp)
 a76:	6ba2                	ld	s7,8(sp)
 a78:	6c02                	ld	s8,0(sp)
 a7a:	6161                	addi	sp,sp,80
 a7c:	8082                	ret

0000000000000a7e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a7e:	715d                	addi	sp,sp,-80
 a80:	ec06                	sd	ra,24(sp)
 a82:	e822                	sd	s0,16(sp)
 a84:	1000                	addi	s0,sp,32
 a86:	e010                	sd	a2,0(s0)
 a88:	e414                	sd	a3,8(s0)
 a8a:	e818                	sd	a4,16(s0)
 a8c:	ec1c                	sd	a5,24(s0)
 a8e:	03043023          	sd	a6,32(s0)
 a92:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a96:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a9a:	8622                	mv	a2,s0
 a9c:	00000097          	auipc	ra,0x0
 aa0:	e16080e7          	jalr	-490(ra) # 8b2 <vprintf>
}
 aa4:	60e2                	ld	ra,24(sp)
 aa6:	6442                	ld	s0,16(sp)
 aa8:	6161                	addi	sp,sp,80
 aaa:	8082                	ret

0000000000000aac <printf>:

void
printf(const char *fmt, ...)
{
 aac:	711d                	addi	sp,sp,-96
 aae:	ec06                	sd	ra,24(sp)
 ab0:	e822                	sd	s0,16(sp)
 ab2:	1000                	addi	s0,sp,32
 ab4:	e40c                	sd	a1,8(s0)
 ab6:	e810                	sd	a2,16(s0)
 ab8:	ec14                	sd	a3,24(s0)
 aba:	f018                	sd	a4,32(s0)
 abc:	f41c                	sd	a5,40(s0)
 abe:	03043823          	sd	a6,48(s0)
 ac2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ac6:	00840613          	addi	a2,s0,8
 aca:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ace:	85aa                	mv	a1,a0
 ad0:	4505                	li	a0,1
 ad2:	00000097          	auipc	ra,0x0
 ad6:	de0080e7          	jalr	-544(ra) # 8b2 <vprintf>
}
 ada:	60e2                	ld	ra,24(sp)
 adc:	6442                	ld	s0,16(sp)
 ade:	6125                	addi	sp,sp,96
 ae0:	8082                	ret

0000000000000ae2 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ae2:	1141                	addi	sp,sp,-16
 ae4:	e422                	sd	s0,8(sp)
 ae6:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 ae8:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aec:	00000797          	auipc	a5,0x0
 af0:	52c7b783          	ld	a5,1324(a5) # 1018 <freep>
 af4:	a02d                	j	b1e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 af6:	4618                	lw	a4,8(a2)
 af8:	9f2d                	addw	a4,a4,a1
 afa:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 afe:	6398                	ld	a4,0(a5)
 b00:	6310                	ld	a2,0(a4)
 b02:	a83d                	j	b40 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b04:	ff852703          	lw	a4,-8(a0)
 b08:	9f31                	addw	a4,a4,a2
 b0a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b0c:	ff053683          	ld	a3,-16(a0)
 b10:	a091                	j	b54 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b12:	6398                	ld	a4,0(a5)
 b14:	00e7e463          	bltu	a5,a4,b1c <free+0x3a>
 b18:	00e6ea63          	bltu	a3,a4,b2c <free+0x4a>
{
 b1c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b1e:	fed7fae3          	bgeu	a5,a3,b12 <free+0x30>
 b22:	6398                	ld	a4,0(a5)
 b24:	00e6e463          	bltu	a3,a4,b2c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b28:	fee7eae3          	bltu	a5,a4,b1c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b2c:	ff852583          	lw	a1,-8(a0)
 b30:	6390                	ld	a2,0(a5)
 b32:	02059813          	slli	a6,a1,0x20
 b36:	01c85713          	srli	a4,a6,0x1c
 b3a:	9736                	add	a4,a4,a3
 b3c:	fae60de3          	beq	a2,a4,af6 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b40:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b44:	4790                	lw	a2,8(a5)
 b46:	02061593          	slli	a1,a2,0x20
 b4a:	01c5d713          	srli	a4,a1,0x1c
 b4e:	973e                	add	a4,a4,a5
 b50:	fae68ae3          	beq	a3,a4,b04 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b54:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b56:	00000717          	auipc	a4,0x0
 b5a:	4cf73123          	sd	a5,1218(a4) # 1018 <freep>
}
 b5e:	6422                	ld	s0,8(sp)
 b60:	0141                	addi	sp,sp,16
 b62:	8082                	ret

0000000000000b64 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b64:	7139                	addi	sp,sp,-64
 b66:	fc06                	sd	ra,56(sp)
 b68:	f822                	sd	s0,48(sp)
 b6a:	f426                	sd	s1,40(sp)
 b6c:	f04a                	sd	s2,32(sp)
 b6e:	ec4e                	sd	s3,24(sp)
 b70:	e852                	sd	s4,16(sp)
 b72:	e456                	sd	s5,8(sp)
 b74:	e05a                	sd	s6,0(sp)
 b76:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b78:	02051493          	slli	s1,a0,0x20
 b7c:	9081                	srli	s1,s1,0x20
 b7e:	04bd                	addi	s1,s1,15
 b80:	8091                	srli	s1,s1,0x4
 b82:	0014899b          	addiw	s3,s1,1
 b86:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b88:	00000517          	auipc	a0,0x0
 b8c:	49053503          	ld	a0,1168(a0) # 1018 <freep>
 b90:	c515                	beqz	a0,bbc <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b92:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b94:	4798                	lw	a4,8(a5)
 b96:	02977f63          	bgeu	a4,s1,bd4 <malloc+0x70>
    if (nu < 4096)
 b9a:	8a4e                	mv	s4,s3
 b9c:	0009871b          	sext.w	a4,s3
 ba0:	6685                	lui	a3,0x1
 ba2:	00d77363          	bgeu	a4,a3,ba8 <malloc+0x44>
 ba6:	6a05                	lui	s4,0x1
 ba8:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bac:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bb0:	00000917          	auipc	s2,0x0
 bb4:	46890913          	addi	s2,s2,1128 # 1018 <freep>
    if (p == (char *)-1)
 bb8:	5afd                	li	s5,-1
 bba:	a895                	j	c2e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bbc:	00000797          	auipc	a5,0x0
 bc0:	4e478793          	addi	a5,a5,1252 # 10a0 <base>
 bc4:	00000717          	auipc	a4,0x0
 bc8:	44f73a23          	sd	a5,1108(a4) # 1018 <freep>
 bcc:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bce:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bd2:	b7e1                	j	b9a <malloc+0x36>
            if (p->s.size == nunits)
 bd4:	02e48c63          	beq	s1,a4,c0c <malloc+0xa8>
                p->s.size -= nunits;
 bd8:	4137073b          	subw	a4,a4,s3
 bdc:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bde:	02071693          	slli	a3,a4,0x20
 be2:	01c6d713          	srli	a4,a3,0x1c
 be6:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 be8:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bec:	00000717          	auipc	a4,0x0
 bf0:	42a73623          	sd	a0,1068(a4) # 1018 <freep>
            return (void *)(p + 1);
 bf4:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bf8:	70e2                	ld	ra,56(sp)
 bfa:	7442                	ld	s0,48(sp)
 bfc:	74a2                	ld	s1,40(sp)
 bfe:	7902                	ld	s2,32(sp)
 c00:	69e2                	ld	s3,24(sp)
 c02:	6a42                	ld	s4,16(sp)
 c04:	6aa2                	ld	s5,8(sp)
 c06:	6b02                	ld	s6,0(sp)
 c08:	6121                	addi	sp,sp,64
 c0a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c0c:	6398                	ld	a4,0(a5)
 c0e:	e118                	sd	a4,0(a0)
 c10:	bff1                	j	bec <malloc+0x88>
    hp->s.size = nu;
 c12:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c16:	0541                	addi	a0,a0,16
 c18:	00000097          	auipc	ra,0x0
 c1c:	eca080e7          	jalr	-310(ra) # ae2 <free>
    return freep;
 c20:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c24:	d971                	beqz	a0,bf8 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c26:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c28:	4798                	lw	a4,8(a5)
 c2a:	fa9775e3          	bgeu	a4,s1,bd4 <malloc+0x70>
        if (p == freep)
 c2e:	00093703          	ld	a4,0(s2)
 c32:	853e                	mv	a0,a5
 c34:	fef719e3          	bne	a4,a5,c26 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c38:	8552                	mv	a0,s4
 c3a:	00000097          	auipc	ra,0x0
 c3e:	b7a080e7          	jalr	-1158(ra) # 7b4 <sbrk>
    if (p == (char *)-1)
 c42:	fd5518e3          	bne	a0,s5,c12 <malloc+0xae>
                return 0;
 c46:	4501                	li	a0,0
 c48:	bf45                	j	bf8 <malloc+0x94>
