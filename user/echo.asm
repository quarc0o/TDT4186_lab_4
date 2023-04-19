
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d863          	bge	a5,a0,84 <main+0x84>
  18:	00858493          	addi	s1,a1,8
  1c:	3579                	addiw	a0,a0,-2
  1e:	02051793          	slli	a5,a0,0x20
  22:	01d7d513          	srli	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	addi	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	bd0a8a93          	addi	s5,s5,-1072 # c00 <malloc+0xf4>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	6b4080e7          	jalr	1716(ra) # 6f4 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	45c080e7          	jalr	1116(ra) # 4b0 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	690080e7          	jalr	1680(ra) # 6f4 <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	b9658593          	addi	a1,a1,-1130 # c08 <malloc+0xfc>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	678080e7          	jalr	1656(ra) # 6f4 <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	64e080e7          	jalr	1614(ra) # 6d4 <exit>

000000000000008e <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
    lk->name = name;
  94:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  96:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  9a:	57fd                	li	a5,-1
  9c:	00f50823          	sb	a5,16(a0)
}
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  a6:	00054783          	lbu	a5,0(a0)
  aa:	e399                	bnez	a5,b0 <holding+0xa>
  ac:	4501                	li	a0,0
}
  ae:	8082                	ret
{
  b0:	1101                	addi	sp,sp,-32
  b2:	ec06                	sd	ra,24(sp)
  b4:	e822                	sd	s0,16(sp)
  b6:	e426                	sd	s1,8(sp)
  b8:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  ba:	01054483          	lbu	s1,16(a0)
  be:	00000097          	auipc	ra,0x0
  c2:	2c4080e7          	jalr	708(ra) # 382 <twhoami>
  c6:	2501                	sext.w	a0,a0
  c8:	40a48533          	sub	a0,s1,a0
  cc:	00153513          	seqz	a0,a0
}
  d0:	60e2                	ld	ra,24(sp)
  d2:	6442                	ld	s0,16(sp)
  d4:	64a2                	ld	s1,8(sp)
  d6:	6105                	addi	sp,sp,32
  d8:	8082                	ret

00000000000000da <acquire>:

void acquire(struct lock *lk)
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	ec26                	sd	s1,24(sp)
  e2:	e84a                	sd	s2,16(sp)
  e4:	e44e                	sd	s3,8(sp)
  e6:	e052                	sd	s4,0(sp)
  e8:	1800                	addi	s0,sp,48
  ea:	8a2a                	mv	s4,a0
    if (holding(lk))
  ec:	00000097          	auipc	ra,0x0
  f0:	fba080e7          	jalr	-70(ra) # a6 <holding>
  f4:	e919                	bnez	a0,10a <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f6:	ffca7493          	andi	s1,s4,-4
  fa:	003a7913          	andi	s2,s4,3
  fe:	0039191b          	slliw	s2,s2,0x3
 102:	4985                	li	s3,1
 104:	012999bb          	sllw	s3,s3,s2
 108:	a015                	j	12c <acquire+0x52>
        printf("re-acquiring lock we already hold");
 10a:	00001517          	auipc	a0,0x1
 10e:	b0650513          	addi	a0,a0,-1274 # c10 <malloc+0x104>
 112:	00001097          	auipc	ra,0x1
 116:	942080e7          	jalr	-1726(ra) # a54 <printf>
        exit(-1);
 11a:	557d                	li	a0,-1
 11c:	00000097          	auipc	ra,0x0
 120:	5b8080e7          	jalr	1464(ra) # 6d4 <exit>
    {
        // give up the cpu for other threads
        tyield();
 124:	00000097          	auipc	ra,0x0
 128:	1dc080e7          	jalr	476(ra) # 300 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 12c:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 130:	0127d7bb          	srlw	a5,a5,s2
 134:	0ff7f793          	zext.b	a5,a5
 138:	f7f5                	bnez	a5,124 <acquire+0x4a>
    }

    __sync_synchronize();
 13a:	0ff0000f          	fence

    lk->tid = twhoami();
 13e:	00000097          	auipc	ra,0x0
 142:	244080e7          	jalr	580(ra) # 382 <twhoami>
 146:	00aa0823          	sb	a0,16(s4)
}
 14a:	70a2                	ld	ra,40(sp)
 14c:	7402                	ld	s0,32(sp)
 14e:	64e2                	ld	s1,24(sp)
 150:	6942                	ld	s2,16(sp)
 152:	69a2                	ld	s3,8(sp)
 154:	6a02                	ld	s4,0(sp)
 156:	6145                	addi	sp,sp,48
 158:	8082                	ret

000000000000015a <release>:

void release(struct lock *lk)
{
 15a:	1101                	addi	sp,sp,-32
 15c:	ec06                	sd	ra,24(sp)
 15e:	e822                	sd	s0,16(sp)
 160:	e426                	sd	s1,8(sp)
 162:	1000                	addi	s0,sp,32
 164:	84aa                	mv	s1,a0
    if (!holding(lk))
 166:	00000097          	auipc	ra,0x0
 16a:	f40080e7          	jalr	-192(ra) # a6 <holding>
 16e:	c11d                	beqz	a0,194 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 170:	57fd                	li	a5,-1
 172:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 176:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 17a:	0ff0000f          	fence
 17e:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 182:	00000097          	auipc	ra,0x0
 186:	17e080e7          	jalr	382(ra) # 300 <tyield>
}
 18a:	60e2                	ld	ra,24(sp)
 18c:	6442                	ld	s0,16(sp)
 18e:	64a2                	ld	s1,8(sp)
 190:	6105                	addi	sp,sp,32
 192:	8082                	ret
        printf("releasing lock we are not holding");
 194:	00001517          	auipc	a0,0x1
 198:	aa450513          	addi	a0,a0,-1372 # c38 <malloc+0x12c>
 19c:	00001097          	auipc	ra,0x1
 1a0:	8b8080e7          	jalr	-1864(ra) # a54 <printf>
        exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	52e080e7          	jalr	1326(ra) # 6d4 <exit>

