
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
   e:	02a7d763          	bge	a5,a0,3c <main+0x3c>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	6e4080e7          	jalr	1764(ra) # 70c <unlink>
  30:	02054463          	bltz	a0,58 <main+0x58>
  for(i = 1; i < argc; i++){
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a80d                	j	6c <main+0x6c>
    fprintf(2, "Usage: rm files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	ba458593          	addi	a1,a1,-1116 # be0 <malloc+0xec>
  44:	4509                	li	a0,2
  46:	00001097          	auipc	ra,0x1
  4a:	9c8080e7          	jalr	-1592(ra) # a0e <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	66c080e7          	jalr	1644(ra) # 6bc <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  58:	6090                	ld	a2,0(s1)
  5a:	00001597          	auipc	a1,0x1
  5e:	b9e58593          	addi	a1,a1,-1122 # bf8 <malloc+0x104>
  62:	4509                	li	a0,2
  64:	00001097          	auipc	ra,0x1
  68:	9aa080e7          	jalr	-1622(ra) # a0e <fprintf>
      break;
    }
  }

  exit(0);
  6c:	4501                	li	a0,0
  6e:	00000097          	auipc	ra,0x0
  72:	64e080e7          	jalr	1614(ra) # 6bc <exit>

0000000000000076 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
    lk->name = name;
  7c:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  7e:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  82:	57fd                	li	a5,-1
  84:	00f50823          	sb	a5,16(a0)
}
  88:	6422                	ld	s0,8(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret

000000000000008e <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  8e:	00054783          	lbu	a5,0(a0)
  92:	e399                	bnez	a5,98 <holding+0xa>
  94:	4501                	li	a0,0
}
  96:	8082                	ret
{
  98:	1101                	addi	sp,sp,-32
  9a:	ec06                	sd	ra,24(sp)
  9c:	e822                	sd	s0,16(sp)
  9e:	e426                	sd	s1,8(sp)
  a0:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  a2:	01054483          	lbu	s1,16(a0)
  a6:	00000097          	auipc	ra,0x0
  aa:	2c4080e7          	jalr	708(ra) # 36a <twhoami>
  ae:	2501                	sext.w	a0,a0
  b0:	40a48533          	sub	a0,s1,a0
  b4:	00153513          	seqz	a0,a0
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6105                	addi	sp,sp,32
  c0:	8082                	ret

00000000000000c2 <acquire>:

void acquire(struct lock *lk)
{
  c2:	7179                	addi	sp,sp,-48
  c4:	f406                	sd	ra,40(sp)
  c6:	f022                	sd	s0,32(sp)
  c8:	ec26                	sd	s1,24(sp)
  ca:	e84a                	sd	s2,16(sp)
  cc:	e44e                	sd	s3,8(sp)
  ce:	e052                	sd	s4,0(sp)
  d0:	1800                	addi	s0,sp,48
  d2:	8a2a                	mv	s4,a0
    if (holding(lk))
  d4:	00000097          	auipc	ra,0x0
  d8:	fba080e7          	jalr	-70(ra) # 8e <holding>
  dc:	e919                	bnez	a0,f2 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  de:	ffca7493          	andi	s1,s4,-4
  e2:	003a7913          	andi	s2,s4,3
  e6:	0039191b          	slliw	s2,s2,0x3
  ea:	4985                	li	s3,1
  ec:	012999bb          	sllw	s3,s3,s2
  f0:	a015                	j	114 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  f2:	00001517          	auipc	a0,0x1
  f6:	b2650513          	addi	a0,a0,-1242 # c18 <malloc+0x124>
  fa:	00001097          	auipc	ra,0x1
  fe:	942080e7          	jalr	-1726(ra) # a3c <printf>
        exit(-1);
 102:	557d                	li	a0,-1
 104:	00000097          	auipc	ra,0x0
 108:	5b8080e7          	jalr	1464(ra) # 6bc <exit>
    {
        // give up the cpu for other threads
        tyield();
 10c:	00000097          	auipc	ra,0x0
 110:	1dc080e7          	jalr	476(ra) # 2e8 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 114:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 118:	0127d7bb          	srlw	a5,a5,s2
 11c:	0ff7f793          	zext.b	a5,a5
 120:	f7f5                	bnez	a5,10c <acquire+0x4a>
    }

    __sync_synchronize();
 122:	0ff0000f          	fence

    lk->tid = twhoami();
 126:	00000097          	auipc	ra,0x0
 12a:	244080e7          	jalr	580(ra) # 36a <twhoami>
 12e:	00aa0823          	sb	a0,16(s4)
}
 132:	70a2                	ld	ra,40(sp)
 134:	7402                	ld	s0,32(sp)
 136:	64e2                	ld	s1,24(sp)
 138:	6942                	ld	s2,16(sp)
 13a:	69a2                	ld	s3,8(sp)
 13c:	6a02                	ld	s4,0(sp)
 13e:	6145                	addi	sp,sp,48
 140:	8082                	ret

0000000000000142 <release>:

void release(struct lock *lk)
{
 142:	1101                	addi	sp,sp,-32
 144:	ec06                	sd	ra,24(sp)
 146:	e822                	sd	s0,16(sp)
 148:	e426                	sd	s1,8(sp)
 14a:	1000                	addi	s0,sp,32
 14c:	84aa                	mv	s1,a0
    if (!holding(lk))
 14e:	00000097          	auipc	ra,0x0
 152:	f40080e7          	jalr	-192(ra) # 8e <holding>
 156:	c11d                	beqz	a0,17c <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 158:	57fd                	li	a5,-1
 15a:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 15e:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 162:	0ff0000f          	fence
 166:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 16a:	00000097          	auipc	ra,0x0
 16e:	17e080e7          	jalr	382(ra) # 2e8 <tyield>
}
 172:	60e2                	ld	ra,24(sp)
 174:	6442                	ld	s0,16(sp)
 176:	64a2                	ld	s1,8(sp)
 178:	6105                	addi	sp,sp,32
 17a:	8082                	ret
        printf("releasing lock we are not holding");
 17c:	00001517          	auipc	a0,0x1
 180:	ac450513          	addi	a0,a0,-1340 # c40 <malloc+0x14c>
 184:	00001097          	auipc	ra,0x1
 188:	8b8080e7          	jalr	-1864(ra) # a3c <printf>
        exit(-1);
 18c:	557d                	li	a0,-1
 18e:	00000097          	auipc	ra,0x0
 192:	52e080e7          	jalr	1326(ra) # 6bc <exit>

0000000000000196 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 196:	00001517          	auipc	a0,0x1
 19a:	e7a53503          	ld	a0,-390(a0) # 1010 <current_thread>
 19e:	00001717          	auipc	a4,0x1
 1a2:	e8270713          	addi	a4,a4,-382 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1a6:	4781                	li	a5,0
 1a8:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1aa:	6314                	ld	a3,0(a4)
 1ac:	00a68763          	beq	a3,a0,1ba <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1b0:	2785                	addiw	a5,a5,1
 1b2:	0721                	addi	a4,a4,8
 1b4:	fec79be3          	bne	a5,a2,1aa <tsched+0x14>
    int current_index = 0;
 1b8:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1ba:	0017869b          	addiw	a3,a5,1
 1be:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1c2:	00001817          	auipc	a6,0x1
 1c6:	e5e80813          	addi	a6,a6,-418 # 1020 <threads>
 1ca:	488d                	li	a7,3
 1cc:	a021                	j	1d4 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1ce:	2685                	addiw	a3,a3,1
 1d0:	04c68363          	beq	a3,a2,216 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1d4:	41f6d71b          	sraiw	a4,a3,0x1f
 1d8:	01c7571b          	srliw	a4,a4,0x1c
 1dc:	00d707bb          	addw	a5,a4,a3
 1e0:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1e2:	9f99                	subw	a5,a5,a4
 1e4:	078e                	slli	a5,a5,0x3
 1e6:	97c2                	add	a5,a5,a6
 1e8:	638c                	ld	a1,0(a5)
 1ea:	d1f5                	beqz	a1,1ce <tsched+0x38>
 1ec:	5dbc                	lw	a5,120(a1)
 1ee:	ff1790e3          	bne	a5,a7,1ce <tsched+0x38>
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e406                	sd	ra,8(sp)
 1f6:	e022                	sd	s0,0(sp)
 1f8:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1fa:	00001797          	auipc	a5,0x1
 1fe:	e0b7bb23          	sd	a1,-490(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 202:	05a1                	addi	a1,a1,8
 204:	0521                	addi	a0,a0,8
 206:	00000097          	auipc	ra,0x0
 20a:	17c080e7          	jalr	380(ra) # 382 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 20e:	60a2                	ld	ra,8(sp)
 210:	6402                	ld	s0,0(sp)
 212:	0141                	addi	sp,sp,16
 214:	8082                	ret
 216:	8082                	ret

0000000000000218 <thread_wrapper>:
{
 218:	1101                	addi	sp,sp,-32
 21a:	ec06                	sd	ra,24(sp)
 21c:	e822                	sd	s0,16(sp)
 21e:	e426                	sd	s1,8(sp)
 220:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 222:	00001497          	auipc	s1,0x1
 226:	dee48493          	addi	s1,s1,-530 # 1010 <current_thread>
 22a:	609c                	ld	a5,0(s1)
 22c:	67d8                	ld	a4,136(a5)
 22e:	63c8                	ld	a0,128(a5)
 230:	9702                	jalr	a4
    current_thread->state = EXITED;
 232:	609c                	ld	a5,0(s1)
 234:	4719                	li	a4,6
 236:	dfb8                	sw	a4,120(a5)
    tsched();
 238:	00000097          	auipc	ra,0x0
 23c:	f5e080e7          	jalr	-162(ra) # 196 <tsched>
}
 240:	60e2                	ld	ra,24(sp)
 242:	6442                	ld	s0,16(sp)
 244:	64a2                	ld	s1,8(sp)
 246:	6105                	addi	sp,sp,32
 248:	8082                	ret

000000000000024a <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 24a:	7179                	addi	sp,sp,-48
 24c:	f406                	sd	ra,40(sp)
 24e:	f022                	sd	s0,32(sp)
 250:	ec26                	sd	s1,24(sp)
 252:	e84a                	sd	s2,16(sp)
 254:	e44e                	sd	s3,8(sp)
 256:	1800                	addi	s0,sp,48
 258:	84aa                	mv	s1,a0
 25a:	89b2                	mv	s3,a2
 25c:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 25e:	09800513          	li	a0,152
 262:	00001097          	auipc	ra,0x1
 266:	892080e7          	jalr	-1902(ra) # af4 <malloc>
 26a:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 26c:	478d                	li	a5,3
 26e:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 270:	609c                	ld	a5,0(s1)
 272:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 276:	609c                	ld	a5,0(s1)
 278:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 27c:	6098                	ld	a4,0(s1)
 27e:	00001797          	auipc	a5,0x1
 282:	d8278793          	addi	a5,a5,-638 # 1000 <next_tid>
 286:	4394                	lw	a3,0(a5)
 288:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 28c:	4398                	lw	a4,0(a5)
 28e:	2705                	addiw	a4,a4,1
 290:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 292:	6505                	lui	a0,0x1
 294:	00001097          	auipc	ra,0x1
 298:	860080e7          	jalr	-1952(ra) # af4 <malloc>
 29c:	609c                	ld	a5,0(s1)
 29e:	6705                	lui	a4,0x1
 2a0:	953a                	add	a0,a0,a4
 2a2:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2a4:	609c                	ld	a5,0(s1)
 2a6:	00000717          	auipc	a4,0x0
 2aa:	f7270713          	addi	a4,a4,-142 # 218 <thread_wrapper>
 2ae:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2b0:	00001717          	auipc	a4,0x1
 2b4:	d7070713          	addi	a4,a4,-656 # 1020 <threads>
 2b8:	4781                	li	a5,0
 2ba:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2bc:	6314                	ld	a3,0(a4)
 2be:	ce81                	beqz	a3,2d6 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2c0:	2785                	addiw	a5,a5,1
 2c2:	0721                	addi	a4,a4,8
 2c4:	fec79ce3          	bne	a5,a2,2bc <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2c8:	70a2                	ld	ra,40(sp)
 2ca:	7402                	ld	s0,32(sp)
 2cc:	64e2                	ld	s1,24(sp)
 2ce:	6942                	ld	s2,16(sp)
 2d0:	69a2                	ld	s3,8(sp)
 2d2:	6145                	addi	sp,sp,48
 2d4:	8082                	ret
            threads[i] = *thread;
 2d6:	6094                	ld	a3,0(s1)
 2d8:	078e                	slli	a5,a5,0x3
 2da:	00001717          	auipc	a4,0x1
 2de:	d4670713          	addi	a4,a4,-698 # 1020 <threads>
 2e2:	97ba                	add	a5,a5,a4
 2e4:	e394                	sd	a3,0(a5)
            break;
 2e6:	b7cd                	j	2c8 <tcreate+0x7e>

00000000000002e8 <tyield>:
    return 0;
}


void tyield()
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e406                	sd	ra,8(sp)
 2ec:	e022                	sd	s0,0(sp)
 2ee:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2f0:	00001797          	auipc	a5,0x1
 2f4:	d207b783          	ld	a5,-736(a5) # 1010 <current_thread>
 2f8:	470d                	li	a4,3
 2fa:	dfb8                	sw	a4,120(a5)
    tsched();
 2fc:	00000097          	auipc	ra,0x0
 300:	e9a080e7          	jalr	-358(ra) # 196 <tsched>
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <tjoin>:
{
 30c:	1101                	addi	sp,sp,-32
 30e:	ec06                	sd	ra,24(sp)
 310:	e822                	sd	s0,16(sp)
 312:	e426                	sd	s1,8(sp)
 314:	e04a                	sd	s2,0(sp)
 316:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 318:	00001797          	auipc	a5,0x1
 31c:	d0878793          	addi	a5,a5,-760 # 1020 <threads>
 320:	00001697          	auipc	a3,0x1
 324:	d8068693          	addi	a3,a3,-640 # 10a0 <base>
 328:	a021                	j	330 <tjoin+0x24>
 32a:	07a1                	addi	a5,a5,8
 32c:	02d78b63          	beq	a5,a3,362 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 330:	6384                	ld	s1,0(a5)
 332:	dce5                	beqz	s1,32a <tjoin+0x1e>
 334:	0004c703          	lbu	a4,0(s1)
 338:	fea719e3          	bne	a4,a0,32a <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 33c:	5cb8                	lw	a4,120(s1)
 33e:	4799                	li	a5,6
 340:	4919                	li	s2,6
 342:	02f70263          	beq	a4,a5,366 <tjoin+0x5a>
        tyield();
 346:	00000097          	auipc	ra,0x0
 34a:	fa2080e7          	jalr	-94(ra) # 2e8 <tyield>
    while (target_thread->state != EXITED) {
 34e:	5cbc                	lw	a5,120(s1)
 350:	ff279be3          	bne	a5,s2,346 <tjoin+0x3a>
    return 0;
 354:	4501                	li	a0,0
}
 356:	60e2                	ld	ra,24(sp)
 358:	6442                	ld	s0,16(sp)
 35a:	64a2                	ld	s1,8(sp)
 35c:	6902                	ld	s2,0(sp)
 35e:	6105                	addi	sp,sp,32
 360:	8082                	ret
        return -1;
 362:	557d                	li	a0,-1
 364:	bfcd                	j	356 <tjoin+0x4a>
    return 0;
 366:	4501                	li	a0,0
 368:	b7fd                	j	356 <tjoin+0x4a>

000000000000036a <twhoami>:

uint8 twhoami()
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 370:	00001797          	auipc	a5,0x1
 374:	ca07b783          	ld	a5,-864(a5) # 1010 <current_thread>
 378:	0007c503          	lbu	a0,0(a5)
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <tswtch>:
 382:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 386:	00253423          	sd	sp,8(a0)
 38a:	e900                	sd	s0,16(a0)
 38c:	ed04                	sd	s1,24(a0)
 38e:	03253023          	sd	s2,32(a0)
 392:	03353423          	sd	s3,40(a0)
 396:	03453823          	sd	s4,48(a0)
 39a:	03553c23          	sd	s5,56(a0)
 39e:	05653023          	sd	s6,64(a0)
 3a2:	05753423          	sd	s7,72(a0)
 3a6:	05853823          	sd	s8,80(a0)
 3aa:	05953c23          	sd	s9,88(a0)
 3ae:	07a53023          	sd	s10,96(a0)
 3b2:	07b53423          	sd	s11,104(a0)
 3b6:	0005b083          	ld	ra,0(a1)
 3ba:	0085b103          	ld	sp,8(a1)
 3be:	6980                	ld	s0,16(a1)
 3c0:	6d84                	ld	s1,24(a1)
 3c2:	0205b903          	ld	s2,32(a1)
 3c6:	0285b983          	ld	s3,40(a1)
 3ca:	0305ba03          	ld	s4,48(a1)
 3ce:	0385ba83          	ld	s5,56(a1)
 3d2:	0405bb03          	ld	s6,64(a1)
 3d6:	0485bb83          	ld	s7,72(a1)
 3da:	0505bc03          	ld	s8,80(a1)
 3de:	0585bc83          	ld	s9,88(a1)
 3e2:	0605bd03          	ld	s10,96(a1)
 3e6:	0685bd83          	ld	s11,104(a1)
 3ea:	8082                	ret

00000000000003ec <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3ec:	1101                	addi	sp,sp,-32
 3ee:	ec06                	sd	ra,24(sp)
 3f0:	e822                	sd	s0,16(sp)
 3f2:	e426                	sd	s1,8(sp)
 3f4:	e04a                	sd	s2,0(sp)
 3f6:	1000                	addi	s0,sp,32
 3f8:	84aa                	mv	s1,a0
 3fa:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3fc:	09800513          	li	a0,152
 400:	00000097          	auipc	ra,0x0
 404:	6f4080e7          	jalr	1780(ra) # af4 <malloc>

    main_thread->tid = 1;
 408:	4785                	li	a5,1
 40a:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 40e:	4791                	li	a5,4
 410:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 412:	00001797          	auipc	a5,0x1
 416:	bea7bf23          	sd	a0,-1026(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 41a:	00001797          	auipc	a5,0x1
 41e:	c0678793          	addi	a5,a5,-1018 # 1020 <threads>
 422:	00001717          	auipc	a4,0x1
 426:	c7e70713          	addi	a4,a4,-898 # 10a0 <base>
        threads[i] = NULL;
 42a:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 42e:	07a1                	addi	a5,a5,8
 430:	fee79de3          	bne	a5,a4,42a <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 434:	00001797          	auipc	a5,0x1
 438:	bea7b623          	sd	a0,-1044(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 43c:	85ca                	mv	a1,s2
 43e:	8526                	mv	a0,s1
 440:	00000097          	auipc	ra,0x0
 444:	bc0080e7          	jalr	-1088(ra) # 0 <main>
    //tsched();

    exit(res);
 448:	00000097          	auipc	ra,0x0
 44c:	274080e7          	jalr	628(ra) # 6bc <exit>

0000000000000450 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 450:	1141                	addi	sp,sp,-16
 452:	e422                	sd	s0,8(sp)
 454:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 456:	87aa                	mv	a5,a0
 458:	0585                	addi	a1,a1,1
 45a:	0785                	addi	a5,a5,1
 45c:	fff5c703          	lbu	a4,-1(a1)
 460:	fee78fa3          	sb	a4,-1(a5)
 464:	fb75                	bnez	a4,458 <strcpy+0x8>
        ;
    return os;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <strcmp>:

int strcmp(const char *p, const char *q)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 472:	00054783          	lbu	a5,0(a0)
 476:	cb91                	beqz	a5,48a <strcmp+0x1e>
 478:	0005c703          	lbu	a4,0(a1)
 47c:	00f71763          	bne	a4,a5,48a <strcmp+0x1e>
        p++, q++;
 480:	0505                	addi	a0,a0,1
 482:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 484:	00054783          	lbu	a5,0(a0)
 488:	fbe5                	bnez	a5,478 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 48a:	0005c503          	lbu	a0,0(a1)
}
 48e:	40a7853b          	subw	a0,a5,a0
 492:	6422                	ld	s0,8(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <strlen>:

uint strlen(const char *s)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	cf91                	beqz	a5,4be <strlen+0x26>
 4a4:	0505                	addi	a0,a0,1
 4a6:	87aa                	mv	a5,a0
 4a8:	86be                	mv	a3,a5
 4aa:	0785                	addi	a5,a5,1
 4ac:	fff7c703          	lbu	a4,-1(a5)
 4b0:	ff65                	bnez	a4,4a8 <strlen+0x10>
 4b2:	40a6853b          	subw	a0,a3,a0
 4b6:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4b8:	6422                	ld	s0,8(sp)
 4ba:	0141                	addi	sp,sp,16
 4bc:	8082                	ret
    for (n = 0; s[n]; n++)
 4be:	4501                	li	a0,0
 4c0:	bfe5                	j	4b8 <strlen+0x20>

00000000000004c2 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4c2:	1141                	addi	sp,sp,-16
 4c4:	e422                	sd	s0,8(sp)
 4c6:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4c8:	ca19                	beqz	a2,4de <memset+0x1c>
 4ca:	87aa                	mv	a5,a0
 4cc:	1602                	slli	a2,a2,0x20
 4ce:	9201                	srli	a2,a2,0x20
 4d0:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4d4:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4d8:	0785                	addi	a5,a5,1
 4da:	fee79de3          	bne	a5,a4,4d4 <memset+0x12>
    }
    return dst;
}
 4de:	6422                	ld	s0,8(sp)
 4e0:	0141                	addi	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <strchr>:

char *
strchr(const char *s, char c)
{
 4e4:	1141                	addi	sp,sp,-16
 4e6:	e422                	sd	s0,8(sp)
 4e8:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	cb99                	beqz	a5,504 <strchr+0x20>
        if (*s == c)
 4f0:	00f58763          	beq	a1,a5,4fe <strchr+0x1a>
    for (; *s; s++)
 4f4:	0505                	addi	a0,a0,1
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	fbfd                	bnez	a5,4f0 <strchr+0xc>
            return (char *)s;
    return 0;
 4fc:	4501                	li	a0,0
}
 4fe:	6422                	ld	s0,8(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret
    return 0;
 504:	4501                	li	a0,0
 506:	bfe5                	j	4fe <strchr+0x1a>

0000000000000508 <gets>:

char *
gets(char *buf, int max)
{
 508:	711d                	addi	sp,sp,-96
 50a:	ec86                	sd	ra,88(sp)
 50c:	e8a2                	sd	s0,80(sp)
 50e:	e4a6                	sd	s1,72(sp)
 510:	e0ca                	sd	s2,64(sp)
 512:	fc4e                	sd	s3,56(sp)
 514:	f852                	sd	s4,48(sp)
 516:	f456                	sd	s5,40(sp)
 518:	f05a                	sd	s6,32(sp)
 51a:	ec5e                	sd	s7,24(sp)
 51c:	1080                	addi	s0,sp,96
 51e:	8baa                	mv	s7,a0
 520:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 522:	892a                	mv	s2,a0
 524:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 526:	4aa9                	li	s5,10
 528:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 52a:	89a6                	mv	s3,s1
 52c:	2485                	addiw	s1,s1,1
 52e:	0344d863          	bge	s1,s4,55e <gets+0x56>
        cc = read(0, &c, 1);
 532:	4605                	li	a2,1
 534:	faf40593          	addi	a1,s0,-81
 538:	4501                	li	a0,0
 53a:	00000097          	auipc	ra,0x0
 53e:	19a080e7          	jalr	410(ra) # 6d4 <read>
        if (cc < 1)
 542:	00a05e63          	blez	a0,55e <gets+0x56>
        buf[i++] = c;
 546:	faf44783          	lbu	a5,-81(s0)
 54a:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 54e:	01578763          	beq	a5,s5,55c <gets+0x54>
 552:	0905                	addi	s2,s2,1
 554:	fd679be3          	bne	a5,s6,52a <gets+0x22>
    for (i = 0; i + 1 < max;)
 558:	89a6                	mv	s3,s1
 55a:	a011                	j	55e <gets+0x56>
 55c:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 55e:	99de                	add	s3,s3,s7
 560:	00098023          	sb	zero,0(s3)
    return buf;
}
 564:	855e                	mv	a0,s7
 566:	60e6                	ld	ra,88(sp)
 568:	6446                	ld	s0,80(sp)
 56a:	64a6                	ld	s1,72(sp)
 56c:	6906                	ld	s2,64(sp)
 56e:	79e2                	ld	s3,56(sp)
 570:	7a42                	ld	s4,48(sp)
 572:	7aa2                	ld	s5,40(sp)
 574:	7b02                	ld	s6,32(sp)
 576:	6be2                	ld	s7,24(sp)
 578:	6125                	addi	sp,sp,96
 57a:	8082                	ret

000000000000057c <stat>:

int stat(const char *n, struct stat *st)
{
 57c:	1101                	addi	sp,sp,-32
 57e:	ec06                	sd	ra,24(sp)
 580:	e822                	sd	s0,16(sp)
 582:	e426                	sd	s1,8(sp)
 584:	e04a                	sd	s2,0(sp)
 586:	1000                	addi	s0,sp,32
 588:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 58a:	4581                	li	a1,0
 58c:	00000097          	auipc	ra,0x0
 590:	170080e7          	jalr	368(ra) # 6fc <open>
    if (fd < 0)
 594:	02054563          	bltz	a0,5be <stat+0x42>
 598:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 59a:	85ca                	mv	a1,s2
 59c:	00000097          	auipc	ra,0x0
 5a0:	178080e7          	jalr	376(ra) # 714 <fstat>
 5a4:	892a                	mv	s2,a0
    close(fd);
 5a6:	8526                	mv	a0,s1
 5a8:	00000097          	auipc	ra,0x0
 5ac:	13c080e7          	jalr	316(ra) # 6e4 <close>
    return r;
}
 5b0:	854a                	mv	a0,s2
 5b2:	60e2                	ld	ra,24(sp)
 5b4:	6442                	ld	s0,16(sp)
 5b6:	64a2                	ld	s1,8(sp)
 5b8:	6902                	ld	s2,0(sp)
 5ba:	6105                	addi	sp,sp,32
 5bc:	8082                	ret
        return -1;
 5be:	597d                	li	s2,-1
 5c0:	bfc5                	j	5b0 <stat+0x34>

00000000000005c2 <atoi>:

int atoi(const char *s)
{
 5c2:	1141                	addi	sp,sp,-16
 5c4:	e422                	sd	s0,8(sp)
 5c6:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5c8:	00054683          	lbu	a3,0(a0)
 5cc:	fd06879b          	addiw	a5,a3,-48
 5d0:	0ff7f793          	zext.b	a5,a5
 5d4:	4625                	li	a2,9
 5d6:	02f66863          	bltu	a2,a5,606 <atoi+0x44>
 5da:	872a                	mv	a4,a0
    n = 0;
 5dc:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5de:	0705                	addi	a4,a4,1
 5e0:	0025179b          	slliw	a5,a0,0x2
 5e4:	9fa9                	addw	a5,a5,a0
 5e6:	0017979b          	slliw	a5,a5,0x1
 5ea:	9fb5                	addw	a5,a5,a3
 5ec:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5f0:	00074683          	lbu	a3,0(a4)
 5f4:	fd06879b          	addiw	a5,a3,-48
 5f8:	0ff7f793          	zext.b	a5,a5
 5fc:	fef671e3          	bgeu	a2,a5,5de <atoi+0x1c>
    return n;
}
 600:	6422                	ld	s0,8(sp)
 602:	0141                	addi	sp,sp,16
 604:	8082                	ret
    n = 0;
 606:	4501                	li	a0,0
 608:	bfe5                	j	600 <atoi+0x3e>

000000000000060a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 60a:	1141                	addi	sp,sp,-16
 60c:	e422                	sd	s0,8(sp)
 60e:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 610:	02b57463          	bgeu	a0,a1,638 <memmove+0x2e>
    {
        while (n-- > 0)
 614:	00c05f63          	blez	a2,632 <memmove+0x28>
 618:	1602                	slli	a2,a2,0x20
 61a:	9201                	srli	a2,a2,0x20
 61c:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 620:	872a                	mv	a4,a0
            *dst++ = *src++;
 622:	0585                	addi	a1,a1,1
 624:	0705                	addi	a4,a4,1
 626:	fff5c683          	lbu	a3,-1(a1)
 62a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 62e:	fee79ae3          	bne	a5,a4,622 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 632:	6422                	ld	s0,8(sp)
 634:	0141                	addi	sp,sp,16
 636:	8082                	ret
        dst += n;
 638:	00c50733          	add	a4,a0,a2
        src += n;
 63c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 63e:	fec05ae3          	blez	a2,632 <memmove+0x28>
 642:	fff6079b          	addiw	a5,a2,-1
 646:	1782                	slli	a5,a5,0x20
 648:	9381                	srli	a5,a5,0x20
 64a:	fff7c793          	not	a5,a5
 64e:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 650:	15fd                	addi	a1,a1,-1
 652:	177d                	addi	a4,a4,-1
 654:	0005c683          	lbu	a3,0(a1)
 658:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 65c:	fee79ae3          	bne	a5,a4,650 <memmove+0x46>
 660:	bfc9                	j	632 <memmove+0x28>

0000000000000662 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 662:	1141                	addi	sp,sp,-16
 664:	e422                	sd	s0,8(sp)
 666:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 668:	ca05                	beqz	a2,698 <memcmp+0x36>
 66a:	fff6069b          	addiw	a3,a2,-1
 66e:	1682                	slli	a3,a3,0x20
 670:	9281                	srli	a3,a3,0x20
 672:	0685                	addi	a3,a3,1
 674:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 676:	00054783          	lbu	a5,0(a0)
 67a:	0005c703          	lbu	a4,0(a1)
 67e:	00e79863          	bne	a5,a4,68e <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 682:	0505                	addi	a0,a0,1
        p2++;
 684:	0585                	addi	a1,a1,1
    while (n-- > 0)
 686:	fed518e3          	bne	a0,a3,676 <memcmp+0x14>
    }
    return 0;
 68a:	4501                	li	a0,0
 68c:	a019                	j	692 <memcmp+0x30>
            return *p1 - *p2;
 68e:	40e7853b          	subw	a0,a5,a4
}
 692:	6422                	ld	s0,8(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret
    return 0;
 698:	4501                	li	a0,0
 69a:	bfe5                	j	692 <memcmp+0x30>

000000000000069c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 69c:	1141                	addi	sp,sp,-16
 69e:	e406                	sd	ra,8(sp)
 6a0:	e022                	sd	s0,0(sp)
 6a2:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6a4:	00000097          	auipc	ra,0x0
 6a8:	f66080e7          	jalr	-154(ra) # 60a <memmove>
}
 6ac:	60a2                	ld	ra,8(sp)
 6ae:	6402                	ld	s0,0(sp)
 6b0:	0141                	addi	sp,sp,16
 6b2:	8082                	ret

00000000000006b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6b4:	4885                	li	a7,1
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6bc:	4889                	li	a7,2
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6c4:	488d                	li	a7,3
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6cc:	4891                	li	a7,4
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <read>:
.global read
read:
 li a7, SYS_read
 6d4:	4895                	li	a7,5
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <write>:
.global write
write:
 li a7, SYS_write
 6dc:	48c1                	li	a7,16
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <close>:
.global close
close:
 li a7, SYS_close
 6e4:	48d5                	li	a7,21
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 6ec:	4899                	li	a7,6
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6f4:	489d                	li	a7,7
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <open>:
.global open
open:
 li a7, SYS_open
 6fc:	48bd                	li	a7,15
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 704:	48c5                	li	a7,17
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 70c:	48c9                	li	a7,18
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 714:	48a1                	li	a7,8
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <link>:
.global link
link:
 li a7, SYS_link
 71c:	48cd                	li	a7,19
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 724:	48d1                	li	a7,20
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 72c:	48a5                	li	a7,9
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <dup>:
.global dup
dup:
 li a7, SYS_dup
 734:	48a9                	li	a7,10
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 73c:	48ad                	li	a7,11
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 744:	48b1                	li	a7,12
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 74c:	48b5                	li	a7,13
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 754:	48b9                	li	a7,14
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <ps>:
.global ps
ps:
 li a7, SYS_ps
 75c:	48d9                	li	a7,22
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 764:	48dd                	li	a7,23
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 76c:	48e1                	li	a7,24
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 774:	1101                	addi	sp,sp,-32
 776:	ec06                	sd	ra,24(sp)
 778:	e822                	sd	s0,16(sp)
 77a:	1000                	addi	s0,sp,32
 77c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 780:	4605                	li	a2,1
 782:	fef40593          	addi	a1,s0,-17
 786:	00000097          	auipc	ra,0x0
 78a:	f56080e7          	jalr	-170(ra) # 6dc <write>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6105                	addi	sp,sp,32
 794:	8082                	ret

0000000000000796 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 796:	7139                	addi	sp,sp,-64
 798:	fc06                	sd	ra,56(sp)
 79a:	f822                	sd	s0,48(sp)
 79c:	f426                	sd	s1,40(sp)
 79e:	f04a                	sd	s2,32(sp)
 7a0:	ec4e                	sd	s3,24(sp)
 7a2:	0080                	addi	s0,sp,64
 7a4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7a6:	c299                	beqz	a3,7ac <printint+0x16>
 7a8:	0805c963          	bltz	a1,83a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7ac:	2581                	sext.w	a1,a1
  neg = 0;
 7ae:	4881                	li	a7,0
 7b0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7b4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7b6:	2601                	sext.w	a2,a2
 7b8:	00000517          	auipc	a0,0x0
 7bc:	51050513          	addi	a0,a0,1296 # cc8 <digits>
 7c0:	883a                	mv	a6,a4
 7c2:	2705                	addiw	a4,a4,1
 7c4:	02c5f7bb          	remuw	a5,a1,a2
 7c8:	1782                	slli	a5,a5,0x20
 7ca:	9381                	srli	a5,a5,0x20
 7cc:	97aa                	add	a5,a5,a0
 7ce:	0007c783          	lbu	a5,0(a5)
 7d2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7d6:	0005879b          	sext.w	a5,a1
 7da:	02c5d5bb          	divuw	a1,a1,a2
 7de:	0685                	addi	a3,a3,1
 7e0:	fec7f0e3          	bgeu	a5,a2,7c0 <printint+0x2a>
  if(neg)
 7e4:	00088c63          	beqz	a7,7fc <printint+0x66>
    buf[i++] = '-';
 7e8:	fd070793          	addi	a5,a4,-48
 7ec:	00878733          	add	a4,a5,s0
 7f0:	02d00793          	li	a5,45
 7f4:	fef70823          	sb	a5,-16(a4)
 7f8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7fc:	02e05863          	blez	a4,82c <printint+0x96>
 800:	fc040793          	addi	a5,s0,-64
 804:	00e78933          	add	s2,a5,a4
 808:	fff78993          	addi	s3,a5,-1
 80c:	99ba                	add	s3,s3,a4
 80e:	377d                	addiw	a4,a4,-1
 810:	1702                	slli	a4,a4,0x20
 812:	9301                	srli	a4,a4,0x20
 814:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 818:	fff94583          	lbu	a1,-1(s2)
 81c:	8526                	mv	a0,s1
 81e:	00000097          	auipc	ra,0x0
 822:	f56080e7          	jalr	-170(ra) # 774 <putc>
  while(--i >= 0)
 826:	197d                	addi	s2,s2,-1
 828:	ff3918e3          	bne	s2,s3,818 <printint+0x82>
}
 82c:	70e2                	ld	ra,56(sp)
 82e:	7442                	ld	s0,48(sp)
 830:	74a2                	ld	s1,40(sp)
 832:	7902                	ld	s2,32(sp)
 834:	69e2                	ld	s3,24(sp)
 836:	6121                	addi	sp,sp,64
 838:	8082                	ret
    x = -xx;
 83a:	40b005bb          	negw	a1,a1
    neg = 1;
 83e:	4885                	li	a7,1
    x = -xx;
 840:	bf85                	j	7b0 <printint+0x1a>

0000000000000842 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 842:	715d                	addi	sp,sp,-80
 844:	e486                	sd	ra,72(sp)
 846:	e0a2                	sd	s0,64(sp)
 848:	fc26                	sd	s1,56(sp)
 84a:	f84a                	sd	s2,48(sp)
 84c:	f44e                	sd	s3,40(sp)
 84e:	f052                	sd	s4,32(sp)
 850:	ec56                	sd	s5,24(sp)
 852:	e85a                	sd	s6,16(sp)
 854:	e45e                	sd	s7,8(sp)
 856:	e062                	sd	s8,0(sp)
 858:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 85a:	0005c903          	lbu	s2,0(a1)
 85e:	18090c63          	beqz	s2,9f6 <vprintf+0x1b4>
 862:	8aaa                	mv	s5,a0
 864:	8bb2                	mv	s7,a2
 866:	00158493          	addi	s1,a1,1
  state = 0;
 86a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 86c:	02500a13          	li	s4,37
 870:	4b55                	li	s6,21
 872:	a839                	j	890 <vprintf+0x4e>
        putc(fd, c);
 874:	85ca                	mv	a1,s2
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	efc080e7          	jalr	-260(ra) # 774 <putc>
 880:	a019                	j	886 <vprintf+0x44>
    } else if(state == '%'){
 882:	01498d63          	beq	s3,s4,89c <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 886:	0485                	addi	s1,s1,1
 888:	fff4c903          	lbu	s2,-1(s1)
 88c:	16090563          	beqz	s2,9f6 <vprintf+0x1b4>
    if(state == 0){
 890:	fe0999e3          	bnez	s3,882 <vprintf+0x40>
      if(c == '%'){
 894:	ff4910e3          	bne	s2,s4,874 <vprintf+0x32>
        state = '%';
 898:	89d2                	mv	s3,s4
 89a:	b7f5                	j	886 <vprintf+0x44>
      if(c == 'd'){
 89c:	13490263          	beq	s2,s4,9c0 <vprintf+0x17e>
 8a0:	f9d9079b          	addiw	a5,s2,-99
 8a4:	0ff7f793          	zext.b	a5,a5
 8a8:	12fb6563          	bltu	s6,a5,9d2 <vprintf+0x190>
 8ac:	f9d9079b          	addiw	a5,s2,-99
 8b0:	0ff7f713          	zext.b	a4,a5
 8b4:	10eb6f63          	bltu	s6,a4,9d2 <vprintf+0x190>
 8b8:	00271793          	slli	a5,a4,0x2
 8bc:	00000717          	auipc	a4,0x0
 8c0:	3b470713          	addi	a4,a4,948 # c70 <malloc+0x17c>
 8c4:	97ba                	add	a5,a5,a4
 8c6:	439c                	lw	a5,0(a5)
 8c8:	97ba                	add	a5,a5,a4
 8ca:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8cc:	008b8913          	addi	s2,s7,8
 8d0:	4685                	li	a3,1
 8d2:	4629                	li	a2,10
 8d4:	000ba583          	lw	a1,0(s7)
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	ebc080e7          	jalr	-324(ra) # 796 <printint>
 8e2:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	b745                	j	886 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e8:	008b8913          	addi	s2,s7,8
 8ec:	4681                	li	a3,0
 8ee:	4629                	li	a2,10
 8f0:	000ba583          	lw	a1,0(s7)
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	ea0080e7          	jalr	-352(ra) # 796 <printint>
 8fe:	8bca                	mv	s7,s2
      state = 0;
 900:	4981                	li	s3,0
 902:	b751                	j	886 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 904:	008b8913          	addi	s2,s7,8
 908:	4681                	li	a3,0
 90a:	4641                	li	a2,16
 90c:	000ba583          	lw	a1,0(s7)
 910:	8556                	mv	a0,s5
 912:	00000097          	auipc	ra,0x0
 916:	e84080e7          	jalr	-380(ra) # 796 <printint>
 91a:	8bca                	mv	s7,s2
      state = 0;
 91c:	4981                	li	s3,0
 91e:	b7a5                	j	886 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 920:	008b8c13          	addi	s8,s7,8
 924:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 928:	03000593          	li	a1,48
 92c:	8556                	mv	a0,s5
 92e:	00000097          	auipc	ra,0x0
 932:	e46080e7          	jalr	-442(ra) # 774 <putc>
  putc(fd, 'x');
 936:	07800593          	li	a1,120
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	e38080e7          	jalr	-456(ra) # 774 <putc>
 944:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 946:	00000b97          	auipc	s7,0x0
 94a:	382b8b93          	addi	s7,s7,898 # cc8 <digits>
 94e:	03c9d793          	srli	a5,s3,0x3c
 952:	97de                	add	a5,a5,s7
 954:	0007c583          	lbu	a1,0(a5)
 958:	8556                	mv	a0,s5
 95a:	00000097          	auipc	ra,0x0
 95e:	e1a080e7          	jalr	-486(ra) # 774 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 962:	0992                	slli	s3,s3,0x4
 964:	397d                	addiw	s2,s2,-1
 966:	fe0914e3          	bnez	s2,94e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 96a:	8be2                	mv	s7,s8
      state = 0;
 96c:	4981                	li	s3,0
 96e:	bf21                	j	886 <vprintf+0x44>
        s = va_arg(ap, char*);
 970:	008b8993          	addi	s3,s7,8
 974:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 978:	02090163          	beqz	s2,99a <vprintf+0x158>
        while(*s != 0){
 97c:	00094583          	lbu	a1,0(s2)
 980:	c9a5                	beqz	a1,9f0 <vprintf+0x1ae>
          putc(fd, *s);
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	df0080e7          	jalr	-528(ra) # 774 <putc>
          s++;
 98c:	0905                	addi	s2,s2,1
        while(*s != 0){
 98e:	00094583          	lbu	a1,0(s2)
 992:	f9e5                	bnez	a1,982 <vprintf+0x140>
        s = va_arg(ap, char*);
 994:	8bce                	mv	s7,s3
      state = 0;
 996:	4981                	li	s3,0
 998:	b5fd                	j	886 <vprintf+0x44>
          s = "(null)";
 99a:	00000917          	auipc	s2,0x0
 99e:	2ce90913          	addi	s2,s2,718 # c68 <malloc+0x174>
        while(*s != 0){
 9a2:	02800593          	li	a1,40
 9a6:	bff1                	j	982 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9a8:	008b8913          	addi	s2,s7,8
 9ac:	000bc583          	lbu	a1,0(s7)
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	dc2080e7          	jalr	-574(ra) # 774 <putc>
 9ba:	8bca                	mv	s7,s2
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	b5e1                	j	886 <vprintf+0x44>
        putc(fd, c);
 9c0:	02500593          	li	a1,37
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	dae080e7          	jalr	-594(ra) # 774 <putc>
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bd5d                	j	886 <vprintf+0x44>
        putc(fd, '%');
 9d2:	02500593          	li	a1,37
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	d9c080e7          	jalr	-612(ra) # 774 <putc>
        putc(fd, c);
 9e0:	85ca                	mv	a1,s2
 9e2:	8556                	mv	a0,s5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	d90080e7          	jalr	-624(ra) # 774 <putc>
      state = 0;
 9ec:	4981                	li	s3,0
 9ee:	bd61                	j	886 <vprintf+0x44>
        s = va_arg(ap, char*);
 9f0:	8bce                	mv	s7,s3
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	bd49                	j	886 <vprintf+0x44>
    }
  }
}
 9f6:	60a6                	ld	ra,72(sp)
 9f8:	6406                	ld	s0,64(sp)
 9fa:	74e2                	ld	s1,56(sp)
 9fc:	7942                	ld	s2,48(sp)
 9fe:	79a2                	ld	s3,40(sp)
 a00:	7a02                	ld	s4,32(sp)
 a02:	6ae2                	ld	s5,24(sp)
 a04:	6b42                	ld	s6,16(sp)
 a06:	6ba2                	ld	s7,8(sp)
 a08:	6c02                	ld	s8,0(sp)
 a0a:	6161                	addi	sp,sp,80
 a0c:	8082                	ret

0000000000000a0e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a0e:	715d                	addi	sp,sp,-80
 a10:	ec06                	sd	ra,24(sp)
 a12:	e822                	sd	s0,16(sp)
 a14:	1000                	addi	s0,sp,32
 a16:	e010                	sd	a2,0(s0)
 a18:	e414                	sd	a3,8(s0)
 a1a:	e818                	sd	a4,16(s0)
 a1c:	ec1c                	sd	a5,24(s0)
 a1e:	03043023          	sd	a6,32(s0)
 a22:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a26:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a2a:	8622                	mv	a2,s0
 a2c:	00000097          	auipc	ra,0x0
 a30:	e16080e7          	jalr	-490(ra) # 842 <vprintf>
}
 a34:	60e2                	ld	ra,24(sp)
 a36:	6442                	ld	s0,16(sp)
 a38:	6161                	addi	sp,sp,80
 a3a:	8082                	ret

0000000000000a3c <printf>:

void
printf(const char *fmt, ...)
{
 a3c:	711d                	addi	sp,sp,-96
 a3e:	ec06                	sd	ra,24(sp)
 a40:	e822                	sd	s0,16(sp)
 a42:	1000                	addi	s0,sp,32
 a44:	e40c                	sd	a1,8(s0)
 a46:	e810                	sd	a2,16(s0)
 a48:	ec14                	sd	a3,24(s0)
 a4a:	f018                	sd	a4,32(s0)
 a4c:	f41c                	sd	a5,40(s0)
 a4e:	03043823          	sd	a6,48(s0)
 a52:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a56:	00840613          	addi	a2,s0,8
 a5a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a5e:	85aa                	mv	a1,a0
 a60:	4505                	li	a0,1
 a62:	00000097          	auipc	ra,0x0
 a66:	de0080e7          	jalr	-544(ra) # 842 <vprintf>
}
 a6a:	60e2                	ld	ra,24(sp)
 a6c:	6442                	ld	s0,16(sp)
 a6e:	6125                	addi	sp,sp,96
 a70:	8082                	ret

0000000000000a72 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a72:	1141                	addi	sp,sp,-16
 a74:	e422                	sd	s0,8(sp)
 a76:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a78:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a7c:	00000797          	auipc	a5,0x0
 a80:	59c7b783          	ld	a5,1436(a5) # 1018 <freep>
 a84:	a02d                	j	aae <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a86:	4618                	lw	a4,8(a2)
 a88:	9f2d                	addw	a4,a4,a1
 a8a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a8e:	6398                	ld	a4,0(a5)
 a90:	6310                	ld	a2,0(a4)
 a92:	a83d                	j	ad0 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a94:	ff852703          	lw	a4,-8(a0)
 a98:	9f31                	addw	a4,a4,a2
 a9a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a9c:	ff053683          	ld	a3,-16(a0)
 aa0:	a091                	j	ae4 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	6398                	ld	a4,0(a5)
 aa4:	00e7e463          	bltu	a5,a4,aac <free+0x3a>
 aa8:	00e6ea63          	bltu	a3,a4,abc <free+0x4a>
{
 aac:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aae:	fed7fae3          	bgeu	a5,a3,aa2 <free+0x30>
 ab2:	6398                	ld	a4,0(a5)
 ab4:	00e6e463          	bltu	a3,a4,abc <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab8:	fee7eae3          	bltu	a5,a4,aac <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 abc:	ff852583          	lw	a1,-8(a0)
 ac0:	6390                	ld	a2,0(a5)
 ac2:	02059813          	slli	a6,a1,0x20
 ac6:	01c85713          	srli	a4,a6,0x1c
 aca:	9736                	add	a4,a4,a3
 acc:	fae60de3          	beq	a2,a4,a86 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ad0:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ad4:	4790                	lw	a2,8(a5)
 ad6:	02061593          	slli	a1,a2,0x20
 ada:	01c5d713          	srli	a4,a1,0x1c
 ade:	973e                	add	a4,a4,a5
 ae0:	fae68ae3          	beq	a3,a4,a94 <free+0x22>
        p->s.ptr = bp->s.ptr;
 ae4:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ae6:	00000717          	auipc	a4,0x0
 aea:	52f73923          	sd	a5,1330(a4) # 1018 <freep>
}
 aee:	6422                	ld	s0,8(sp)
 af0:	0141                	addi	sp,sp,16
 af2:	8082                	ret

0000000000000af4 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 af4:	7139                	addi	sp,sp,-64
 af6:	fc06                	sd	ra,56(sp)
 af8:	f822                	sd	s0,48(sp)
 afa:	f426                	sd	s1,40(sp)
 afc:	f04a                	sd	s2,32(sp)
 afe:	ec4e                	sd	s3,24(sp)
 b00:	e852                	sd	s4,16(sp)
 b02:	e456                	sd	s5,8(sp)
 b04:	e05a                	sd	s6,0(sp)
 b06:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b08:	02051493          	slli	s1,a0,0x20
 b0c:	9081                	srli	s1,s1,0x20
 b0e:	04bd                	addi	s1,s1,15
 b10:	8091                	srli	s1,s1,0x4
 b12:	0014899b          	addiw	s3,s1,1
 b16:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b18:	00000517          	auipc	a0,0x0
 b1c:	50053503          	ld	a0,1280(a0) # 1018 <freep>
 b20:	c515                	beqz	a0,b4c <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b22:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b24:	4798                	lw	a4,8(a5)
 b26:	02977f63          	bgeu	a4,s1,b64 <malloc+0x70>
    if (nu < 4096)
 b2a:	8a4e                	mv	s4,s3
 b2c:	0009871b          	sext.w	a4,s3
 b30:	6685                	lui	a3,0x1
 b32:	00d77363          	bgeu	a4,a3,b38 <malloc+0x44>
 b36:	6a05                	lui	s4,0x1
 b38:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b3c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b40:	00000917          	auipc	s2,0x0
 b44:	4d890913          	addi	s2,s2,1240 # 1018 <freep>
    if (p == (char *)-1)
 b48:	5afd                	li	s5,-1
 b4a:	a895                	j	bbe <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b4c:	00000797          	auipc	a5,0x0
 b50:	55478793          	addi	a5,a5,1364 # 10a0 <base>
 b54:	00000717          	auipc	a4,0x0
 b58:	4cf73223          	sd	a5,1220(a4) # 1018 <freep>
 b5c:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b5e:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b62:	b7e1                	j	b2a <malloc+0x36>
            if (p->s.size == nunits)
 b64:	02e48c63          	beq	s1,a4,b9c <malloc+0xa8>
                p->s.size -= nunits;
 b68:	4137073b          	subw	a4,a4,s3
 b6c:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b6e:	02071693          	slli	a3,a4,0x20
 b72:	01c6d713          	srli	a4,a3,0x1c
 b76:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b78:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b7c:	00000717          	auipc	a4,0x0
 b80:	48a73e23          	sd	a0,1180(a4) # 1018 <freep>
            return (void *)(p + 1);
 b84:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b88:	70e2                	ld	ra,56(sp)
 b8a:	7442                	ld	s0,48(sp)
 b8c:	74a2                	ld	s1,40(sp)
 b8e:	7902                	ld	s2,32(sp)
 b90:	69e2                	ld	s3,24(sp)
 b92:	6a42                	ld	s4,16(sp)
 b94:	6aa2                	ld	s5,8(sp)
 b96:	6b02                	ld	s6,0(sp)
 b98:	6121                	addi	sp,sp,64
 b9a:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b9c:	6398                	ld	a4,0(a5)
 b9e:	e118                	sd	a4,0(a0)
 ba0:	bff1                	j	b7c <malloc+0x88>
    hp->s.size = nu;
 ba2:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 ba6:	0541                	addi	a0,a0,16
 ba8:	00000097          	auipc	ra,0x0
 bac:	eca080e7          	jalr	-310(ra) # a72 <free>
    return freep;
 bb0:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bb4:	d971                	beqz	a0,b88 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bb6:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bb8:	4798                	lw	a4,8(a5)
 bba:	fa9775e3          	bgeu	a4,s1,b64 <malloc+0x70>
        if (p == freep)
 bbe:	00093703          	ld	a4,0(s2)
 bc2:	853e                	mv	a0,a5
 bc4:	fef719e3          	bne	a4,a5,bb6 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bc8:	8552                	mv	a0,s4
 bca:	00000097          	auipc	ra,0x0
 bce:	b7a080e7          	jalr	-1158(ra) # 744 <sbrk>
    if (p == (char *)-1)
 bd2:	fd5518e3          	bne	a0,s5,ba2 <malloc+0xae>
                return 0;
 bd6:	4501                	li	a0,0
 bd8:	bf45                	j	b88 <malloc+0x94>
