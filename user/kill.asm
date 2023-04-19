
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
  2c:	588080e7          	jalr	1416(ra) # 5b0 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	6aa080e7          	jalr	1706(ra) # 6da <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	66a080e7          	jalr	1642(ra) # 6aa <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	b8858593          	addi	a1,a1,-1144 # bd0 <malloc+0xee>
  50:	4509                	li	a0,2
  52:	00001097          	auipc	ra,0x1
  56:	9aa080e7          	jalr	-1622(ra) # 9fc <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	64e080e7          	jalr	1614(ra) # 6aa <exit>

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
  98:	2c4080e7          	jalr	708(ra) # 358 <twhoami>
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
  e4:	b0850513          	addi	a0,a0,-1272 # be8 <malloc+0x106>
  e8:	00001097          	auipc	ra,0x1
  ec:	942080e7          	jalr	-1726(ra) # a2a <printf>
        exit(-1);
  f0:	557d                	li	a0,-1
  f2:	00000097          	auipc	ra,0x0
  f6:	5b8080e7          	jalr	1464(ra) # 6aa <exit>
    {
        // give up the cpu for other threads
        tyield();
  fa:	00000097          	auipc	ra,0x0
  fe:	1dc080e7          	jalr	476(ra) # 2d6 <tyield>
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
 118:	244080e7          	jalr	580(ra) # 358 <twhoami>
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
 15c:	17e080e7          	jalr	382(ra) # 2d6 <tyield>
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret
        printf("releasing lock we are not holding");
 16a:	00001517          	auipc	a0,0x1
 16e:	aa650513          	addi	a0,a0,-1370 # c10 <malloc+0x12e>
 172:	00001097          	auipc	ra,0x1
 176:	8b8080e7          	jalr	-1864(ra) # a2a <printf>
        exit(-1);
 17a:	557d                	li	a0,-1
 17c:	00000097          	auipc	ra,0x0
 180:	52e080e7          	jalr	1326(ra) # 6aa <exit>

0000000000000184 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 184:	00001517          	auipc	a0,0x1
 188:	e8c53503          	ld	a0,-372(a0) # 1010 <current_thread>
 18c:	00001717          	auipc	a4,0x1
 190:	e9470713          	addi	a4,a4,-364 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 194:	4781                	li	a5,0
 196:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 198:	6314                	ld	a3,0(a4)
 19a:	00a68763          	beq	a3,a0,1a8 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 19e:	2785                	addiw	a5,a5,1
 1a0:	0721                	addi	a4,a4,8
 1a2:	fec79be3          	bne	a5,a2,198 <tsched+0x14>
    int current_index = 0;
 1a6:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1a8:	0017869b          	addiw	a3,a5,1
 1ac:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1b0:	00001817          	auipc	a6,0x1
 1b4:	e7080813          	addi	a6,a6,-400 # 1020 <threads>
 1b8:	488d                	li	a7,3
 1ba:	a021                	j	1c2 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1bc:	2685                	addiw	a3,a3,1
 1be:	04c68363          	beq	a3,a2,204 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1c2:	41f6d71b          	sraiw	a4,a3,0x1f
 1c6:	01c7571b          	srliw	a4,a4,0x1c
 1ca:	00d707bb          	addw	a5,a4,a3
 1ce:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1d0:	9f99                	subw	a5,a5,a4
 1d2:	078e                	slli	a5,a5,0x3
 1d4:	97c2                	add	a5,a5,a6
 1d6:	638c                	ld	a1,0(a5)
 1d8:	d1f5                	beqz	a1,1bc <tsched+0x38>
 1da:	5dbc                	lw	a5,120(a1)
 1dc:	ff1790e3          	bne	a5,a7,1bc <tsched+0x38>
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e406                	sd	ra,8(sp)
 1e4:	e022                	sd	s0,0(sp)
 1e6:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1e8:	00001797          	auipc	a5,0x1
 1ec:	e2b7b423          	sd	a1,-472(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1f0:	05a1                	addi	a1,a1,8
 1f2:	0521                	addi	a0,a0,8
 1f4:	00000097          	auipc	ra,0x0
 1f8:	17c080e7          	jalr	380(ra) # 370 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1fc:	60a2                	ld	ra,8(sp)
 1fe:	6402                	ld	s0,0(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
 204:	8082                	ret

0000000000000206 <thread_wrapper>:
{
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 210:	00001497          	auipc	s1,0x1
 214:	e0048493          	addi	s1,s1,-512 # 1010 <current_thread>
 218:	609c                	ld	a5,0(s1)
 21a:	67d8                	ld	a4,136(a5)
 21c:	63c8                	ld	a0,128(a5)
 21e:	9702                	jalr	a4
    current_thread->state = EXITED;
 220:	609c                	ld	a5,0(s1)
 222:	4719                	li	a4,6
 224:	dfb8                	sw	a4,120(a5)
    tsched();
 226:	00000097          	auipc	ra,0x0
 22a:	f5e080e7          	jalr	-162(ra) # 184 <tsched>
}
 22e:	60e2                	ld	ra,24(sp)
 230:	6442                	ld	s0,16(sp)
 232:	64a2                	ld	s1,8(sp)
 234:	6105                	addi	sp,sp,32
 236:	8082                	ret

0000000000000238 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 238:	7179                	addi	sp,sp,-48
 23a:	f406                	sd	ra,40(sp)
 23c:	f022                	sd	s0,32(sp)
 23e:	ec26                	sd	s1,24(sp)
 240:	e84a                	sd	s2,16(sp)
 242:	e44e                	sd	s3,8(sp)
 244:	1800                	addi	s0,sp,48
 246:	84aa                	mv	s1,a0
 248:	89b2                	mv	s3,a2
 24a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 24c:	09800513          	li	a0,152
 250:	00001097          	auipc	ra,0x1
 254:	892080e7          	jalr	-1902(ra) # ae2 <malloc>
 258:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 25a:	478d                	li	a5,3
 25c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 25e:	609c                	ld	a5,0(s1)
 260:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 264:	609c                	ld	a5,0(s1)
 266:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 26a:	6098                	ld	a4,0(s1)
 26c:	00001797          	auipc	a5,0x1
 270:	d9478793          	addi	a5,a5,-620 # 1000 <next_tid>
 274:	4394                	lw	a3,0(a5)
 276:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 27a:	4398                	lw	a4,0(a5)
 27c:	2705                	addiw	a4,a4,1
 27e:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 280:	6505                	lui	a0,0x1
 282:	00001097          	auipc	ra,0x1
 286:	860080e7          	jalr	-1952(ra) # ae2 <malloc>
 28a:	609c                	ld	a5,0(s1)
 28c:	6705                	lui	a4,0x1
 28e:	953a                	add	a0,a0,a4
 290:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 292:	609c                	ld	a5,0(s1)
 294:	00000717          	auipc	a4,0x0
 298:	f7270713          	addi	a4,a4,-142 # 206 <thread_wrapper>
 29c:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 29e:	00001717          	auipc	a4,0x1
 2a2:	d8270713          	addi	a4,a4,-638 # 1020 <threads>
 2a6:	4781                	li	a5,0
 2a8:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2aa:	6314                	ld	a3,0(a4)
 2ac:	ce81                	beqz	a3,2c4 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2ae:	2785                	addiw	a5,a5,1
 2b0:	0721                	addi	a4,a4,8
 2b2:	fec79ce3          	bne	a5,a2,2aa <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2b6:	70a2                	ld	ra,40(sp)
 2b8:	7402                	ld	s0,32(sp)
 2ba:	64e2                	ld	s1,24(sp)
 2bc:	6942                	ld	s2,16(sp)
 2be:	69a2                	ld	s3,8(sp)
 2c0:	6145                	addi	sp,sp,48
 2c2:	8082                	ret
            threads[i] = *thread;
 2c4:	6094                	ld	a3,0(s1)
 2c6:	078e                	slli	a5,a5,0x3
 2c8:	00001717          	auipc	a4,0x1
 2cc:	d5870713          	addi	a4,a4,-680 # 1020 <threads>
 2d0:	97ba                	add	a5,a5,a4
 2d2:	e394                	sd	a3,0(a5)
            break;
 2d4:	b7cd                	j	2b6 <tcreate+0x7e>

00000000000002d6 <tyield>:
    return 0;
}


void tyield()
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2de:	00001797          	auipc	a5,0x1
 2e2:	d327b783          	ld	a5,-718(a5) # 1010 <current_thread>
 2e6:	470d                	li	a4,3
 2e8:	dfb8                	sw	a4,120(a5)
    tsched();
 2ea:	00000097          	auipc	ra,0x0
 2ee:	e9a080e7          	jalr	-358(ra) # 184 <tsched>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <tjoin>:
{
 2fa:	1101                	addi	sp,sp,-32
 2fc:	ec06                	sd	ra,24(sp)
 2fe:	e822                	sd	s0,16(sp)
 300:	e426                	sd	s1,8(sp)
 302:	e04a                	sd	s2,0(sp)
 304:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 306:	00001797          	auipc	a5,0x1
 30a:	d1a78793          	addi	a5,a5,-742 # 1020 <threads>
 30e:	00001697          	auipc	a3,0x1
 312:	d9268693          	addi	a3,a3,-622 # 10a0 <base>
 316:	a021                	j	31e <tjoin+0x24>
 318:	07a1                	addi	a5,a5,8
 31a:	02d78b63          	beq	a5,a3,350 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 31e:	6384                	ld	s1,0(a5)
 320:	dce5                	beqz	s1,318 <tjoin+0x1e>
 322:	0004c703          	lbu	a4,0(s1)
 326:	fea719e3          	bne	a4,a0,318 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 32a:	5cb8                	lw	a4,120(s1)
 32c:	4799                	li	a5,6
 32e:	4919                	li	s2,6
 330:	02f70263          	beq	a4,a5,354 <tjoin+0x5a>
        tyield();
 334:	00000097          	auipc	ra,0x0
 338:	fa2080e7          	jalr	-94(ra) # 2d6 <tyield>
    while (target_thread->state != EXITED) {
 33c:	5cbc                	lw	a5,120(s1)
 33e:	ff279be3          	bne	a5,s2,334 <tjoin+0x3a>
    return 0;
 342:	4501                	li	a0,0
}
 344:	60e2                	ld	ra,24(sp)
 346:	6442                	ld	s0,16(sp)
 348:	64a2                	ld	s1,8(sp)
 34a:	6902                	ld	s2,0(sp)
 34c:	6105                	addi	sp,sp,32
 34e:	8082                	ret
        return -1;
 350:	557d                	li	a0,-1
 352:	bfcd                	j	344 <tjoin+0x4a>
    return 0;
 354:	4501                	li	a0,0
 356:	b7fd                	j	344 <tjoin+0x4a>

0000000000000358 <twhoami>:

uint8 twhoami()
{
 358:	1141                	addi	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 35e:	00001797          	auipc	a5,0x1
 362:	cb27b783          	ld	a5,-846(a5) # 1010 <current_thread>
 366:	0007c503          	lbu	a0,0(a5)
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret

0000000000000370 <tswtch>:
 370:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 374:	00253423          	sd	sp,8(a0)
 378:	e900                	sd	s0,16(a0)
 37a:	ed04                	sd	s1,24(a0)
 37c:	03253023          	sd	s2,32(a0)
 380:	03353423          	sd	s3,40(a0)
 384:	03453823          	sd	s4,48(a0)
 388:	03553c23          	sd	s5,56(a0)
 38c:	05653023          	sd	s6,64(a0)
 390:	05753423          	sd	s7,72(a0)
 394:	05853823          	sd	s8,80(a0)
 398:	05953c23          	sd	s9,88(a0)
 39c:	07a53023          	sd	s10,96(a0)
 3a0:	07b53423          	sd	s11,104(a0)
 3a4:	0005b083          	ld	ra,0(a1)
 3a8:	0085b103          	ld	sp,8(a1)
 3ac:	6980                	ld	s0,16(a1)
 3ae:	6d84                	ld	s1,24(a1)
 3b0:	0205b903          	ld	s2,32(a1)
 3b4:	0285b983          	ld	s3,40(a1)
 3b8:	0305ba03          	ld	s4,48(a1)
 3bc:	0385ba83          	ld	s5,56(a1)
 3c0:	0405bb03          	ld	s6,64(a1)
 3c4:	0485bb83          	ld	s7,72(a1)
 3c8:	0505bc03          	ld	s8,80(a1)
 3cc:	0585bc83          	ld	s9,88(a1)
 3d0:	0605bd03          	ld	s10,96(a1)
 3d4:	0685bd83          	ld	s11,104(a1)
 3d8:	8082                	ret

00000000000003da <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3da:	1101                	addi	sp,sp,-32
 3dc:	ec06                	sd	ra,24(sp)
 3de:	e822                	sd	s0,16(sp)
 3e0:	e426                	sd	s1,8(sp)
 3e2:	e04a                	sd	s2,0(sp)
 3e4:	1000                	addi	s0,sp,32
 3e6:	84aa                	mv	s1,a0
 3e8:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3ea:	09800513          	li	a0,152
 3ee:	00000097          	auipc	ra,0x0
 3f2:	6f4080e7          	jalr	1780(ra) # ae2 <malloc>

    main_thread->tid = 1;
 3f6:	4785                	li	a5,1
 3f8:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3fc:	4791                	li	a5,4
 3fe:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 400:	00001797          	auipc	a5,0x1
 404:	c0a7b823          	sd	a0,-1008(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 408:	00001797          	auipc	a5,0x1
 40c:	c1878793          	addi	a5,a5,-1000 # 1020 <threads>
 410:	00001717          	auipc	a4,0x1
 414:	c9070713          	addi	a4,a4,-880 # 10a0 <base>
        threads[i] = NULL;
 418:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 41c:	07a1                	addi	a5,a5,8
 41e:	fee79de3          	bne	a5,a4,418 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 422:	00001797          	auipc	a5,0x1
 426:	bea7bf23          	sd	a0,-1026(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 42a:	85ca                	mv	a1,s2
 42c:	8526                	mv	a0,s1
 42e:	00000097          	auipc	ra,0x0
 432:	bd2080e7          	jalr	-1070(ra) # 0 <main>
    //tsched();

    exit(res);
 436:	00000097          	auipc	ra,0x0
 43a:	274080e7          	jalr	628(ra) # 6aa <exit>

000000000000043e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 43e:	1141                	addi	sp,sp,-16
 440:	e422                	sd	s0,8(sp)
 442:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 444:	87aa                	mv	a5,a0
 446:	0585                	addi	a1,a1,1
 448:	0785                	addi	a5,a5,1
 44a:	fff5c703          	lbu	a4,-1(a1)
 44e:	fee78fa3          	sb	a4,-1(a5)
 452:	fb75                	bnez	a4,446 <strcpy+0x8>
        ;
    return os;
}
 454:	6422                	ld	s0,8(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret

000000000000045a <strcmp>:

int strcmp(const char *p, const char *q)
{
 45a:	1141                	addi	sp,sp,-16
 45c:	e422                	sd	s0,8(sp)
 45e:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 460:	00054783          	lbu	a5,0(a0)
 464:	cb91                	beqz	a5,478 <strcmp+0x1e>
 466:	0005c703          	lbu	a4,0(a1)
 46a:	00f71763          	bne	a4,a5,478 <strcmp+0x1e>
        p++, q++;
 46e:	0505                	addi	a0,a0,1
 470:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 472:	00054783          	lbu	a5,0(a0)
 476:	fbe5                	bnez	a5,466 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 478:	0005c503          	lbu	a0,0(a1)
}
 47c:	40a7853b          	subw	a0,a5,a0
 480:	6422                	ld	s0,8(sp)
 482:	0141                	addi	sp,sp,16
 484:	8082                	ret

0000000000000486 <strlen>:

uint strlen(const char *s)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 48c:	00054783          	lbu	a5,0(a0)
 490:	cf91                	beqz	a5,4ac <strlen+0x26>
 492:	0505                	addi	a0,a0,1
 494:	87aa                	mv	a5,a0
 496:	86be                	mv	a3,a5
 498:	0785                	addi	a5,a5,1
 49a:	fff7c703          	lbu	a4,-1(a5)
 49e:	ff65                	bnez	a4,496 <strlen+0x10>
 4a0:	40a6853b          	subw	a0,a3,a0
 4a4:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret
    for (n = 0; s[n]; n++)
 4ac:	4501                	li	a0,0
 4ae:	bfe5                	j	4a6 <strlen+0x20>

00000000000004b0 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e422                	sd	s0,8(sp)
 4b4:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4b6:	ca19                	beqz	a2,4cc <memset+0x1c>
 4b8:	87aa                	mv	a5,a0
 4ba:	1602                	slli	a2,a2,0x20
 4bc:	9201                	srli	a2,a2,0x20
 4be:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4c2:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4c6:	0785                	addi	a5,a5,1
 4c8:	fee79de3          	bne	a5,a4,4c2 <memset+0x12>
    }
    return dst;
}
 4cc:	6422                	ld	s0,8(sp)
 4ce:	0141                	addi	sp,sp,16
 4d0:	8082                	ret

00000000000004d2 <strchr>:

char *
strchr(const char *s, char c)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4d8:	00054783          	lbu	a5,0(a0)
 4dc:	cb99                	beqz	a5,4f2 <strchr+0x20>
        if (*s == c)
 4de:	00f58763          	beq	a1,a5,4ec <strchr+0x1a>
    for (; *s; s++)
 4e2:	0505                	addi	a0,a0,1
 4e4:	00054783          	lbu	a5,0(a0)
 4e8:	fbfd                	bnez	a5,4de <strchr+0xc>
            return (char *)s;
    return 0;
 4ea:	4501                	li	a0,0
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret
    return 0;
 4f2:	4501                	li	a0,0
 4f4:	bfe5                	j	4ec <strchr+0x1a>

00000000000004f6 <gets>:

char *
gets(char *buf, int max)
{
 4f6:	711d                	addi	sp,sp,-96
 4f8:	ec86                	sd	ra,88(sp)
 4fa:	e8a2                	sd	s0,80(sp)
 4fc:	e4a6                	sd	s1,72(sp)
 4fe:	e0ca                	sd	s2,64(sp)
 500:	fc4e                	sd	s3,56(sp)
 502:	f852                	sd	s4,48(sp)
 504:	f456                	sd	s5,40(sp)
 506:	f05a                	sd	s6,32(sp)
 508:	ec5e                	sd	s7,24(sp)
 50a:	1080                	addi	s0,sp,96
 50c:	8baa                	mv	s7,a0
 50e:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 510:	892a                	mv	s2,a0
 512:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 514:	4aa9                	li	s5,10
 516:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 518:	89a6                	mv	s3,s1
 51a:	2485                	addiw	s1,s1,1
 51c:	0344d863          	bge	s1,s4,54c <gets+0x56>
        cc = read(0, &c, 1);
 520:	4605                	li	a2,1
 522:	faf40593          	addi	a1,s0,-81
 526:	4501                	li	a0,0
 528:	00000097          	auipc	ra,0x0
 52c:	19a080e7          	jalr	410(ra) # 6c2 <read>
        if (cc < 1)
 530:	00a05e63          	blez	a0,54c <gets+0x56>
        buf[i++] = c;
 534:	faf44783          	lbu	a5,-81(s0)
 538:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 53c:	01578763          	beq	a5,s5,54a <gets+0x54>
 540:	0905                	addi	s2,s2,1
 542:	fd679be3          	bne	a5,s6,518 <gets+0x22>
    for (i = 0; i + 1 < max;)
 546:	89a6                	mv	s3,s1
 548:	a011                	j	54c <gets+0x56>
 54a:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 54c:	99de                	add	s3,s3,s7
 54e:	00098023          	sb	zero,0(s3)
    return buf;
}
 552:	855e                	mv	a0,s7
 554:	60e6                	ld	ra,88(sp)
 556:	6446                	ld	s0,80(sp)
 558:	64a6                	ld	s1,72(sp)
 55a:	6906                	ld	s2,64(sp)
 55c:	79e2                	ld	s3,56(sp)
 55e:	7a42                	ld	s4,48(sp)
 560:	7aa2                	ld	s5,40(sp)
 562:	7b02                	ld	s6,32(sp)
 564:	6be2                	ld	s7,24(sp)
 566:	6125                	addi	sp,sp,96
 568:	8082                	ret

000000000000056a <stat>:

int stat(const char *n, struct stat *st)
{
 56a:	1101                	addi	sp,sp,-32
 56c:	ec06                	sd	ra,24(sp)
 56e:	e822                	sd	s0,16(sp)
 570:	e426                	sd	s1,8(sp)
 572:	e04a                	sd	s2,0(sp)
 574:	1000                	addi	s0,sp,32
 576:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 578:	4581                	li	a1,0
 57a:	00000097          	auipc	ra,0x0
 57e:	170080e7          	jalr	368(ra) # 6ea <open>
    if (fd < 0)
 582:	02054563          	bltz	a0,5ac <stat+0x42>
 586:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 588:	85ca                	mv	a1,s2
 58a:	00000097          	auipc	ra,0x0
 58e:	178080e7          	jalr	376(ra) # 702 <fstat>
 592:	892a                	mv	s2,a0
    close(fd);
 594:	8526                	mv	a0,s1
 596:	00000097          	auipc	ra,0x0
 59a:	13c080e7          	jalr	316(ra) # 6d2 <close>
    return r;
}
 59e:	854a                	mv	a0,s2
 5a0:	60e2                	ld	ra,24(sp)
 5a2:	6442                	ld	s0,16(sp)
 5a4:	64a2                	ld	s1,8(sp)
 5a6:	6902                	ld	s2,0(sp)
 5a8:	6105                	addi	sp,sp,32
 5aa:	8082                	ret
        return -1;
 5ac:	597d                	li	s2,-1
 5ae:	bfc5                	j	59e <stat+0x34>

00000000000005b0 <atoi>:

int atoi(const char *s)
{
 5b0:	1141                	addi	sp,sp,-16
 5b2:	e422                	sd	s0,8(sp)
 5b4:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5b6:	00054683          	lbu	a3,0(a0)
 5ba:	fd06879b          	addiw	a5,a3,-48
 5be:	0ff7f793          	zext.b	a5,a5
 5c2:	4625                	li	a2,9
 5c4:	02f66863          	bltu	a2,a5,5f4 <atoi+0x44>
 5c8:	872a                	mv	a4,a0
    n = 0;
 5ca:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5cc:	0705                	addi	a4,a4,1
 5ce:	0025179b          	slliw	a5,a0,0x2
 5d2:	9fa9                	addw	a5,a5,a0
 5d4:	0017979b          	slliw	a5,a5,0x1
 5d8:	9fb5                	addw	a5,a5,a3
 5da:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5de:	00074683          	lbu	a3,0(a4)
 5e2:	fd06879b          	addiw	a5,a3,-48
 5e6:	0ff7f793          	zext.b	a5,a5
 5ea:	fef671e3          	bgeu	a2,a5,5cc <atoi+0x1c>
    return n;
}
 5ee:	6422                	ld	s0,8(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret
    n = 0;
 5f4:	4501                	li	a0,0
 5f6:	bfe5                	j	5ee <atoi+0x3e>

00000000000005f8 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5f8:	1141                	addi	sp,sp,-16
 5fa:	e422                	sd	s0,8(sp)
 5fc:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5fe:	02b57463          	bgeu	a0,a1,626 <memmove+0x2e>
    {
        while (n-- > 0)
 602:	00c05f63          	blez	a2,620 <memmove+0x28>
 606:	1602                	slli	a2,a2,0x20
 608:	9201                	srli	a2,a2,0x20
 60a:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 60e:	872a                	mv	a4,a0
            *dst++ = *src++;
 610:	0585                	addi	a1,a1,1
 612:	0705                	addi	a4,a4,1
 614:	fff5c683          	lbu	a3,-1(a1)
 618:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 61c:	fee79ae3          	bne	a5,a4,610 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 620:	6422                	ld	s0,8(sp)
 622:	0141                	addi	sp,sp,16
 624:	8082                	ret
        dst += n;
 626:	00c50733          	add	a4,a0,a2
        src += n;
 62a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 62c:	fec05ae3          	blez	a2,620 <memmove+0x28>
 630:	fff6079b          	addiw	a5,a2,-1
 634:	1782                	slli	a5,a5,0x20
 636:	9381                	srli	a5,a5,0x20
 638:	fff7c793          	not	a5,a5
 63c:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 63e:	15fd                	addi	a1,a1,-1
 640:	177d                	addi	a4,a4,-1
 642:	0005c683          	lbu	a3,0(a1)
 646:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 64a:	fee79ae3          	bne	a5,a4,63e <memmove+0x46>
 64e:	bfc9                	j	620 <memmove+0x28>

0000000000000650 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 650:	1141                	addi	sp,sp,-16
 652:	e422                	sd	s0,8(sp)
 654:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 656:	ca05                	beqz	a2,686 <memcmp+0x36>
 658:	fff6069b          	addiw	a3,a2,-1
 65c:	1682                	slli	a3,a3,0x20
 65e:	9281                	srli	a3,a3,0x20
 660:	0685                	addi	a3,a3,1
 662:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 664:	00054783          	lbu	a5,0(a0)
 668:	0005c703          	lbu	a4,0(a1)
 66c:	00e79863          	bne	a5,a4,67c <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 670:	0505                	addi	a0,a0,1
        p2++;
 672:	0585                	addi	a1,a1,1
    while (n-- > 0)
 674:	fed518e3          	bne	a0,a3,664 <memcmp+0x14>
    }
    return 0;
 678:	4501                	li	a0,0
 67a:	a019                	j	680 <memcmp+0x30>
            return *p1 - *p2;
 67c:	40e7853b          	subw	a0,a5,a4
}
 680:	6422                	ld	s0,8(sp)
 682:	0141                	addi	sp,sp,16
 684:	8082                	ret
    return 0;
 686:	4501                	li	a0,0
 688:	bfe5                	j	680 <memcmp+0x30>

000000000000068a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 68a:	1141                	addi	sp,sp,-16
 68c:	e406                	sd	ra,8(sp)
 68e:	e022                	sd	s0,0(sp)
 690:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 692:	00000097          	auipc	ra,0x0
 696:	f66080e7          	jalr	-154(ra) # 5f8 <memmove>
}
 69a:	60a2                	ld	ra,8(sp)
 69c:	6402                	ld	s0,0(sp)
 69e:	0141                	addi	sp,sp,16
 6a0:	8082                	ret

00000000000006a2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6a2:	4885                	li	a7,1
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <exit>:
.global exit
exit:
 li a7, SYS_exit
 6aa:	4889                	li	a7,2
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6b2:	488d                	li	a7,3
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ba:	4891                	li	a7,4
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <read>:
.global read
read:
 li a7, SYS_read
 6c2:	4895                	li	a7,5
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <write>:
.global write
write:
 li a7, SYS_write
 6ca:	48c1                	li	a7,16
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <close>:
.global close
close:
 li a7, SYS_close
 6d2:	48d5                	li	a7,21
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <kill>:
.global kill
kill:
 li a7, SYS_kill
 6da:	4899                	li	a7,6
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6e2:	489d                	li	a7,7
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <open>:
.global open
open:
 li a7, SYS_open
 6ea:	48bd                	li	a7,15
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6f2:	48c5                	li	a7,17
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6fa:	48c9                	li	a7,18
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 702:	48a1                	li	a7,8
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <link>:
.global link
link:
 li a7, SYS_link
 70a:	48cd                	li	a7,19
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 712:	48d1                	li	a7,20
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 71a:	48a5                	li	a7,9
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <dup>:
.global dup
dup:
 li a7, SYS_dup
 722:	48a9                	li	a7,10
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 72a:	48ad                	li	a7,11
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 732:	48b1                	li	a7,12
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 73a:	48b5                	li	a7,13
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 742:	48b9                	li	a7,14
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <ps>:
.global ps
ps:
 li a7, SYS_ps
 74a:	48d9                	li	a7,22
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 752:	48dd                	li	a7,23
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 75a:	48e1                	li	a7,24
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 762:	1101                	addi	sp,sp,-32
 764:	ec06                	sd	ra,24(sp)
 766:	e822                	sd	s0,16(sp)
 768:	1000                	addi	s0,sp,32
 76a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 76e:	4605                	li	a2,1
 770:	fef40593          	addi	a1,s0,-17
 774:	00000097          	auipc	ra,0x0
 778:	f56080e7          	jalr	-170(ra) # 6ca <write>
}
 77c:	60e2                	ld	ra,24(sp)
 77e:	6442                	ld	s0,16(sp)
 780:	6105                	addi	sp,sp,32
 782:	8082                	ret

0000000000000784 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 784:	7139                	addi	sp,sp,-64
 786:	fc06                	sd	ra,56(sp)
 788:	f822                	sd	s0,48(sp)
 78a:	f426                	sd	s1,40(sp)
 78c:	f04a                	sd	s2,32(sp)
 78e:	ec4e                	sd	s3,24(sp)
 790:	0080                	addi	s0,sp,64
 792:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 794:	c299                	beqz	a3,79a <printint+0x16>
 796:	0805c963          	bltz	a1,828 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 79a:	2581                	sext.w	a1,a1
  neg = 0;
 79c:	4881                	li	a7,0
 79e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7a2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7a4:	2601                	sext.w	a2,a2
 7a6:	00000517          	auipc	a0,0x0
 7aa:	4f250513          	addi	a0,a0,1266 # c98 <digits>
 7ae:	883a                	mv	a6,a4
 7b0:	2705                	addiw	a4,a4,1
 7b2:	02c5f7bb          	remuw	a5,a1,a2
 7b6:	1782                	slli	a5,a5,0x20
 7b8:	9381                	srli	a5,a5,0x20
 7ba:	97aa                	add	a5,a5,a0
 7bc:	0007c783          	lbu	a5,0(a5)
 7c0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7c4:	0005879b          	sext.w	a5,a1
 7c8:	02c5d5bb          	divuw	a1,a1,a2
 7cc:	0685                	addi	a3,a3,1
 7ce:	fec7f0e3          	bgeu	a5,a2,7ae <printint+0x2a>
  if(neg)
 7d2:	00088c63          	beqz	a7,7ea <printint+0x66>
    buf[i++] = '-';
 7d6:	fd070793          	addi	a5,a4,-48
 7da:	00878733          	add	a4,a5,s0
 7de:	02d00793          	li	a5,45
 7e2:	fef70823          	sb	a5,-16(a4)
 7e6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7ea:	02e05863          	blez	a4,81a <printint+0x96>
 7ee:	fc040793          	addi	a5,s0,-64
 7f2:	00e78933          	add	s2,a5,a4
 7f6:	fff78993          	addi	s3,a5,-1
 7fa:	99ba                	add	s3,s3,a4
 7fc:	377d                	addiw	a4,a4,-1
 7fe:	1702                	slli	a4,a4,0x20
 800:	9301                	srli	a4,a4,0x20
 802:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 806:	fff94583          	lbu	a1,-1(s2)
 80a:	8526                	mv	a0,s1
 80c:	00000097          	auipc	ra,0x0
 810:	f56080e7          	jalr	-170(ra) # 762 <putc>
  while(--i >= 0)
 814:	197d                	addi	s2,s2,-1
 816:	ff3918e3          	bne	s2,s3,806 <printint+0x82>
}
 81a:	70e2                	ld	ra,56(sp)
 81c:	7442                	ld	s0,48(sp)
 81e:	74a2                	ld	s1,40(sp)
 820:	7902                	ld	s2,32(sp)
 822:	69e2                	ld	s3,24(sp)
 824:	6121                	addi	sp,sp,64
 826:	8082                	ret
    x = -xx;
 828:	40b005bb          	negw	a1,a1
    neg = 1;
 82c:	4885                	li	a7,1
    x = -xx;
 82e:	bf85                	j	79e <printint+0x1a>

0000000000000830 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 830:	715d                	addi	sp,sp,-80
 832:	e486                	sd	ra,72(sp)
 834:	e0a2                	sd	s0,64(sp)
 836:	fc26                	sd	s1,56(sp)
 838:	f84a                	sd	s2,48(sp)
 83a:	f44e                	sd	s3,40(sp)
 83c:	f052                	sd	s4,32(sp)
 83e:	ec56                	sd	s5,24(sp)
 840:	e85a                	sd	s6,16(sp)
 842:	e45e                	sd	s7,8(sp)
 844:	e062                	sd	s8,0(sp)
 846:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 848:	0005c903          	lbu	s2,0(a1)
 84c:	18090c63          	beqz	s2,9e4 <vprintf+0x1b4>
 850:	8aaa                	mv	s5,a0
 852:	8bb2                	mv	s7,a2
 854:	00158493          	addi	s1,a1,1
  state = 0;
 858:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 85a:	02500a13          	li	s4,37
 85e:	4b55                	li	s6,21
 860:	a839                	j	87e <vprintf+0x4e>
        putc(fd, c);
 862:	85ca                	mv	a1,s2
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	efc080e7          	jalr	-260(ra) # 762 <putc>
 86e:	a019                	j	874 <vprintf+0x44>
    } else if(state == '%'){
 870:	01498d63          	beq	s3,s4,88a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 874:	0485                	addi	s1,s1,1
 876:	fff4c903          	lbu	s2,-1(s1)
 87a:	16090563          	beqz	s2,9e4 <vprintf+0x1b4>
    if(state == 0){
 87e:	fe0999e3          	bnez	s3,870 <vprintf+0x40>
      if(c == '%'){
 882:	ff4910e3          	bne	s2,s4,862 <vprintf+0x32>
        state = '%';
 886:	89d2                	mv	s3,s4
 888:	b7f5                	j	874 <vprintf+0x44>
      if(c == 'd'){
 88a:	13490263          	beq	s2,s4,9ae <vprintf+0x17e>
 88e:	f9d9079b          	addiw	a5,s2,-99
 892:	0ff7f793          	zext.b	a5,a5
 896:	12fb6563          	bltu	s6,a5,9c0 <vprintf+0x190>
 89a:	f9d9079b          	addiw	a5,s2,-99
 89e:	0ff7f713          	zext.b	a4,a5
 8a2:	10eb6f63          	bltu	s6,a4,9c0 <vprintf+0x190>
 8a6:	00271793          	slli	a5,a4,0x2
 8aa:	00000717          	auipc	a4,0x0
 8ae:	39670713          	addi	a4,a4,918 # c40 <malloc+0x15e>
 8b2:	97ba                	add	a5,a5,a4
 8b4:	439c                	lw	a5,0(a5)
 8b6:	97ba                	add	a5,a5,a4
 8b8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8ba:	008b8913          	addi	s2,s7,8
 8be:	4685                	li	a3,1
 8c0:	4629                	li	a2,10
 8c2:	000ba583          	lw	a1,0(s7)
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	ebc080e7          	jalr	-324(ra) # 784 <printint>
 8d0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	b745                	j	874 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d6:	008b8913          	addi	s2,s7,8
 8da:	4681                	li	a3,0
 8dc:	4629                	li	a2,10
 8de:	000ba583          	lw	a1,0(s7)
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	ea0080e7          	jalr	-352(ra) # 784 <printint>
 8ec:	8bca                	mv	s7,s2
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	b751                	j	874 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8f2:	008b8913          	addi	s2,s7,8
 8f6:	4681                	li	a3,0
 8f8:	4641                	li	a2,16
 8fa:	000ba583          	lw	a1,0(s7)
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	e84080e7          	jalr	-380(ra) # 784 <printint>
 908:	8bca                	mv	s7,s2
      state = 0;
 90a:	4981                	li	s3,0
 90c:	b7a5                	j	874 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 90e:	008b8c13          	addi	s8,s7,8
 912:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 916:	03000593          	li	a1,48
 91a:	8556                	mv	a0,s5
 91c:	00000097          	auipc	ra,0x0
 920:	e46080e7          	jalr	-442(ra) # 762 <putc>
  putc(fd, 'x');
 924:	07800593          	li	a1,120
 928:	8556                	mv	a0,s5
 92a:	00000097          	auipc	ra,0x0
 92e:	e38080e7          	jalr	-456(ra) # 762 <putc>
 932:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 934:	00000b97          	auipc	s7,0x0
 938:	364b8b93          	addi	s7,s7,868 # c98 <digits>
 93c:	03c9d793          	srli	a5,s3,0x3c
 940:	97de                	add	a5,a5,s7
 942:	0007c583          	lbu	a1,0(a5)
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	e1a080e7          	jalr	-486(ra) # 762 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 950:	0992                	slli	s3,s3,0x4
 952:	397d                	addiw	s2,s2,-1
 954:	fe0914e3          	bnez	s2,93c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 958:	8be2                	mv	s7,s8
      state = 0;
 95a:	4981                	li	s3,0
 95c:	bf21                	j	874 <vprintf+0x44>
        s = va_arg(ap, char*);
 95e:	008b8993          	addi	s3,s7,8
 962:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 966:	02090163          	beqz	s2,988 <vprintf+0x158>
        while(*s != 0){
 96a:	00094583          	lbu	a1,0(s2)
 96e:	c9a5                	beqz	a1,9de <vprintf+0x1ae>
          putc(fd, *s);
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	df0080e7          	jalr	-528(ra) # 762 <putc>
          s++;
 97a:	0905                	addi	s2,s2,1
        while(*s != 0){
 97c:	00094583          	lbu	a1,0(s2)
 980:	f9e5                	bnez	a1,970 <vprintf+0x140>
        s = va_arg(ap, char*);
 982:	8bce                	mv	s7,s3
      state = 0;
 984:	4981                	li	s3,0
 986:	b5fd                	j	874 <vprintf+0x44>
          s = "(null)";
 988:	00000917          	auipc	s2,0x0
 98c:	2b090913          	addi	s2,s2,688 # c38 <malloc+0x156>
        while(*s != 0){
 990:	02800593          	li	a1,40
 994:	bff1                	j	970 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 996:	008b8913          	addi	s2,s7,8
 99a:	000bc583          	lbu	a1,0(s7)
 99e:	8556                	mv	a0,s5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	dc2080e7          	jalr	-574(ra) # 762 <putc>
 9a8:	8bca                	mv	s7,s2
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b5e1                	j	874 <vprintf+0x44>
        putc(fd, c);
 9ae:	02500593          	li	a1,37
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	dae080e7          	jalr	-594(ra) # 762 <putc>
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	bd5d                	j	874 <vprintf+0x44>
        putc(fd, '%');
 9c0:	02500593          	li	a1,37
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	d9c080e7          	jalr	-612(ra) # 762 <putc>
        putc(fd, c);
 9ce:	85ca                	mv	a1,s2
 9d0:	8556                	mv	a0,s5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	d90080e7          	jalr	-624(ra) # 762 <putc>
      state = 0;
 9da:	4981                	li	s3,0
 9dc:	bd61                	j	874 <vprintf+0x44>
        s = va_arg(ap, char*);
 9de:	8bce                	mv	s7,s3
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	bd49                	j	874 <vprintf+0x44>
    }
  }
}
 9e4:	60a6                	ld	ra,72(sp)
 9e6:	6406                	ld	s0,64(sp)
 9e8:	74e2                	ld	s1,56(sp)
 9ea:	7942                	ld	s2,48(sp)
 9ec:	79a2                	ld	s3,40(sp)
 9ee:	7a02                	ld	s4,32(sp)
 9f0:	6ae2                	ld	s5,24(sp)
 9f2:	6b42                	ld	s6,16(sp)
 9f4:	6ba2                	ld	s7,8(sp)
 9f6:	6c02                	ld	s8,0(sp)
 9f8:	6161                	addi	sp,sp,80
 9fa:	8082                	ret

00000000000009fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9fc:	715d                	addi	sp,sp,-80
 9fe:	ec06                	sd	ra,24(sp)
 a00:	e822                	sd	s0,16(sp)
 a02:	1000                	addi	s0,sp,32
 a04:	e010                	sd	a2,0(s0)
 a06:	e414                	sd	a3,8(s0)
 a08:	e818                	sd	a4,16(s0)
 a0a:	ec1c                	sd	a5,24(s0)
 a0c:	03043023          	sd	a6,32(s0)
 a10:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a14:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a18:	8622                	mv	a2,s0
 a1a:	00000097          	auipc	ra,0x0
 a1e:	e16080e7          	jalr	-490(ra) # 830 <vprintf>
}
 a22:	60e2                	ld	ra,24(sp)
 a24:	6442                	ld	s0,16(sp)
 a26:	6161                	addi	sp,sp,80
 a28:	8082                	ret

0000000000000a2a <printf>:

void
printf(const char *fmt, ...)
{
 a2a:	711d                	addi	sp,sp,-96
 a2c:	ec06                	sd	ra,24(sp)
 a2e:	e822                	sd	s0,16(sp)
 a30:	1000                	addi	s0,sp,32
 a32:	e40c                	sd	a1,8(s0)
 a34:	e810                	sd	a2,16(s0)
 a36:	ec14                	sd	a3,24(s0)
 a38:	f018                	sd	a4,32(s0)
 a3a:	f41c                	sd	a5,40(s0)
 a3c:	03043823          	sd	a6,48(s0)
 a40:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a44:	00840613          	addi	a2,s0,8
 a48:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a4c:	85aa                	mv	a1,a0
 a4e:	4505                	li	a0,1
 a50:	00000097          	auipc	ra,0x0
 a54:	de0080e7          	jalr	-544(ra) # 830 <vprintf>
}
 a58:	60e2                	ld	ra,24(sp)
 a5a:	6442                	ld	s0,16(sp)
 a5c:	6125                	addi	sp,sp,96
 a5e:	8082                	ret

0000000000000a60 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a60:	1141                	addi	sp,sp,-16
 a62:	e422                	sd	s0,8(sp)
 a64:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a66:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a6a:	00000797          	auipc	a5,0x0
 a6e:	5ae7b783          	ld	a5,1454(a5) # 1018 <freep>
 a72:	a02d                	j	a9c <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a74:	4618                	lw	a4,8(a2)
 a76:	9f2d                	addw	a4,a4,a1
 a78:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a7c:	6398                	ld	a4,0(a5)
 a7e:	6310                	ld	a2,0(a4)
 a80:	a83d                	j	abe <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a82:	ff852703          	lw	a4,-8(a0)
 a86:	9f31                	addw	a4,a4,a2
 a88:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a8a:	ff053683          	ld	a3,-16(a0)
 a8e:	a091                	j	ad2 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a90:	6398                	ld	a4,0(a5)
 a92:	00e7e463          	bltu	a5,a4,a9a <free+0x3a>
 a96:	00e6ea63          	bltu	a3,a4,aaa <free+0x4a>
{
 a9a:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9c:	fed7fae3          	bgeu	a5,a3,a90 <free+0x30>
 aa0:	6398                	ld	a4,0(a5)
 aa2:	00e6e463          	bltu	a3,a4,aaa <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa6:	fee7eae3          	bltu	a5,a4,a9a <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aaa:	ff852583          	lw	a1,-8(a0)
 aae:	6390                	ld	a2,0(a5)
 ab0:	02059813          	slli	a6,a1,0x20
 ab4:	01c85713          	srli	a4,a6,0x1c
 ab8:	9736                	add	a4,a4,a3
 aba:	fae60de3          	beq	a2,a4,a74 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 abe:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ac2:	4790                	lw	a2,8(a5)
 ac4:	02061593          	slli	a1,a2,0x20
 ac8:	01c5d713          	srli	a4,a1,0x1c
 acc:	973e                	add	a4,a4,a5
 ace:	fae68ae3          	beq	a3,a4,a82 <free+0x22>
        p->s.ptr = bp->s.ptr;
 ad2:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ad4:	00000717          	auipc	a4,0x0
 ad8:	54f73223          	sd	a5,1348(a4) # 1018 <freep>
}
 adc:	6422                	ld	s0,8(sp)
 ade:	0141                	addi	sp,sp,16
 ae0:	8082                	ret

0000000000000ae2 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ae2:	7139                	addi	sp,sp,-64
 ae4:	fc06                	sd	ra,56(sp)
 ae6:	f822                	sd	s0,48(sp)
 ae8:	f426                	sd	s1,40(sp)
 aea:	f04a                	sd	s2,32(sp)
 aec:	ec4e                	sd	s3,24(sp)
 aee:	e852                	sd	s4,16(sp)
 af0:	e456                	sd	s5,8(sp)
 af2:	e05a                	sd	s6,0(sp)
 af4:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 af6:	02051493          	slli	s1,a0,0x20
 afa:	9081                	srli	s1,s1,0x20
 afc:	04bd                	addi	s1,s1,15
 afe:	8091                	srli	s1,s1,0x4
 b00:	0014899b          	addiw	s3,s1,1
 b04:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b06:	00000517          	auipc	a0,0x0
 b0a:	51253503          	ld	a0,1298(a0) # 1018 <freep>
 b0e:	c515                	beqz	a0,b3a <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b10:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b12:	4798                	lw	a4,8(a5)
 b14:	02977f63          	bgeu	a4,s1,b52 <malloc+0x70>
    if (nu < 4096)
 b18:	8a4e                	mv	s4,s3
 b1a:	0009871b          	sext.w	a4,s3
 b1e:	6685                	lui	a3,0x1
 b20:	00d77363          	bgeu	a4,a3,b26 <malloc+0x44>
 b24:	6a05                	lui	s4,0x1
 b26:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b2a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b2e:	00000917          	auipc	s2,0x0
 b32:	4ea90913          	addi	s2,s2,1258 # 1018 <freep>
    if (p == (char *)-1)
 b36:	5afd                	li	s5,-1
 b38:	a895                	j	bac <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b3a:	00000797          	auipc	a5,0x0
 b3e:	56678793          	addi	a5,a5,1382 # 10a0 <base>
 b42:	00000717          	auipc	a4,0x0
 b46:	4cf73b23          	sd	a5,1238(a4) # 1018 <freep>
 b4a:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b4c:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b50:	b7e1                	j	b18 <malloc+0x36>
            if (p->s.size == nunits)
 b52:	02e48c63          	beq	s1,a4,b8a <malloc+0xa8>
                p->s.size -= nunits;
 b56:	4137073b          	subw	a4,a4,s3
 b5a:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b5c:	02071693          	slli	a3,a4,0x20
 b60:	01c6d713          	srli	a4,a3,0x1c
 b64:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b66:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b6a:	00000717          	auipc	a4,0x0
 b6e:	4aa73723          	sd	a0,1198(a4) # 1018 <freep>
            return (void *)(p + 1);
 b72:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b76:	70e2                	ld	ra,56(sp)
 b78:	7442                	ld	s0,48(sp)
 b7a:	74a2                	ld	s1,40(sp)
 b7c:	7902                	ld	s2,32(sp)
 b7e:	69e2                	ld	s3,24(sp)
 b80:	6a42                	ld	s4,16(sp)
 b82:	6aa2                	ld	s5,8(sp)
 b84:	6b02                	ld	s6,0(sp)
 b86:	6121                	addi	sp,sp,64
 b88:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b8a:	6398                	ld	a4,0(a5)
 b8c:	e118                	sd	a4,0(a0)
 b8e:	bff1                	j	b6a <malloc+0x88>
    hp->s.size = nu;
 b90:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b94:	0541                	addi	a0,a0,16
 b96:	00000097          	auipc	ra,0x0
 b9a:	eca080e7          	jalr	-310(ra) # a60 <free>
    return freep;
 b9e:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 ba2:	d971                	beqz	a0,b76 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ba4:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ba6:	4798                	lw	a4,8(a5)
 ba8:	fa9775e3          	bgeu	a4,s1,b52 <malloc+0x70>
        if (p == freep)
 bac:	00093703          	ld	a4,0(s2)
 bb0:	853e                	mv	a0,a5
 bb2:	fef719e3          	bne	a4,a5,ba4 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bb6:	8552                	mv	a0,s4
 bb8:	00000097          	auipc	ra,0x0
 bbc:	b7a080e7          	jalr	-1158(ra) # 732 <sbrk>
    if (p == (char *)-1)
 bc0:	fd5518e3          	bne	a0,s5,b90 <malloc+0xae>
                return 0;
 bc4:	4501                	li	a0,0
 bc6:	bf45                	j	b76 <malloc+0x94>