00000000000001ae <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1ae:	00001517          	auipc	a0,0x1
 1b2:	e6253503          	ld	a0,-414(a0) # 1010 <current_thread>
 1b6:	00001717          	auipc	a4,0x1
 1ba:	e6a70713          	addi	a4,a4,-406 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1be:	4781                	li	a5,0
 1c0:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1c2:	6314                	ld	a3,0(a4)
 1c4:	00a68763          	beq	a3,a0,1d2 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1c8:	2785                	addiw	a5,a5,1
 1ca:	0721                	addi	a4,a4,8
 1cc:	fec79be3          	bne	a5,a2,1c2 <tsched+0x14>
    int current_index = 0;
 1d0:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1d2:	0017869b          	addiw	a3,a5,1
 1d6:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1da:	00001817          	auipc	a6,0x1
 1de:	e4680813          	addi	a6,a6,-442 # 1020 <threads>
 1e2:	488d                	li	a7,3
 1e4:	a021                	j	1ec <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1e6:	2685                	addiw	a3,a3,1
 1e8:	04c68363          	beq	a3,a2,22e <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1ec:	41f6d71b          	sraiw	a4,a3,0x1f
 1f0:	01c7571b          	srliw	a4,a4,0x1c
 1f4:	00d707bb          	addw	a5,a4,a3
 1f8:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1fa:	9f99                	subw	a5,a5,a4
 1fc:	078e                	slli	a5,a5,0x3
 1fe:	97c2                	add	a5,a5,a6
 200:	638c                	ld	a1,0(a5)
 202:	d1f5                	beqz	a1,1e6 <tsched+0x38>
 204:	5dbc                	lw	a5,120(a1)
 206:	ff1790e3          	bne	a5,a7,1e6 <tsched+0x38>
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 212:	00001797          	auipc	a5,0x1
 216:	deb7bf23          	sd	a1,-514(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 21a:	05a1                	addi	a1,a1,8
 21c:	0521                	addi	a0,a0,8
 21e:	00000097          	auipc	ra,0x0
 222:	17c080e7          	jalr	380(ra) # 39a <tswtch>
        //printf("Thread switch complete\n");
    }
}
 226:	60a2                	ld	ra,8(sp)
 228:	6402                	ld	s0,0(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
 22e:	8082                	ret

0000000000000230 <thread_wrapper>:
{
 230:	1101                	addi	sp,sp,-32
 232:	ec06                	sd	ra,24(sp)
 234:	e822                	sd	s0,16(sp)
 236:	e426                	sd	s1,8(sp)
 238:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 23a:	00001497          	auipc	s1,0x1
 23e:	dd648493          	addi	s1,s1,-554 # 1010 <current_thread>
 242:	609c                	ld	a5,0(s1)
 244:	67d8                	ld	a4,136(a5)
 246:	63c8                	ld	a0,128(a5)
 248:	9702                	jalr	a4
    current_thread->state = EXITED;
 24a:	609c                	ld	a5,0(s1)
 24c:	4719                	li	a4,6
 24e:	dfb8                	sw	a4,120(a5)
    tsched();
 250:	00000097          	auipc	ra,0x0
 254:	f5e080e7          	jalr	-162(ra) # 1ae <tsched>
}
 258:	60e2                	ld	ra,24(sp)
 25a:	6442                	ld	s0,16(sp)
 25c:	64a2                	ld	s1,8(sp)
 25e:	6105                	addi	sp,sp,32
 260:	8082                	ret

0000000000000262 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 262:	7179                	addi	sp,sp,-48
 264:	f406                	sd	ra,40(sp)
 266:	f022                	sd	s0,32(sp)
 268:	ec26                	sd	s1,24(sp)
 26a:	e84a                	sd	s2,16(sp)
 26c:	e44e                	sd	s3,8(sp)
 26e:	1800                	addi	s0,sp,48
 270:	84aa                	mv	s1,a0
 272:	89b2                	mv	s3,a2
 274:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 276:	09800513          	li	a0,152
 27a:	00001097          	auipc	ra,0x1
 27e:	892080e7          	jalr	-1902(ra) # b0c <malloc>
 282:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 284:	478d                	li	a5,3
 286:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 288:	609c                	ld	a5,0(s1)
 28a:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 28e:	609c                	ld	a5,0(s1)
 290:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 294:	6098                	ld	a4,0(s1)
 296:	00001797          	auipc	a5,0x1
 29a:	d6a78793          	addi	a5,a5,-662 # 1000 <next_tid>
 29e:	4394                	lw	a3,0(a5)
 2a0:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2a4:	4398                	lw	a4,0(a5)
 2a6:	2705                	addiw	a4,a4,1
 2a8:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 2aa:	6505                	lui	a0,0x1
 2ac:	00001097          	auipc	ra,0x1
 2b0:	860080e7          	jalr	-1952(ra) # b0c <malloc>
 2b4:	609c                	ld	a5,0(s1)
 2b6:	6705                	lui	a4,0x1
 2b8:	953a                	add	a0,a0,a4
 2ba:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2bc:	609c                	ld	a5,0(s1)
 2be:	00000717          	auipc	a4,0x0
 2c2:	f7270713          	addi	a4,a4,-142 # 230 <thread_wrapper>
 2c6:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2c8:	00001717          	auipc	a4,0x1
 2cc:	d5870713          	addi	a4,a4,-680 # 1020 <threads>
 2d0:	4781                	li	a5,0
 2d2:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2d4:	6314                	ld	a3,0(a4)
 2d6:	ce81                	beqz	a3,2ee <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2d8:	2785                	addiw	a5,a5,1
 2da:	0721                	addi	a4,a4,8
 2dc:	fec79ce3          	bne	a5,a2,2d4 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2e0:	70a2                	ld	ra,40(sp)
 2e2:	7402                	ld	s0,32(sp)
 2e4:	64e2                	ld	s1,24(sp)
 2e6:	6942                	ld	s2,16(sp)
 2e8:	69a2                	ld	s3,8(sp)
 2ea:	6145                	addi	sp,sp,48
 2ec:	8082                	ret
            threads[i] = *thread;
 2ee:	6094                	ld	a3,0(s1)
 2f0:	078e                	slli	a5,a5,0x3
 2f2:	00001717          	auipc	a4,0x1
 2f6:	d2e70713          	addi	a4,a4,-722 # 1020 <threads>
 2fa:	97ba                	add	a5,a5,a4
 2fc:	e394                	sd	a3,0(a5)
            break;
 2fe:	b7cd                	j	2e0 <tcreate+0x7e>

0000000000000300 <tyield>:
    return 0;
}


void tyield()
{
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 308:	00001797          	auipc	a5,0x1
 30c:	d087b783          	ld	a5,-760(a5) # 1010 <current_thread>
 310:	470d                	li	a4,3
 312:	dfb8                	sw	a4,120(a5)
    tsched();
 314:	00000097          	auipc	ra,0x0
 318:	e9a080e7          	jalr	-358(ra) # 1ae <tsched>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <tjoin>:
{
 324:	1101                	addi	sp,sp,-32
 326:	ec06                	sd	ra,24(sp)
 328:	e822                	sd	s0,16(sp)
 32a:	e426                	sd	s1,8(sp)
 32c:	e04a                	sd	s2,0(sp)
 32e:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 330:	00001797          	auipc	a5,0x1
 334:	cf078793          	addi	a5,a5,-784 # 1020 <threads>
 338:	00001697          	auipc	a3,0x1
 33c:	d6868693          	addi	a3,a3,-664 # 10a0 <base>
 340:	a021                	j	348 <tjoin+0x24>
 342:	07a1                	addi	a5,a5,8
 344:	02d78b63          	beq	a5,a3,37a <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 348:	6384                	ld	s1,0(a5)
 34a:	dce5                	beqz	s1,342 <tjoin+0x1e>
 34c:	0004c703          	lbu	a4,0(s1)
 350:	fea719e3          	bne	a4,a0,342 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 354:	5cb8                	lw	a4,120(s1)
 356:	4799                	li	a5,6
 358:	4919                	li	s2,6
 35a:	02f70263          	beq	a4,a5,37e <tjoin+0x5a>
        tyield();
 35e:	00000097          	auipc	ra,0x0
 362:	fa2080e7          	jalr	-94(ra) # 300 <tyield>
    while (target_thread->state != EXITED) {
 366:	5cbc                	lw	a5,120(s1)
 368:	ff279be3          	bne	a5,s2,35e <tjoin+0x3a>
    return 0;
 36c:	4501                	li	a0,0
}
 36e:	60e2                	ld	ra,24(sp)
 370:	6442                	ld	s0,16(sp)
 372:	64a2                	ld	s1,8(sp)
 374:	6902                	ld	s2,0(sp)
 376:	6105                	addi	sp,sp,32
 378:	8082                	ret
        return -1;
 37a:	557d                	li	a0,-1
 37c:	bfcd                	j	36e <tjoin+0x4a>
    return 0;
 37e:	4501                	li	a0,0
 380:	b7fd                	j	36e <tjoin+0x4a>

0000000000000382 <twhoami>:

uint8 twhoami()
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 388:	00001797          	auipc	a5,0x1
 38c:	c887b783          	ld	a5,-888(a5) # 1010 <current_thread>
 390:	0007c503          	lbu	a0,0(a5)
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <tswtch>:
 39a:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 39e:	00253423          	sd	sp,8(a0)
 3a2:	e900                	sd	s0,16(a0)
 3a4:	ed04                	sd	s1,24(a0)
 3a6:	03253023          	sd	s2,32(a0)
 3aa:	03353423          	sd	s3,40(a0)
 3ae:	03453823          	sd	s4,48(a0)
 3b2:	03553c23          	sd	s5,56(a0)
 3b6:	05653023          	sd	s6,64(a0)
 3ba:	05753423          	sd	s7,72(a0)
 3be:	05853823          	sd	s8,80(a0)
 3c2:	05953c23          	sd	s9,88(a0)
 3c6:	07a53023          	sd	s10,96(a0)
 3ca:	07b53423          	sd	s11,104(a0)
 3ce:	0005b083          	ld	ra,0(a1)
 3d2:	0085b103          	ld	sp,8(a1)
 3d6:	6980                	ld	s0,16(a1)
 3d8:	6d84                	ld	s1,24(a1)
 3da:	0205b903          	ld	s2,32(a1)
 3de:	0285b983          	ld	s3,40(a1)
 3e2:	0305ba03          	ld	s4,48(a1)
 3e6:	0385ba83          	ld	s5,56(a1)
 3ea:	0405bb03          	ld	s6,64(a1)
 3ee:	0485bb83          	ld	s7,72(a1)
 3f2:	0505bc03          	ld	s8,80(a1)
 3f6:	0585bc83          	ld	s9,88(a1)
 3fa:	0605bd03          	ld	s10,96(a1)
 3fe:	0685bd83          	ld	s11,104(a1)
 402:	8082                	ret

0000000000000404 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 404:	1101                	addi	sp,sp,-32
 406:	ec06                	sd	ra,24(sp)
 408:	e822                	sd	s0,16(sp)
 40a:	e426                	sd	s1,8(sp)
 40c:	e04a                	sd	s2,0(sp)
 40e:	1000                	addi	s0,sp,32
 410:	84aa                	mv	s1,a0
 412:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 414:	09800513          	li	a0,152
 418:	00000097          	auipc	ra,0x0
 41c:	6f4080e7          	jalr	1780(ra) # b0c <malloc>

    main_thread->tid = 1;
 420:	4785                	li	a5,1
 422:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 426:	4791                	li	a5,4
 428:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 42a:	00001797          	auipc	a5,0x1
 42e:	bea7b323          	sd	a0,-1050(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 432:	00001797          	auipc	a5,0x1
 436:	bee78793          	addi	a5,a5,-1042 # 1020 <threads>
 43a:	00001717          	auipc	a4,0x1
 43e:	c6670713          	addi	a4,a4,-922 # 10a0 <base>
        threads[i] = NULL;
 442:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 446:	07a1                	addi	a5,a5,8
 448:	fee79de3          	bne	a5,a4,442 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 44c:	00001797          	auipc	a5,0x1
 450:	bca7ba23          	sd	a0,-1068(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 454:	85ca                	mv	a1,s2
 456:	8526                	mv	a0,s1
 458:	00000097          	auipc	ra,0x0
 45c:	ba8080e7          	jalr	-1112(ra) # 0 <main>
    //tsched();

    exit(res);
 460:	00000097          	auipc	ra,0x0
 464:	274080e7          	jalr	628(ra) # 6d4 <exit>

0000000000000468 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 468:	1141                	addi	sp,sp,-16
 46a:	e422                	sd	s0,8(sp)
 46c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 46e:	87aa                	mv	a5,a0
 470:	0585                	addi	a1,a1,1
 472:	0785                	addi	a5,a5,1
 474:	fff5c703          	lbu	a4,-1(a1)
 478:	fee78fa3          	sb	a4,-1(a5)
 47c:	fb75                	bnez	a4,470 <strcpy+0x8>
        ;
    return os;
}
 47e:	6422                	ld	s0,8(sp)
 480:	0141                	addi	sp,sp,16
 482:	8082                	ret

0000000000000484 <strcmp>:

int strcmp(const char *p, const char *q)
{
 484:	1141                	addi	sp,sp,-16
 486:	e422                	sd	s0,8(sp)
 488:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 48a:	00054783          	lbu	a5,0(a0)
 48e:	cb91                	beqz	a5,4a2 <strcmp+0x1e>
 490:	0005c703          	lbu	a4,0(a1)
 494:	00f71763          	bne	a4,a5,4a2 <strcmp+0x1e>
        p++, q++;
 498:	0505                	addi	a0,a0,1
 49a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 49c:	00054783          	lbu	a5,0(a0)
 4a0:	fbe5                	bnez	a5,490 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4a2:	0005c503          	lbu	a0,0(a1)
}
 4a6:	40a7853b          	subw	a0,a5,a0
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <strlen>:

uint strlen(const char *s)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e422                	sd	s0,8(sp)
 4b4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	cf91                	beqz	a5,4d6 <strlen+0x26>
 4bc:	0505                	addi	a0,a0,1
 4be:	87aa                	mv	a5,a0
 4c0:	86be                	mv	a3,a5
 4c2:	0785                	addi	a5,a5,1
 4c4:	fff7c703          	lbu	a4,-1(a5)
 4c8:	ff65                	bnez	a4,4c0 <strlen+0x10>
 4ca:	40a6853b          	subw	a0,a3,a0
 4ce:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4d0:	6422                	ld	s0,8(sp)
 4d2:	0141                	addi	sp,sp,16
 4d4:	8082                	ret
    for (n = 0; s[n]; n++)
 4d6:	4501                	li	a0,0
 4d8:	bfe5                	j	4d0 <strlen+0x20>

00000000000004da <memset>:

void *
memset(void *dst, int c, uint n)
{
 4da:	1141                	addi	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4e0:	ca19                	beqz	a2,4f6 <memset+0x1c>
 4e2:	87aa                	mv	a5,a0
 4e4:	1602                	slli	a2,a2,0x20
 4e6:	9201                	srli	a2,a2,0x20
 4e8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4ec:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4f0:	0785                	addi	a5,a5,1
 4f2:	fee79de3          	bne	a5,a4,4ec <memset+0x12>
    }
    return dst;
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret

00000000000004fc <strchr>:

char *
strchr(const char *s, char c)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	addi	s0,sp,16
    for (; *s; s++)
 502:	00054783          	lbu	a5,0(a0)
 506:	cb99                	beqz	a5,51c <strchr+0x20>
        if (*s == c)
 508:	00f58763          	beq	a1,a5,516 <strchr+0x1a>
    for (; *s; s++)
 50c:	0505                	addi	a0,a0,1
 50e:	00054783          	lbu	a5,0(a0)
 512:	fbfd                	bnez	a5,508 <strchr+0xc>
            return (char *)s;
    return 0;
 514:	4501                	li	a0,0
}
 516:	6422                	ld	s0,8(sp)
 518:	0141                	addi	sp,sp,16
 51a:	8082                	ret
    return 0;
 51c:	4501                	li	a0,0
 51e:	bfe5                	j	516 <strchr+0x1a>

0000000000000520 <gets>:

char *
gets(char *buf, int max)
{
 520:	711d                	addi	sp,sp,-96
 522:	ec86                	sd	ra,88(sp)
 524:	e8a2                	sd	s0,80(sp)
 526:	e4a6                	sd	s1,72(sp)
 528:	e0ca                	sd	s2,64(sp)
 52a:	fc4e                	sd	s3,56(sp)
 52c:	f852                	sd	s4,48(sp)
 52e:	f456                	sd	s5,40(sp)
 530:	f05a                	sd	s6,32(sp)
 532:	ec5e                	sd	s7,24(sp)
 534:	1080                	addi	s0,sp,96
 536:	8baa                	mv	s7,a0
 538:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 53a:	892a                	mv	s2,a0
 53c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 53e:	4aa9                	li	s5,10
 540:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 542:	89a6                	mv	s3,s1
 544:	2485                	addiw	s1,s1,1
 546:	0344d863          	bge	s1,s4,576 <gets+0x56>
        cc = read(0, &c, 1);
 54a:	4605                	li	a2,1
 54c:	faf40593          	addi	a1,s0,-81
 550:	4501                	li	a0,0
 552:	00000097          	auipc	ra,0x0
 556:	19a080e7          	jalr	410(ra) # 6ec <read>
        if (cc < 1)
 55a:	00a05e63          	blez	a0,576 <gets+0x56>
        buf[i++] = c;
 55e:	faf44783          	lbu	a5,-81(s0)
 562:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 566:	01578763          	beq	a5,s5,574 <gets+0x54>
 56a:	0905                	addi	s2,s2,1
 56c:	fd679be3          	bne	a5,s6,542 <gets+0x22>
    for (i = 0; i + 1 < max;)
 570:	89a6                	mv	s3,s1
 572:	a011                	j	576 <gets+0x56>
 574:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 576:	99de                	add	s3,s3,s7
 578:	00098023          	sb	zero,0(s3)
    return buf;
}
 57c:	855e                	mv	a0,s7
 57e:	60e6                	ld	ra,88(sp)
 580:	6446                	ld	s0,80(sp)
 582:	64a6                	ld	s1,72(sp)
 584:	6906                	ld	s2,64(sp)
 586:	79e2                	ld	s3,56(sp)
 588:	7a42                	ld	s4,48(sp)
 58a:	7aa2                	ld	s5,40(sp)
 58c:	7b02                	ld	s6,32(sp)
 58e:	6be2                	ld	s7,24(sp)
 590:	6125                	addi	sp,sp,96
 592:	8082                	ret

0000000000000594 <stat>:

int stat(const char *n, struct stat *st)
{
 594:	1101                	addi	sp,sp,-32
 596:	ec06                	sd	ra,24(sp)
 598:	e822                	sd	s0,16(sp)
 59a:	e426                	sd	s1,8(sp)
 59c:	e04a                	sd	s2,0(sp)
 59e:	1000                	addi	s0,sp,32
 5a0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5a2:	4581                	li	a1,0
 5a4:	00000097          	auipc	ra,0x0
 5a8:	170080e7          	jalr	368(ra) # 714 <open>
    if (fd < 0)
 5ac:	02054563          	bltz	a0,5d6 <stat+0x42>
 5b0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5b2:	85ca                	mv	a1,s2
 5b4:	00000097          	auipc	ra,0x0
 5b8:	178080e7          	jalr	376(ra) # 72c <fstat>
 5bc:	892a                	mv	s2,a0
    close(fd);
 5be:	8526                	mv	a0,s1
 5c0:	00000097          	auipc	ra,0x0
 5c4:	13c080e7          	jalr	316(ra) # 6fc <close>
    return r;
}
 5c8:	854a                	mv	a0,s2
 5ca:	60e2                	ld	ra,24(sp)
 5cc:	6442                	ld	s0,16(sp)
 5ce:	64a2                	ld	s1,8(sp)
 5d0:	6902                	ld	s2,0(sp)
 5d2:	6105                	addi	sp,sp,32
 5d4:	8082                	ret
        return -1;
 5d6:	597d                	li	s2,-1
 5d8:	bfc5                	j	5c8 <stat+0x34>

00000000000005da <atoi>:

int atoi(const char *s)
{
 5da:	1141                	addi	sp,sp,-16
 5dc:	e422                	sd	s0,8(sp)
 5de:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5e0:	00054683          	lbu	a3,0(a0)
 5e4:	fd06879b          	addiw	a5,a3,-48
 5e8:	0ff7f793          	zext.b	a5,a5
 5ec:	4625                	li	a2,9
 5ee:	02f66863          	bltu	a2,a5,61e <atoi+0x44>
 5f2:	872a                	mv	a4,a0
    n = 0;
 5f4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5f6:	0705                	addi	a4,a4,1
 5f8:	0025179b          	slliw	a5,a0,0x2
 5fc:	9fa9                	addw	a5,a5,a0
 5fe:	0017979b          	slliw	a5,a5,0x1
 602:	9fb5                	addw	a5,a5,a3
 604:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 608:	00074683          	lbu	a3,0(a4)
 60c:	fd06879b          	addiw	a5,a3,-48
 610:	0ff7f793          	zext.b	a5,a5
 614:	fef671e3          	bgeu	a2,a5,5f6 <atoi+0x1c>
    return n;
}
 618:	6422                	ld	s0,8(sp)
 61a:	0141                	addi	sp,sp,16
 61c:	8082                	ret
    n = 0;
 61e:	4501                	li	a0,0
 620:	bfe5                	j	618 <atoi+0x3e>

0000000000000622 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 622:	1141                	addi	sp,sp,-16
 624:	e422                	sd	s0,8(sp)
 626:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 628:	02b57463          	bgeu	a0,a1,650 <memmove+0x2e>
    {
        while (n-- > 0)
 62c:	00c05f63          	blez	a2,64a <memmove+0x28>
 630:	1602                	slli	a2,a2,0x20
 632:	9201                	srli	a2,a2,0x20
 634:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 638:	872a                	mv	a4,a0
            *dst++ = *src++;
 63a:	0585                	addi	a1,a1,1
 63c:	0705                	addi	a4,a4,1
 63e:	fff5c683          	lbu	a3,-1(a1)
 642:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 646:	fee79ae3          	bne	a5,a4,63a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 64a:	6422                	ld	s0,8(sp)
 64c:	0141                	addi	sp,sp,16
 64e:	8082                	ret
        dst += n;
 650:	00c50733          	add	a4,a0,a2
        src += n;
 654:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 656:	fec05ae3          	blez	a2,64a <memmove+0x28>
 65a:	fff6079b          	addiw	a5,a2,-1
 65e:	1782                	slli	a5,a5,0x20
 660:	9381                	srli	a5,a5,0x20
 662:	fff7c793          	not	a5,a5
 666:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 668:	15fd                	addi	a1,a1,-1
 66a:	177d                	addi	a4,a4,-1
 66c:	0005c683          	lbu	a3,0(a1)
 670:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 674:	fee79ae3          	bne	a5,a4,668 <memmove+0x46>
 678:	bfc9                	j	64a <memmove+0x28>

000000000000067a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 67a:	1141                	addi	sp,sp,-16
 67c:	e422                	sd	s0,8(sp)
 67e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 680:	ca05                	beqz	a2,6b0 <memcmp+0x36>
 682:	fff6069b          	addiw	a3,a2,-1
 686:	1682                	slli	a3,a3,0x20
 688:	9281                	srli	a3,a3,0x20
 68a:	0685                	addi	a3,a3,1
 68c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 68e:	00054783          	lbu	a5,0(a0)
 692:	0005c703          	lbu	a4,0(a1)
 696:	00e79863          	bne	a5,a4,6a6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 69a:	0505                	addi	a0,a0,1
        p2++;
 69c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 69e:	fed518e3          	bne	a0,a3,68e <memcmp+0x14>
    }
    return 0;
 6a2:	4501                	li	a0,0
 6a4:	a019                	j	6aa <memcmp+0x30>
            return *p1 - *p2;
 6a6:	40e7853b          	subw	a0,a5,a4
}
 6aa:	6422                	ld	s0,8(sp)
 6ac:	0141                	addi	sp,sp,16
 6ae:	8082                	ret
    return 0;
 6b0:	4501                	li	a0,0
 6b2:	bfe5                	j	6aa <memcmp+0x30>

00000000000006b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6b4:	1141                	addi	sp,sp,-16
 6b6:	e406                	sd	ra,8(sp)
 6b8:	e022                	sd	s0,0(sp)
 6ba:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6bc:	00000097          	auipc	ra,0x0
 6c0:	f66080e7          	jalr	-154(ra) # 622 <memmove>
}
 6c4:	60a2                	ld	ra,8(sp)
 6c6:	6402                	ld	s0,0(sp)
 6c8:	0141                	addi	sp,sp,16
 6ca:	8082                	ret

00000000000006cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6cc:	4885                	li	a7,1
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6d4:	4889                	li	a7,2
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <wait>:
.global wait
wait:
 li a7, SYS_wait
 6dc:	488d                	li	a7,3
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6e4:	4891                	li	a7,4
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <read>:
.global read
read:
 li a7, SYS_read
 6ec:	4895                	li	a7,5
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <write>:
.global write
write:
 li a7, SYS_write
 6f4:	48c1                	li	a7,16
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <close>:
.global close
close:
 li a7, SYS_close
 6fc:	48d5                	li	a7,21
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <kill>:
.global kill
kill:
 li a7, SYS_kill
 704:	4899                	li	a7,6
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <exec>:
.global exec
exec:
 li a7, SYS_exec
 70c:	489d                	li	a7,7
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <open>:
.global open
open:
 li a7, SYS_open
 714:	48bd                	li	a7,15
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 71c:	48c5                	li	a7,17
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 724:	48c9                	li	a7,18
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 72c:	48a1                	li	a7,8
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <link>:
.global link
link:
 li a7, SYS_link
 734:	48cd                	li	a7,19
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 73c:	48d1                	li	a7,20
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 744:	48a5                	li	a7,9
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <dup>:
.global dup
dup:
 li a7, SYS_dup
 74c:	48a9                	li	a7,10
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 754:	48ad                	li	a7,11
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 75c:	48b1                	li	a7,12
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 764:	48b5                	li	a7,13
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 76c:	48b9                	li	a7,14
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <ps>:
.global ps
ps:
 li a7, SYS_ps
 774:	48d9                	li	a7,22
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 77c:	48dd                	li	a7,23
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 784:	48e1                	li	a7,24
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 78c:	1101                	addi	sp,sp,-32
 78e:	ec06                	sd	ra,24(sp)
 790:	e822                	sd	s0,16(sp)
 792:	1000                	addi	s0,sp,32
 794:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 798:	4605                	li	a2,1
 79a:	fef40593          	addi	a1,s0,-17
 79e:	00000097          	auipc	ra,0x0
 7a2:	f56080e7          	jalr	-170(ra) # 6f4 <write>
}
 7a6:	60e2                	ld	ra,24(sp)
 7a8:	6442                	ld	s0,16(sp)
 7aa:	6105                	addi	sp,sp,32
 7ac:	8082                	ret

00000000000007ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7ae:	7139                	addi	sp,sp,-64
 7b0:	fc06                	sd	ra,56(sp)
 7b2:	f822                	sd	s0,48(sp)
 7b4:	f426                	sd	s1,40(sp)
 7b6:	f04a                	sd	s2,32(sp)
 7b8:	ec4e                	sd	s3,24(sp)
 7ba:	0080                	addi	s0,sp,64
 7bc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7be:	c299                	beqz	a3,7c4 <printint+0x16>
 7c0:	0805c963          	bltz	a1,852 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7c4:	2581                	sext.w	a1,a1
  neg = 0;
 7c6:	4881                	li	a7,0
 7c8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7ce:	2601                	sext.w	a2,a2
 7d0:	00000517          	auipc	a0,0x0
 7d4:	4f050513          	addi	a0,a0,1264 # cc0 <digits>
 7d8:	883a                	mv	a6,a4
 7da:	2705                	addiw	a4,a4,1
 7dc:	02c5f7bb          	remuw	a5,a1,a2
 7e0:	1782                	slli	a5,a5,0x20
 7e2:	9381                	srli	a5,a5,0x20
 7e4:	97aa                	add	a5,a5,a0
 7e6:	0007c783          	lbu	a5,0(a5)
 7ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7ee:	0005879b          	sext.w	a5,a1
 7f2:	02c5d5bb          	divuw	a1,a1,a2
 7f6:	0685                	addi	a3,a3,1
 7f8:	fec7f0e3          	bgeu	a5,a2,7d8 <printint+0x2a>
  if(neg)
 7fc:	00088c63          	beqz	a7,814 <printint+0x66>
    buf[i++] = '-';
 800:	fd070793          	addi	a5,a4,-48
 804:	00878733          	add	a4,a5,s0
 808:	02d00793          	li	a5,45
 80c:	fef70823          	sb	a5,-16(a4)
 810:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 814:	02e05863          	blez	a4,844 <printint+0x96>
 818:	fc040793          	addi	a5,s0,-64
 81c:	00e78933          	add	s2,a5,a4
 820:	fff78993          	addi	s3,a5,-1
 824:	99ba                	add	s3,s3,a4
 826:	377d                	addiw	a4,a4,-1
 828:	1702                	slli	a4,a4,0x20
 82a:	9301                	srli	a4,a4,0x20
 82c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 830:	fff94583          	lbu	a1,-1(s2)
 834:	8526                	mv	a0,s1
 836:	00000097          	auipc	ra,0x0
 83a:	f56080e7          	jalr	-170(ra) # 78c <putc>
  while(--i >= 0)
 83e:	197d                	addi	s2,s2,-1
 840:	ff3918e3          	bne	s2,s3,830 <printint+0x82>
}
 844:	70e2                	ld	ra,56(sp)
 846:	7442                	ld	s0,48(sp)
 848:	74a2                	ld	s1,40(sp)
 84a:	7902                	ld	s2,32(sp)
 84c:	69e2                	ld	s3,24(sp)
 84e:	6121                	addi	sp,sp,64
 850:	8082                	ret
    x = -xx;
 852:	40b005bb          	negw	a1,a1
    neg = 1;
 856:	4885                	li	a7,1
    x = -xx;
 858:	bf85                	j	7c8 <printint+0x1a>

000000000000085a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 85a:	715d                	addi	sp,sp,-80
 85c:	e486                	sd	ra,72(sp)
 85e:	e0a2                	sd	s0,64(sp)
 860:	fc26                	sd	s1,56(sp)
 862:	f84a                	sd	s2,48(sp)
 864:	f44e                	sd	s3,40(sp)
 866:	f052                	sd	s4,32(sp)
 868:	ec56                	sd	s5,24(sp)
 86a:	e85a                	sd	s6,16(sp)
 86c:	e45e                	sd	s7,8(sp)
 86e:	e062                	sd	s8,0(sp)
 870:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 872:	0005c903          	lbu	s2,0(a1)
 876:	18090c63          	beqz	s2,a0e <vprintf+0x1b4>
 87a:	8aaa                	mv	s5,a0
 87c:	8bb2                	mv	s7,a2
 87e:	00158493          	addi	s1,a1,1
  state = 0;
 882:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 884:	02500a13          	li	s4,37
 888:	4b55                	li	s6,21
 88a:	a839                	j	8a8 <vprintf+0x4e>
        putc(fd, c);
 88c:	85ca                	mv	a1,s2
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	efc080e7          	jalr	-260(ra) # 78c <putc>
 898:	a019                	j	89e <vprintf+0x44>
    } else if(state == '%'){
 89a:	01498d63          	beq	s3,s4,8b4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 89e:	0485                	addi	s1,s1,1
 8a0:	fff4c903          	lbu	s2,-1(s1)
 8a4:	16090563          	beqz	s2,a0e <vprintf+0x1b4>
    if(state == 0){
 8a8:	fe0999e3          	bnez	s3,89a <vprintf+0x40>
      if(c == '%'){
 8ac:	ff4910e3          	bne	s2,s4,88c <vprintf+0x32>
        state = '%';
 8b0:	89d2                	mv	s3,s4
 8b2:	b7f5                	j	89e <vprintf+0x44>
      if(c == 'd'){
 8b4:	13490263          	beq	s2,s4,9d8 <vprintf+0x17e>
 8b8:	f9d9079b          	addiw	a5,s2,-99
 8bc:	0ff7f793          	zext.b	a5,a5
 8c0:	12fb6563          	bltu	s6,a5,9ea <vprintf+0x190>
 8c4:	f9d9079b          	addiw	a5,s2,-99
 8c8:	0ff7f713          	zext.b	a4,a5
 8cc:	10eb6f63          	bltu	s6,a4,9ea <vprintf+0x190>
 8d0:	00271793          	slli	a5,a4,0x2
 8d4:	00000717          	auipc	a4,0x0
 8d8:	39470713          	addi	a4,a4,916 # c68 <malloc+0x15c>
 8dc:	97ba                	add	a5,a5,a4
 8de:	439c                	lw	a5,0(a5)
 8e0:	97ba                	add	a5,a5,a4
 8e2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8e4:	008b8913          	addi	s2,s7,8
 8e8:	4685                	li	a3,1
 8ea:	4629                	li	a2,10
 8ec:	000ba583          	lw	a1,0(s7)
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	ebc080e7          	jalr	-324(ra) # 7ae <printint>
 8fa:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	b745                	j	89e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 900:	008b8913          	addi	s2,s7,8
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	000ba583          	lw	a1,0(s7)
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	ea0080e7          	jalr	-352(ra) # 7ae <printint>
 916:	8bca                	mv	s7,s2
      state = 0;
 918:	4981                	li	s3,0
 91a:	b751                	j	89e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 91c:	008b8913          	addi	s2,s7,8
 920:	4681                	li	a3,0
 922:	4641                	li	a2,16
 924:	000ba583          	lw	a1,0(s7)
 928:	8556                	mv	a0,s5
 92a:	00000097          	auipc	ra,0x0
 92e:	e84080e7          	jalr	-380(ra) # 7ae <printint>
 932:	8bca                	mv	s7,s2
      state = 0;
 934:	4981                	li	s3,0
 936:	b7a5                	j	89e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 938:	008b8c13          	addi	s8,s7,8
 93c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 940:	03000593          	li	a1,48
 944:	8556                	mv	a0,s5
 946:	00000097          	auipc	ra,0x0
 94a:	e46080e7          	jalr	-442(ra) # 78c <putc>
  putc(fd, 'x');
 94e:	07800593          	li	a1,120
 952:	8556                	mv	a0,s5
 954:	00000097          	auipc	ra,0x0
 958:	e38080e7          	jalr	-456(ra) # 78c <putc>
 95c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 95e:	00000b97          	auipc	s7,0x0
 962:	362b8b93          	addi	s7,s7,866 # cc0 <digits>
 966:	03c9d793          	srli	a5,s3,0x3c
 96a:	97de                	add	a5,a5,s7
 96c:	0007c583          	lbu	a1,0(a5)
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	e1a080e7          	jalr	-486(ra) # 78c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 97a:	0992                	slli	s3,s3,0x4
 97c:	397d                	addiw	s2,s2,-1
 97e:	fe0914e3          	bnez	s2,966 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 982:	8be2                	mv	s7,s8
      state = 0;
 984:	4981                	li	s3,0
 986:	bf21                	j	89e <vprintf+0x44>
        s = va_arg(ap, char*);
 988:	008b8993          	addi	s3,s7,8
 98c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 990:	02090163          	beqz	s2,9b2 <vprintf+0x158>
        while(*s != 0){
 994:	00094583          	lbu	a1,0(s2)
 998:	c9a5                	beqz	a1,a08 <vprintf+0x1ae>
          putc(fd, *s);
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	df0080e7          	jalr	-528(ra) # 78c <putc>
          s++;
 9a4:	0905                	addi	s2,s2,1
        while(*s != 0){
 9a6:	00094583          	lbu	a1,0(s2)
 9aa:	f9e5                	bnez	a1,99a <vprintf+0x140>
        s = va_arg(ap, char*);
 9ac:	8bce                	mv	s7,s3
      state = 0;
 9ae:	4981                	li	s3,0
 9b0:	b5fd                	j	89e <vprintf+0x44>
          s = "(null)";
 9b2:	00000917          	auipc	s2,0x0
 9b6:	2ae90913          	addi	s2,s2,686 # c60 <malloc+0x154>
        while(*s != 0){
 9ba:	02800593          	li	a1,40
 9be:	bff1                	j	99a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9c0:	008b8913          	addi	s2,s7,8
 9c4:	000bc583          	lbu	a1,0(s7)
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	dc2080e7          	jalr	-574(ra) # 78c <putc>
 9d2:	8bca                	mv	s7,s2
      state = 0;
 9d4:	4981                	li	s3,0
 9d6:	b5e1                	j	89e <vprintf+0x44>
        putc(fd, c);
 9d8:	02500593          	li	a1,37
 9dc:	8556                	mv	a0,s5
 9de:	00000097          	auipc	ra,0x0
 9e2:	dae080e7          	jalr	-594(ra) # 78c <putc>
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	bd5d                	j	89e <vprintf+0x44>
        putc(fd, '%');
 9ea:	02500593          	li	a1,37
 9ee:	8556                	mv	a0,s5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	d9c080e7          	jalr	-612(ra) # 78c <putc>
        putc(fd, c);
 9f8:	85ca                	mv	a1,s2
 9fa:	8556                	mv	a0,s5
 9fc:	00000097          	auipc	ra,0x0
 a00:	d90080e7          	jalr	-624(ra) # 78c <putc>
      state = 0;
 a04:	4981                	li	s3,0
 a06:	bd61                	j	89e <vprintf+0x44>
        s = va_arg(ap, char*);
 a08:	8bce                	mv	s7,s3
      state = 0;
 a0a:	4981                	li	s3,0
 a0c:	bd49                	j	89e <vprintf+0x44>
    }
  }
}
 a0e:	60a6                	ld	ra,72(sp)
 a10:	6406                	ld	s0,64(sp)
 a12:	74e2                	ld	s1,56(sp)
 a14:	7942                	ld	s2,48(sp)
 a16:	79a2                	ld	s3,40(sp)
 a18:	7a02                	ld	s4,32(sp)
 a1a:	6ae2                	ld	s5,24(sp)
 a1c:	6b42                	ld	s6,16(sp)
 a1e:	6ba2                	ld	s7,8(sp)
 a20:	6c02                	ld	s8,0(sp)
 a22:	6161                	addi	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a26:	715d                	addi	sp,sp,-80
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	addi	s0,sp,32
 a2e:	e010                	sd	a2,0(s0)
 a30:	e414                	sd	a3,8(s0)
 a32:	e818                	sd	a4,16(s0)
 a34:	ec1c                	sd	a5,24(s0)
 a36:	03043023          	sd	a6,32(s0)
 a3a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a3e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a42:	8622                	mv	a2,s0
 a44:	00000097          	auipc	ra,0x0
 a48:	e16080e7          	jalr	-490(ra) # 85a <vprintf>
}
 a4c:	60e2                	ld	ra,24(sp)
 a4e:	6442                	ld	s0,16(sp)
 a50:	6161                	addi	sp,sp,80
 a52:	8082                	ret

0000000000000a54 <printf>:

void
printf(const char *fmt, ...)
{
 a54:	711d                	addi	sp,sp,-96
 a56:	ec06                	sd	ra,24(sp)
 a58:	e822                	sd	s0,16(sp)
 a5a:	1000                	addi	s0,sp,32
 a5c:	e40c                	sd	a1,8(s0)
 a5e:	e810                	sd	a2,16(s0)
 a60:	ec14                	sd	a3,24(s0)
 a62:	f018                	sd	a4,32(s0)
 a64:	f41c                	sd	a5,40(s0)
 a66:	03043823          	sd	a6,48(s0)
 a6a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a6e:	00840613          	addi	a2,s0,8
 a72:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a76:	85aa                	mv	a1,a0
 a78:	4505                	li	a0,1
 a7a:	00000097          	auipc	ra,0x0
 a7e:	de0080e7          	jalr	-544(ra) # 85a <vprintf>
}
 a82:	60e2                	ld	ra,24(sp)
 a84:	6442                	ld	s0,16(sp)
 a86:	6125                	addi	sp,sp,96
 a88:	8082                	ret

0000000000000a8a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a8a:	1141                	addi	sp,sp,-16
 a8c:	e422                	sd	s0,8(sp)
 a8e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a90:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a94:	00000797          	auipc	a5,0x0
 a98:	5847b783          	ld	a5,1412(a5) # 1018 <freep>
 a9c:	a02d                	j	ac6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a9e:	4618                	lw	a4,8(a2)
 aa0:	9f2d                	addw	a4,a4,a1
 aa2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aa6:	6398                	ld	a4,0(a5)
 aa8:	6310                	ld	a2,0(a4)
 aaa:	a83d                	j	ae8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 aac:	ff852703          	lw	a4,-8(a0)
 ab0:	9f31                	addw	a4,a4,a2
 ab2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ab4:	ff053683          	ld	a3,-16(a0)
 ab8:	a091                	j	afc <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aba:	6398                	ld	a4,0(a5)
 abc:	00e7e463          	bltu	a5,a4,ac4 <free+0x3a>
 ac0:	00e6ea63          	bltu	a3,a4,ad4 <free+0x4a>
{
 ac4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac6:	fed7fae3          	bgeu	a5,a3,aba <free+0x30>
 aca:	6398                	ld	a4,0(a5)
 acc:	00e6e463          	bltu	a3,a4,ad4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	fee7eae3          	bltu	a5,a4,ac4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ad4:	ff852583          	lw	a1,-8(a0)
 ad8:	6390                	ld	a2,0(a5)
 ada:	02059813          	slli	a6,a1,0x20
 ade:	01c85713          	srli	a4,a6,0x1c
 ae2:	9736                	add	a4,a4,a3
 ae4:	fae60de3          	beq	a2,a4,a9e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ae8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 aec:	4790                	lw	a2,8(a5)
 aee:	02061593          	slli	a1,a2,0x20
 af2:	01c5d713          	srli	a4,a1,0x1c
 af6:	973e                	add	a4,a4,a5
 af8:	fae68ae3          	beq	a3,a4,aac <free+0x22>
        p->s.ptr = bp->s.ptr;
 afc:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 afe:	00000717          	auipc	a4,0x0
 b02:	50f73d23          	sd	a5,1306(a4) # 1018 <freep>
}
 b06:	6422                	ld	s0,8(sp)
 b08:	0141                	addi	sp,sp,16
 b0a:	8082                	ret

0000000000000b0c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b0c:	7139                	addi	sp,sp,-64
 b0e:	fc06                	sd	ra,56(sp)
 b10:	f822                	sd	s0,48(sp)
 b12:	f426                	sd	s1,40(sp)
 b14:	f04a                	sd	s2,32(sp)
 b16:	ec4e                	sd	s3,24(sp)
 b18:	e852                	sd	s4,16(sp)
 b1a:	e456                	sd	s5,8(sp)
 b1c:	e05a                	sd	s6,0(sp)
 b1e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b20:	02051493          	slli	s1,a0,0x20
 b24:	9081                	srli	s1,s1,0x20
 b26:	04bd                	addi	s1,s1,15
 b28:	8091                	srli	s1,s1,0x4
 b2a:	0014899b          	addiw	s3,s1,1
 b2e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b30:	00000517          	auipc	a0,0x0
 b34:	4e853503          	ld	a0,1256(a0) # 1018 <freep>
 b38:	c515                	beqz	a0,b64 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b3a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b3c:	4798                	lw	a4,8(a5)
 b3e:	02977f63          	bgeu	a4,s1,b7c <malloc+0x70>
    if (nu < 4096)
 b42:	8a4e                	mv	s4,s3
 b44:	0009871b          	sext.w	a4,s3
 b48:	6685                	lui	a3,0x1
 b4a:	00d77363          	bgeu	a4,a3,b50 <malloc+0x44>
 b4e:	6a05                	lui	s4,0x1
 b50:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b54:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b58:	00000917          	auipc	s2,0x0
 b5c:	4c090913          	addi	s2,s2,1216 # 1018 <freep>
    if (p == (char *)-1)
 b60:	5afd                	li	s5,-1
 b62:	a895                	j	bd6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b64:	00000797          	auipc	a5,0x0
 b68:	53c78793          	addi	a5,a5,1340 # 10a0 <base>
 b6c:	00000717          	auipc	a4,0x0
 b70:	4af73623          	sd	a5,1196(a4) # 1018 <freep>
 b74:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b76:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b7a:	b7e1                	j	b42 <malloc+0x36>
            if (p->s.size == nunits)
 b7c:	02e48c63          	beq	s1,a4,bb4 <malloc+0xa8>
                p->s.size -= nunits;
 b80:	4137073b          	subw	a4,a4,s3
 b84:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b86:	02071693          	slli	a3,a4,0x20
 b8a:	01c6d713          	srli	a4,a3,0x1c
 b8e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b90:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b94:	00000717          	auipc	a4,0x0
 b98:	48a73223          	sd	a0,1156(a4) # 1018 <freep>
            return (void *)(p + 1);
 b9c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ba0:	70e2                	ld	ra,56(sp)
 ba2:	7442                	ld	s0,48(sp)
 ba4:	74a2                	ld	s1,40(sp)
 ba6:	7902                	ld	s2,32(sp)
 ba8:	69e2                	ld	s3,24(sp)
 baa:	6a42                	ld	s4,16(sp)
 bac:	6aa2                	ld	s5,8(sp)
 bae:	6b02                	ld	s6,0(sp)
 bb0:	6121                	addi	sp,sp,64
 bb2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bb4:	6398                	ld	a4,0(a5)
 bb6:	e118                	sd	a4,0(a0)
 bb8:	bff1                	j	b94 <malloc+0x88>
    hp->s.size = nu;
 bba:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bbe:	0541                	addi	a0,a0,16
 bc0:	00000097          	auipc	ra,0x0
 bc4:	eca080e7          	jalr	-310(ra) # a8a <free>
    return freep;
 bc8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bcc:	d971                	beqz	a0,ba0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bce:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bd0:	4798                	lw	a4,8(a5)
 bd2:	fa9775e3          	bgeu	a4,s1,b7c <malloc+0x70>
        if (p == freep)
 bd6:	00093703          	ld	a4,0(s2)
 bda:	853e                	mv	a0,a5
 bdc:	fef719e3          	bne	a4,a5,bce <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 be0:	8552                	mv	a0,s4
 be2:	00000097          	auipc	ra,0x0
 be6:	b7a080e7          	jalr	-1158(ra) # 75c <sbrk>
    if (p == (char *)-1)
 bea:	fd5518e3          	bne	a0,s5,bba <malloc+0xae>
                return 0;
 bee:	4501                	li	a0,0
 bf0:	bf45                	j	ba0 <malloc+0x94>
