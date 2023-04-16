
user/_task1test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <hello_world>:
#include "kernel/types.h"
#include "user.h"

void *hello_world(void *arg)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    printf("Hello World\n");
   8:	00001517          	auipc	a0,0x1
   c:	c2850513          	addi	a0,a0,-984 # c30 <malloc+0xea>
  10:	00001097          	auipc	ra,0x1
  14:	a7e080e7          	jalr	-1410(ra) # a8e <printf>
    return 0; // will be ignored, but just to make the compiler happy
}
  18:	4501                	li	a0,0
  1a:	60a2                	ld	ra,8(sp)
  1c:	6402                	ld	s0,0(sp)
  1e:	0141                	addi	sp,sp,16
  20:	8082                	ret

0000000000000022 <main>:

void main()
{
  22:	1101                	addi	sp,sp,-32
  24:	ec06                	sd	ra,24(sp)
  26:	e822                	sd	s0,16(sp)
  28:	1000                	addi	s0,sp,32
    // t not initialized
    struct thread *t;

    // passing &t (taking the address of the pointer value)
    tcreate(&t, 0, &hello_world, 0);
  2a:	4681                	li	a3,0
  2c:	00000617          	auipc	a2,0x0
  30:	fd460613          	addi	a2,a2,-44 # 0 <hello_world>
  34:	4581                	li	a1,0
  36:	fe840513          	addi	a0,s0,-24
  3a:	00000097          	auipc	ra,0x0
  3e:	1f4080e7          	jalr	500(ra) # 22e <tcreate>
    // Now, t points to an initialized thread struct

    tyield();
  42:	00000097          	auipc	ra,0x0
  46:	2f8080e7          	jalr	760(ra) # 33a <tyield>
  4a:	60e2                	ld	ra,24(sp)
  4c:	6442                	ld	s0,16(sp)
  4e:	6105                	addi	sp,sp,32
  50:	8082                	ret

0000000000000052 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  52:	1141                	addi	sp,sp,-16
  54:	e422                	sd	s0,8(sp)
  56:	0800                	addi	s0,sp,16
    lk->name = name;
  58:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  5a:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  5e:	57fd                	li	a5,-1
  60:	00f50823          	sb	a5,16(a0)
}
  64:	6422                	ld	s0,8(sp)
  66:	0141                	addi	sp,sp,16
  68:	8082                	ret

000000000000006a <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  6a:	00054783          	lbu	a5,0(a0)
  6e:	e399                	bnez	a5,74 <holding+0xa>
  70:	4501                	li	a0,0
}
  72:	8082                	ret
{
  74:	1101                	addi	sp,sp,-32
  76:	ec06                	sd	ra,24(sp)
  78:	e822                	sd	s0,16(sp)
  7a:	e426                	sd	s1,8(sp)
  7c:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  7e:	01054483          	lbu	s1,16(a0)
  82:	00000097          	auipc	ra,0x0
  86:	2dc080e7          	jalr	732(ra) # 35e <twhoami>
  8a:	2501                	sext.w	a0,a0
  8c:	40a48533          	sub	a0,s1,a0
  90:	00153513          	seqz	a0,a0
}
  94:	60e2                	ld	ra,24(sp)
  96:	6442                	ld	s0,16(sp)
  98:	64a2                	ld	s1,8(sp)
  9a:	6105                	addi	sp,sp,32
  9c:	8082                	ret

000000000000009e <acquire>:

void acquire(struct lock *lk)
{
  9e:	7179                	addi	sp,sp,-48
  a0:	f406                	sd	ra,40(sp)
  a2:	f022                	sd	s0,32(sp)
  a4:	ec26                	sd	s1,24(sp)
  a6:	e84a                	sd	s2,16(sp)
  a8:	e44e                	sd	s3,8(sp)
  aa:	e052                	sd	s4,0(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	8a2a                	mv	s4,a0
    if (holding(lk))
  b0:	00000097          	auipc	ra,0x0
  b4:	fba080e7          	jalr	-70(ra) # 6a <holding>
  b8:	e919                	bnez	a0,ce <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  ba:	ffca7493          	andi	s1,s4,-4
  be:	003a7913          	andi	s2,s4,3
  c2:	0039191b          	slliw	s2,s2,0x3
  c6:	4985                	li	s3,1
  c8:	012999bb          	sllw	s3,s3,s2
  cc:	a015                	j	f0 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  ce:	00001517          	auipc	a0,0x1
  d2:	b7250513          	addi	a0,a0,-1166 # c40 <malloc+0xfa>
  d6:	00001097          	auipc	ra,0x1
  da:	9b8080e7          	jalr	-1608(ra) # a8e <printf>
        exit(-1);
  de:	557d                	li	a0,-1
  e0:	00000097          	auipc	ra,0x0
  e4:	62e080e7          	jalr	1582(ra) # 70e <exit>
    {
        // give up the cpu for other threads
        tyield();
  e8:	00000097          	auipc	ra,0x0
  ec:	252080e7          	jalr	594(ra) # 33a <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f0:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  f4:	0127d7bb          	srlw	a5,a5,s2
  f8:	0ff7f793          	zext.b	a5,a5
  fc:	f7f5                	bnez	a5,e8 <acquire+0x4a>
    }

    __sync_synchronize();
  fe:	0ff0000f          	fence

    lk->tid = twhoami();
 102:	00000097          	auipc	ra,0x0
 106:	25c080e7          	jalr	604(ra) # 35e <twhoami>
 10a:	00aa0823          	sb	a0,16(s4)
}
 10e:	70a2                	ld	ra,40(sp)
 110:	7402                	ld	s0,32(sp)
 112:	64e2                	ld	s1,24(sp)
 114:	6942                	ld	s2,16(sp)
 116:	69a2                	ld	s3,8(sp)
 118:	6a02                	ld	s4,0(sp)
 11a:	6145                	addi	sp,sp,48
 11c:	8082                	ret

000000000000011e <release>:

void release(struct lock *lk)
{
 11e:	1101                	addi	sp,sp,-32
 120:	ec06                	sd	ra,24(sp)
 122:	e822                	sd	s0,16(sp)
 124:	e426                	sd	s1,8(sp)
 126:	1000                	addi	s0,sp,32
 128:	84aa                	mv	s1,a0
    if (!holding(lk))
 12a:	00000097          	auipc	ra,0x0
 12e:	f40080e7          	jalr	-192(ra) # 6a <holding>
 132:	c11d                	beqz	a0,158 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 134:	57fd                	li	a5,-1
 136:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 13a:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 13e:	0ff0000f          	fence
 142:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 146:	00000097          	auipc	ra,0x0
 14a:	1f4080e7          	jalr	500(ra) # 33a <tyield>
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret
        printf("releasing lock we are not holding");
 158:	00001517          	auipc	a0,0x1
 15c:	b1050513          	addi	a0,a0,-1264 # c68 <malloc+0x122>
 160:	00001097          	auipc	ra,0x1
 164:	92e080e7          	jalr	-1746(ra) # a8e <printf>
        exit(-1);
 168:	557d                	li	a0,-1
 16a:	00000097          	auipc	ra,0x0
 16e:	5a4080e7          	jalr	1444(ra) # 70e <exit>

0000000000000172 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 172:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 174:	00001617          	auipc	a2,0x1
 178:	eac60613          	addi	a2,a2,-340 # 1020 <threads>
 17c:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 17e:	45c1                	li	a1,16
 180:	a021                	j	188 <tsched+0x16>
 182:	2685                	addiw	a3,a3,1
 184:	08b68c63          	beq	a3,a1,21c <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 188:	41f6d71b          	sraiw	a4,a3,0x1f
 18c:	01c7571b          	srliw	a4,a4,0x1c
 190:	00d707bb          	addw	a5,a4,a3
 194:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 196:	9f99                	subw	a5,a5,a4
 198:	078e                	slli	a5,a5,0x3
 19a:	97b2                	add	a5,a5,a2
 19c:	639c                	ld	a5,0(a5)
 19e:	d3f5                	beqz	a5,182 <tsched+0x10>
 1a0:	5fb8                	lw	a4,120(a5)
 1a2:	fea710e3          	bne	a4,a0,182 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1a6:	00001717          	auipc	a4,0x1
 1aa:	e7a73703          	ld	a4,-390(a4) # 1020 <threads>
 1ae:	5f30                	lw	a2,120(a4)
 1b0:	468d                	li	a3,3
 1b2:	06d60363          	beq	a2,a3,218 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1b6:	c3a5                	beqz	a5,216 <tsched+0xa4>
{
 1b8:	1101                	addi	sp,sp,-32
 1ba:	ec06                	sd	ra,24(sp)
 1bc:	e822                	sd	s0,16(sp)
 1be:	e426                	sd	s1,8(sp)
 1c0:	e04a                	sd	s2,0(sp)
 1c2:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1c4:	00001497          	auipc	s1,0x1
 1c8:	e4c48493          	addi	s1,s1,-436 # 1010 <current_thread>
 1cc:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1d0:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1d2:	0007c603          	lbu	a2,0(a5)
 1d6:	00094583          	lbu	a1,0(s2)
 1da:	00001517          	auipc	a0,0x1
 1de:	ab650513          	addi	a0,a0,-1354 # c90 <malloc+0x14a>
 1e2:	00001097          	auipc	ra,0x1
 1e6:	8ac080e7          	jalr	-1876(ra) # a8e <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1ea:	608c                	ld	a1,0(s1)
 1ec:	05a1                	addi	a1,a1,8
 1ee:	00890513          	addi	a0,s2,8
 1f2:	00000097          	auipc	ra,0x0
 1f6:	184080e7          	jalr	388(ra) # 376 <tswtch>
        printf("Thread switch complete\n");
 1fa:	00001517          	auipc	a0,0x1
 1fe:	abe50513          	addi	a0,a0,-1346 # cb8 <malloc+0x172>
 202:	00001097          	auipc	ra,0x1
 206:	88c080e7          	jalr	-1908(ra) # a8e <printf>
    }
}
 20a:	60e2                	ld	ra,24(sp)
 20c:	6442                	ld	s0,16(sp)
 20e:	64a2                	ld	s1,8(sp)
 210:	6902                	ld	s2,0(sp)
 212:	6105                	addi	sp,sp,32
 214:	8082                	ret
 216:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 218:	87ba                	mv	a5,a4
 21a:	bf79                	j	1b8 <tsched+0x46>
 21c:	00001797          	auipc	a5,0x1
 220:	e047b783          	ld	a5,-508(a5) # 1020 <threads>
 224:	5fb4                	lw	a3,120(a5)
 226:	470d                	li	a4,3
 228:	f8e688e3          	beq	a3,a4,1b8 <tsched+0x46>
 22c:	8082                	ret

000000000000022e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 22e:	7179                	addi	sp,sp,-48
 230:	f406                	sd	ra,40(sp)
 232:	f022                	sd	s0,32(sp)
 234:	ec26                	sd	s1,24(sp)
 236:	e84a                	sd	s2,16(sp)
 238:	e44e                	sd	s3,8(sp)
 23a:	1800                	addi	s0,sp,48
 23c:	84aa                	mv	s1,a0
 23e:	89b2                	mv	s3,a2
 240:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 242:	09000513          	li	a0,144
 246:	00001097          	auipc	ra,0x1
 24a:	900080e7          	jalr	-1792(ra) # b46 <malloc>
 24e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 250:	478d                	li	a5,3
 252:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 254:	609c                	ld	a5,0(s1)
 256:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 25a:	609c                	ld	a5,0(s1)
 25c:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 260:	00001717          	auipc	a4,0x1
 264:	da070713          	addi	a4,a4,-608 # 1000 <next_tid>
 268:	431c                	lw	a5,0(a4)
 26a:	0017869b          	addiw	a3,a5,1
 26e:	c314                	sw	a3,0(a4)
 270:	6098                	ld	a4,0(s1)
 272:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 276:	00001717          	auipc	a4,0x1
 27a:	daa70713          	addi	a4,a4,-598 # 1020 <threads>
 27e:	4781                	li	a5,0
 280:	4641                	li	a2,16
    if (threads[i] == NULL) {
 282:	6314                	ld	a3,0(a4)
 284:	ce81                	beqz	a3,29c <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 286:	2785                	addiw	a5,a5,1
 288:	0721                	addi	a4,a4,8
 28a:	fec79ce3          	bne	a5,a2,282 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 28e:	70a2                	ld	ra,40(sp)
 290:	7402                	ld	s0,32(sp)
 292:	64e2                	ld	s1,24(sp)
 294:	6942                	ld	s2,16(sp)
 296:	69a2                	ld	s3,8(sp)
 298:	6145                	addi	sp,sp,48
 29a:	8082                	ret
        threads[i] = *thread;
 29c:	6094                	ld	a3,0(s1)
 29e:	078e                	slli	a5,a5,0x3
 2a0:	00001717          	auipc	a4,0x1
 2a4:	d8070713          	addi	a4,a4,-640 # 1020 <threads>
 2a8:	97ba                	add	a5,a5,a4
 2aa:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2ac:	0006c583          	lbu	a1,0(a3)
 2b0:	00001517          	auipc	a0,0x1
 2b4:	a2050513          	addi	a0,a0,-1504 # cd0 <malloc+0x18a>
 2b8:	00000097          	auipc	ra,0x0
 2bc:	7d6080e7          	jalr	2006(ra) # a8e <printf>
        break;
 2c0:	b7f9                	j	28e <tcreate+0x60>

00000000000002c2 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2c2:	7179                	addi	sp,sp,-48
 2c4:	f406                	sd	ra,40(sp)
 2c6:	f022                	sd	s0,32(sp)
 2c8:	ec26                	sd	s1,24(sp)
 2ca:	e84a                	sd	s2,16(sp)
 2cc:	e44e                	sd	s3,8(sp)
 2ce:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2d0:	00001797          	auipc	a5,0x1
 2d4:	d5078793          	addi	a5,a5,-688 # 1020 <threads>
 2d8:	00001697          	auipc	a3,0x1
 2dc:	dc868693          	addi	a3,a3,-568 # 10a0 <base>
 2e0:	a021                	j	2e8 <tjoin+0x26>
 2e2:	07a1                	addi	a5,a5,8
 2e4:	04d78763          	beq	a5,a3,332 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2e8:	6384                	ld	s1,0(a5)
 2ea:	dce5                	beqz	s1,2e2 <tjoin+0x20>
 2ec:	0004c703          	lbu	a4,0(s1)
 2f0:	fea719e3          	bne	a4,a0,2e2 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 2f4:	5cb8                	lw	a4,120(s1)
 2f6:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2f8:	00001997          	auipc	s3,0x1
 2fc:	a0898993          	addi	s3,s3,-1528 # d00 <malloc+0x1ba>
    while (target_thread->state != EXITED) {
 300:	4919                	li	s2,6
 302:	02f70a63          	beq	a4,a5,336 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 306:	0004c583          	lbu	a1,0(s1)
 30a:	854e                	mv	a0,s3
 30c:	00000097          	auipc	ra,0x0
 310:	782080e7          	jalr	1922(ra) # a8e <printf>
        tsched();
 314:	00000097          	auipc	ra,0x0
 318:	e5e080e7          	jalr	-418(ra) # 172 <tsched>
    while (target_thread->state != EXITED) {
 31c:	5cbc                	lw	a5,120(s1)
 31e:	ff2794e3          	bne	a5,s2,306 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 322:	4501                	li	a0,0
}
 324:	70a2                	ld	ra,40(sp)
 326:	7402                	ld	s0,32(sp)
 328:	64e2                	ld	s1,24(sp)
 32a:	6942                	ld	s2,16(sp)
 32c:	69a2                	ld	s3,8(sp)
 32e:	6145                	addi	sp,sp,48
 330:	8082                	ret
        return -1;
 332:	557d                	li	a0,-1
 334:	bfc5                	j	324 <tjoin+0x62>
    return 0;
 336:	4501                	li	a0,0
 338:	b7f5                	j	324 <tjoin+0x62>

000000000000033a <tyield>:


void tyield()
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 342:	00001797          	auipc	a5,0x1
 346:	cce7b783          	ld	a5,-818(a5) # 1010 <current_thread>
 34a:	470d                	li	a4,3
 34c:	dfb8                	sw	a4,120(a5)
    tsched();
 34e:	00000097          	auipc	ra,0x0
 352:	e24080e7          	jalr	-476(ra) # 172 <tsched>
}
 356:	60a2                	ld	ra,8(sp)
 358:	6402                	ld	s0,0(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <twhoami>:

uint8 twhoami()
{
 35e:	1141                	addi	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 364:	00001797          	auipc	a5,0x1
 368:	cac7b783          	ld	a5,-852(a5) # 1010 <current_thread>
 36c:	0007c503          	lbu	a0,0(a5)
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <tswtch>:
 376:	00153023          	sd	ra,0(a0)
 37a:	00253423          	sd	sp,8(a0)
 37e:	e900                	sd	s0,16(a0)
 380:	ed04                	sd	s1,24(a0)
 382:	03253023          	sd	s2,32(a0)
 386:	03353423          	sd	s3,40(a0)
 38a:	03453823          	sd	s4,48(a0)
 38e:	03553c23          	sd	s5,56(a0)
 392:	05653023          	sd	s6,64(a0)
 396:	05753423          	sd	s7,72(a0)
 39a:	05853823          	sd	s8,80(a0)
 39e:	05953c23          	sd	s9,88(a0)
 3a2:	07a53023          	sd	s10,96(a0)
 3a6:	07b53423          	sd	s11,104(a0)
 3aa:	0005b083          	ld	ra,0(a1)
 3ae:	0085b103          	ld	sp,8(a1)
 3b2:	6980                	ld	s0,16(a1)
 3b4:	6d84                	ld	s1,24(a1)
 3b6:	0205b903          	ld	s2,32(a1)
 3ba:	0285b983          	ld	s3,40(a1)
 3be:	0305ba03          	ld	s4,48(a1)
 3c2:	0385ba83          	ld	s5,56(a1)
 3c6:	0405bb03          	ld	s6,64(a1)
 3ca:	0485bb83          	ld	s7,72(a1)
 3ce:	0505bc03          	ld	s8,80(a1)
 3d2:	0585bc83          	ld	s9,88(a1)
 3d6:	0605bd03          	ld	s10,96(a1)
 3da:	0685bd83          	ld	s11,104(a1)
 3de:	8082                	ret

00000000000003e0 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3e0:	715d                	addi	sp,sp,-80
 3e2:	e486                	sd	ra,72(sp)
 3e4:	e0a2                	sd	s0,64(sp)
 3e6:	fc26                	sd	s1,56(sp)
 3e8:	f84a                	sd	s2,48(sp)
 3ea:	f44e                	sd	s3,40(sp)
 3ec:	f052                	sd	s4,32(sp)
 3ee:	ec56                	sd	s5,24(sp)
 3f0:	e85a                	sd	s6,16(sp)
 3f2:	e45e                	sd	s7,8(sp)
 3f4:	0880                	addi	s0,sp,80
 3f6:	892a                	mv	s2,a0
 3f8:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 3fa:	00001517          	auipc	a0,0x1
 3fe:	92650513          	addi	a0,a0,-1754 # d20 <malloc+0x1da>
 402:	00000097          	auipc	ra,0x0
 406:	68c080e7          	jalr	1676(ra) # a8e <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 40a:	09000513          	li	a0,144
 40e:	00000097          	auipc	ra,0x0
 412:	738080e7          	jalr	1848(ra) # b46 <malloc>

    main_thread->tid = 0;
 416:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 41a:	4791                	li	a5,4
 41c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 41e:	00001797          	auipc	a5,0x1
 422:	bea7b923          	sd	a0,-1038(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 426:	00001a17          	auipc	s4,0x1
 42a:	bfaa0a13          	addi	s4,s4,-1030 # 1020 <threads>
 42e:	00001497          	auipc	s1,0x1
 432:	c7248493          	addi	s1,s1,-910 # 10a0 <base>
    current_thread = main_thread;
 436:	87d2                	mv	a5,s4
        threads[i] = NULL;
 438:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 43c:	07a1                	addi	a5,a5,8
 43e:	fe979de3          	bne	a5,s1,438 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 442:	00001797          	auipc	a5,0x1
 446:	bca7bf23          	sd	a0,-1058(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 44a:	85ce                	mv	a1,s3
 44c:	854a                	mv	a0,s2
 44e:	00000097          	auipc	ra,0x0
 452:	bd4080e7          	jalr	-1068(ra) # 22 <main>
 456:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 458:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 45a:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 45c:	00001a97          	auipc	s5,0x1
 460:	8e4a8a93          	addi	s5,s5,-1820 # d40 <malloc+0x1fa>
 464:	a03d                	j	492 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 466:	07a1                	addi	a5,a5,8
 468:	00978963          	beq	a5,s1,47a <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 46c:	6398                	ld	a4,0(a5)
 46e:	df65                	beqz	a4,466 <_main+0x86>
 470:	5f38                	lw	a4,120(a4)
 472:	ff370ae3          	beq	a4,s3,466 <_main+0x86>
                running_threads++;
 476:	2905                	addiw	s2,s2,1
 478:	b7fd                	j	466 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 47a:	85ca                	mv	a1,s2
 47c:	8556                	mv	a0,s5
 47e:	00000097          	auipc	ra,0x0
 482:	610080e7          	jalr	1552(ra) # a8e <printf>
        if (running_threads > 0) {
 486:	01205963          	blez	s2,498 <_main+0xb8>
            tsched(); // Schedule another thread to run
 48a:	00000097          	auipc	ra,0x0
 48e:	ce8080e7          	jalr	-792(ra) # 172 <tsched>
    current_thread = main_thread;
 492:	87d2                	mv	a5,s4
        running_threads = 0;
 494:	895a                	mv	s2,s6
 496:	bfd9                	j	46c <_main+0x8c>
        }
    }

    exit(res);
 498:	855e                	mv	a0,s7
 49a:	00000097          	auipc	ra,0x0
 49e:	274080e7          	jalr	628(ra) # 70e <exit>

00000000000004a2 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4a8:	87aa                	mv	a5,a0
 4aa:	0585                	addi	a1,a1,1
 4ac:	0785                	addi	a5,a5,1
 4ae:	fff5c703          	lbu	a4,-1(a1)
 4b2:	fee78fa3          	sb	a4,-1(a5)
 4b6:	fb75                	bnez	a4,4aa <strcpy+0x8>
        ;
    return os;
}
 4b8:	6422                	ld	s0,8(sp)
 4ba:	0141                	addi	sp,sp,16
 4bc:	8082                	ret

00000000000004be <strcmp>:

int strcmp(const char *p, const char *q)
{
 4be:	1141                	addi	sp,sp,-16
 4c0:	e422                	sd	s0,8(sp)
 4c2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4c4:	00054783          	lbu	a5,0(a0)
 4c8:	cb91                	beqz	a5,4dc <strcmp+0x1e>
 4ca:	0005c703          	lbu	a4,0(a1)
 4ce:	00f71763          	bne	a4,a5,4dc <strcmp+0x1e>
        p++, q++;
 4d2:	0505                	addi	a0,a0,1
 4d4:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4d6:	00054783          	lbu	a5,0(a0)
 4da:	fbe5                	bnez	a5,4ca <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4dc:	0005c503          	lbu	a0,0(a1)
}
 4e0:	40a7853b          	subw	a0,a5,a0
 4e4:	6422                	ld	s0,8(sp)
 4e6:	0141                	addi	sp,sp,16
 4e8:	8082                	ret

00000000000004ea <strlen>:

uint strlen(const char *s)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4f0:	00054783          	lbu	a5,0(a0)
 4f4:	cf91                	beqz	a5,510 <strlen+0x26>
 4f6:	0505                	addi	a0,a0,1
 4f8:	87aa                	mv	a5,a0
 4fa:	86be                	mv	a3,a5
 4fc:	0785                	addi	a5,a5,1
 4fe:	fff7c703          	lbu	a4,-1(a5)
 502:	ff65                	bnez	a4,4fa <strlen+0x10>
 504:	40a6853b          	subw	a0,a3,a0
 508:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
    for (n = 0; s[n]; n++)
 510:	4501                	li	a0,0
 512:	bfe5                	j	50a <strlen+0x20>

0000000000000514 <memset>:

void *
memset(void *dst, int c, uint n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 51a:	ca19                	beqz	a2,530 <memset+0x1c>
 51c:	87aa                	mv	a5,a0
 51e:	1602                	slli	a2,a2,0x20
 520:	9201                	srli	a2,a2,0x20
 522:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 526:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 52a:	0785                	addi	a5,a5,1
 52c:	fee79de3          	bne	a5,a4,526 <memset+0x12>
    }
    return dst;
}
 530:	6422                	ld	s0,8(sp)
 532:	0141                	addi	sp,sp,16
 534:	8082                	ret

0000000000000536 <strchr>:

char *
strchr(const char *s, char c)
{
 536:	1141                	addi	sp,sp,-16
 538:	e422                	sd	s0,8(sp)
 53a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 53c:	00054783          	lbu	a5,0(a0)
 540:	cb99                	beqz	a5,556 <strchr+0x20>
        if (*s == c)
 542:	00f58763          	beq	a1,a5,550 <strchr+0x1a>
    for (; *s; s++)
 546:	0505                	addi	a0,a0,1
 548:	00054783          	lbu	a5,0(a0)
 54c:	fbfd                	bnez	a5,542 <strchr+0xc>
            return (char *)s;
    return 0;
 54e:	4501                	li	a0,0
}
 550:	6422                	ld	s0,8(sp)
 552:	0141                	addi	sp,sp,16
 554:	8082                	ret
    return 0;
 556:	4501                	li	a0,0
 558:	bfe5                	j	550 <strchr+0x1a>

000000000000055a <gets>:

char *
gets(char *buf, int max)
{
 55a:	711d                	addi	sp,sp,-96
 55c:	ec86                	sd	ra,88(sp)
 55e:	e8a2                	sd	s0,80(sp)
 560:	e4a6                	sd	s1,72(sp)
 562:	e0ca                	sd	s2,64(sp)
 564:	fc4e                	sd	s3,56(sp)
 566:	f852                	sd	s4,48(sp)
 568:	f456                	sd	s5,40(sp)
 56a:	f05a                	sd	s6,32(sp)
 56c:	ec5e                	sd	s7,24(sp)
 56e:	1080                	addi	s0,sp,96
 570:	8baa                	mv	s7,a0
 572:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 574:	892a                	mv	s2,a0
 576:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 578:	4aa9                	li	s5,10
 57a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 57c:	89a6                	mv	s3,s1
 57e:	2485                	addiw	s1,s1,1
 580:	0344d863          	bge	s1,s4,5b0 <gets+0x56>
        cc = read(0, &c, 1);
 584:	4605                	li	a2,1
 586:	faf40593          	addi	a1,s0,-81
 58a:	4501                	li	a0,0
 58c:	00000097          	auipc	ra,0x0
 590:	19a080e7          	jalr	410(ra) # 726 <read>
        if (cc < 1)
 594:	00a05e63          	blez	a0,5b0 <gets+0x56>
        buf[i++] = c;
 598:	faf44783          	lbu	a5,-81(s0)
 59c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5a0:	01578763          	beq	a5,s5,5ae <gets+0x54>
 5a4:	0905                	addi	s2,s2,1
 5a6:	fd679be3          	bne	a5,s6,57c <gets+0x22>
    for (i = 0; i + 1 < max;)
 5aa:	89a6                	mv	s3,s1
 5ac:	a011                	j	5b0 <gets+0x56>
 5ae:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5b0:	99de                	add	s3,s3,s7
 5b2:	00098023          	sb	zero,0(s3)
    return buf;
}
 5b6:	855e                	mv	a0,s7
 5b8:	60e6                	ld	ra,88(sp)
 5ba:	6446                	ld	s0,80(sp)
 5bc:	64a6                	ld	s1,72(sp)
 5be:	6906                	ld	s2,64(sp)
 5c0:	79e2                	ld	s3,56(sp)
 5c2:	7a42                	ld	s4,48(sp)
 5c4:	7aa2                	ld	s5,40(sp)
 5c6:	7b02                	ld	s6,32(sp)
 5c8:	6be2                	ld	s7,24(sp)
 5ca:	6125                	addi	sp,sp,96
 5cc:	8082                	ret

00000000000005ce <stat>:

int stat(const char *n, struct stat *st)
{
 5ce:	1101                	addi	sp,sp,-32
 5d0:	ec06                	sd	ra,24(sp)
 5d2:	e822                	sd	s0,16(sp)
 5d4:	e426                	sd	s1,8(sp)
 5d6:	e04a                	sd	s2,0(sp)
 5d8:	1000                	addi	s0,sp,32
 5da:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5dc:	4581                	li	a1,0
 5de:	00000097          	auipc	ra,0x0
 5e2:	170080e7          	jalr	368(ra) # 74e <open>
    if (fd < 0)
 5e6:	02054563          	bltz	a0,610 <stat+0x42>
 5ea:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5ec:	85ca                	mv	a1,s2
 5ee:	00000097          	auipc	ra,0x0
 5f2:	178080e7          	jalr	376(ra) # 766 <fstat>
 5f6:	892a                	mv	s2,a0
    close(fd);
 5f8:	8526                	mv	a0,s1
 5fa:	00000097          	auipc	ra,0x0
 5fe:	13c080e7          	jalr	316(ra) # 736 <close>
    return r;
}
 602:	854a                	mv	a0,s2
 604:	60e2                	ld	ra,24(sp)
 606:	6442                	ld	s0,16(sp)
 608:	64a2                	ld	s1,8(sp)
 60a:	6902                	ld	s2,0(sp)
 60c:	6105                	addi	sp,sp,32
 60e:	8082                	ret
        return -1;
 610:	597d                	li	s2,-1
 612:	bfc5                	j	602 <stat+0x34>

0000000000000614 <atoi>:

int atoi(const char *s)
{
 614:	1141                	addi	sp,sp,-16
 616:	e422                	sd	s0,8(sp)
 618:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 61a:	00054683          	lbu	a3,0(a0)
 61e:	fd06879b          	addiw	a5,a3,-48
 622:	0ff7f793          	zext.b	a5,a5
 626:	4625                	li	a2,9
 628:	02f66863          	bltu	a2,a5,658 <atoi+0x44>
 62c:	872a                	mv	a4,a0
    n = 0;
 62e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 630:	0705                	addi	a4,a4,1
 632:	0025179b          	slliw	a5,a0,0x2
 636:	9fa9                	addw	a5,a5,a0
 638:	0017979b          	slliw	a5,a5,0x1
 63c:	9fb5                	addw	a5,a5,a3
 63e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 642:	00074683          	lbu	a3,0(a4)
 646:	fd06879b          	addiw	a5,a3,-48
 64a:	0ff7f793          	zext.b	a5,a5
 64e:	fef671e3          	bgeu	a2,a5,630 <atoi+0x1c>
    return n;
}
 652:	6422                	ld	s0,8(sp)
 654:	0141                	addi	sp,sp,16
 656:	8082                	ret
    n = 0;
 658:	4501                	li	a0,0
 65a:	bfe5                	j	652 <atoi+0x3e>

000000000000065c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 65c:	1141                	addi	sp,sp,-16
 65e:	e422                	sd	s0,8(sp)
 660:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 662:	02b57463          	bgeu	a0,a1,68a <memmove+0x2e>
    {
        while (n-- > 0)
 666:	00c05f63          	blez	a2,684 <memmove+0x28>
 66a:	1602                	slli	a2,a2,0x20
 66c:	9201                	srli	a2,a2,0x20
 66e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 672:	872a                	mv	a4,a0
            *dst++ = *src++;
 674:	0585                	addi	a1,a1,1
 676:	0705                	addi	a4,a4,1
 678:	fff5c683          	lbu	a3,-1(a1)
 67c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 680:	fee79ae3          	bne	a5,a4,674 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 684:	6422                	ld	s0,8(sp)
 686:	0141                	addi	sp,sp,16
 688:	8082                	ret
        dst += n;
 68a:	00c50733          	add	a4,a0,a2
        src += n;
 68e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 690:	fec05ae3          	blez	a2,684 <memmove+0x28>
 694:	fff6079b          	addiw	a5,a2,-1
 698:	1782                	slli	a5,a5,0x20
 69a:	9381                	srli	a5,a5,0x20
 69c:	fff7c793          	not	a5,a5
 6a0:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6a2:	15fd                	addi	a1,a1,-1
 6a4:	177d                	addi	a4,a4,-1
 6a6:	0005c683          	lbu	a3,0(a1)
 6aa:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6ae:	fee79ae3          	bne	a5,a4,6a2 <memmove+0x46>
 6b2:	bfc9                	j	684 <memmove+0x28>

00000000000006b4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6b4:	1141                	addi	sp,sp,-16
 6b6:	e422                	sd	s0,8(sp)
 6b8:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6ba:	ca05                	beqz	a2,6ea <memcmp+0x36>
 6bc:	fff6069b          	addiw	a3,a2,-1
 6c0:	1682                	slli	a3,a3,0x20
 6c2:	9281                	srli	a3,a3,0x20
 6c4:	0685                	addi	a3,a3,1
 6c6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6c8:	00054783          	lbu	a5,0(a0)
 6cc:	0005c703          	lbu	a4,0(a1)
 6d0:	00e79863          	bne	a5,a4,6e0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6d4:	0505                	addi	a0,a0,1
        p2++;
 6d6:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6d8:	fed518e3          	bne	a0,a3,6c8 <memcmp+0x14>
    }
    return 0;
 6dc:	4501                	li	a0,0
 6de:	a019                	j	6e4 <memcmp+0x30>
            return *p1 - *p2;
 6e0:	40e7853b          	subw	a0,a5,a4
}
 6e4:	6422                	ld	s0,8(sp)
 6e6:	0141                	addi	sp,sp,16
 6e8:	8082                	ret
    return 0;
 6ea:	4501                	li	a0,0
 6ec:	bfe5                	j	6e4 <memcmp+0x30>

00000000000006ee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ee:	1141                	addi	sp,sp,-16
 6f0:	e406                	sd	ra,8(sp)
 6f2:	e022                	sd	s0,0(sp)
 6f4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6f6:	00000097          	auipc	ra,0x0
 6fa:	f66080e7          	jalr	-154(ra) # 65c <memmove>
}
 6fe:	60a2                	ld	ra,8(sp)
 700:	6402                	ld	s0,0(sp)
 702:	0141                	addi	sp,sp,16
 704:	8082                	ret

0000000000000706 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 706:	4885                	li	a7,1
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <exit>:
.global exit
exit:
 li a7, SYS_exit
 70e:	4889                	li	a7,2
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <wait>:
.global wait
wait:
 li a7, SYS_wait
 716:	488d                	li	a7,3
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 71e:	4891                	li	a7,4
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <read>:
.global read
read:
 li a7, SYS_read
 726:	4895                	li	a7,5
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <write>:
.global write
write:
 li a7, SYS_write
 72e:	48c1                	li	a7,16
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <close>:
.global close
close:
 li a7, SYS_close
 736:	48d5                	li	a7,21
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <kill>:
.global kill
kill:
 li a7, SYS_kill
 73e:	4899                	li	a7,6
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <exec>:
.global exec
exec:
 li a7, SYS_exec
 746:	489d                	li	a7,7
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <open>:
.global open
open:
 li a7, SYS_open
 74e:	48bd                	li	a7,15
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 756:	48c5                	li	a7,17
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 75e:	48c9                	li	a7,18
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 766:	48a1                	li	a7,8
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <link>:
.global link
link:
 li a7, SYS_link
 76e:	48cd                	li	a7,19
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 776:	48d1                	li	a7,20
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 77e:	48a5                	li	a7,9
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <dup>:
.global dup
dup:
 li a7, SYS_dup
 786:	48a9                	li	a7,10
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 78e:	48ad                	li	a7,11
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 796:	48b1                	li	a7,12
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 79e:	48b5                	li	a7,13
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7a6:	48b9                	li	a7,14
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <ps>:
.global ps
ps:
 li a7, SYS_ps
 7ae:	48d9                	li	a7,22
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7b6:	48dd                	li	a7,23
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7be:	48e1                	li	a7,24
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7c6:	1101                	addi	sp,sp,-32
 7c8:	ec06                	sd	ra,24(sp)
 7ca:	e822                	sd	s0,16(sp)
 7cc:	1000                	addi	s0,sp,32
 7ce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7d2:	4605                	li	a2,1
 7d4:	fef40593          	addi	a1,s0,-17
 7d8:	00000097          	auipc	ra,0x0
 7dc:	f56080e7          	jalr	-170(ra) # 72e <write>
}
 7e0:	60e2                	ld	ra,24(sp)
 7e2:	6442                	ld	s0,16(sp)
 7e4:	6105                	addi	sp,sp,32
 7e6:	8082                	ret

00000000000007e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f426                	sd	s1,40(sp)
 7f0:	f04a                	sd	s2,32(sp)
 7f2:	ec4e                	sd	s3,24(sp)
 7f4:	0080                	addi	s0,sp,64
 7f6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7f8:	c299                	beqz	a3,7fe <printint+0x16>
 7fa:	0805c963          	bltz	a1,88c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7fe:	2581                	sext.w	a1,a1
  neg = 0;
 800:	4881                	li	a7,0
 802:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 806:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 808:	2601                	sext.w	a2,a2
 80a:	00000517          	auipc	a0,0x0
 80e:	5b650513          	addi	a0,a0,1462 # dc0 <digits>
 812:	883a                	mv	a6,a4
 814:	2705                	addiw	a4,a4,1
 816:	02c5f7bb          	remuw	a5,a1,a2
 81a:	1782                	slli	a5,a5,0x20
 81c:	9381                	srli	a5,a5,0x20
 81e:	97aa                	add	a5,a5,a0
 820:	0007c783          	lbu	a5,0(a5)
 824:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 828:	0005879b          	sext.w	a5,a1
 82c:	02c5d5bb          	divuw	a1,a1,a2
 830:	0685                	addi	a3,a3,1
 832:	fec7f0e3          	bgeu	a5,a2,812 <printint+0x2a>
  if(neg)
 836:	00088c63          	beqz	a7,84e <printint+0x66>
    buf[i++] = '-';
 83a:	fd070793          	addi	a5,a4,-48
 83e:	00878733          	add	a4,a5,s0
 842:	02d00793          	li	a5,45
 846:	fef70823          	sb	a5,-16(a4)
 84a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 84e:	02e05863          	blez	a4,87e <printint+0x96>
 852:	fc040793          	addi	a5,s0,-64
 856:	00e78933          	add	s2,a5,a4
 85a:	fff78993          	addi	s3,a5,-1
 85e:	99ba                	add	s3,s3,a4
 860:	377d                	addiw	a4,a4,-1
 862:	1702                	slli	a4,a4,0x20
 864:	9301                	srli	a4,a4,0x20
 866:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 86a:	fff94583          	lbu	a1,-1(s2)
 86e:	8526                	mv	a0,s1
 870:	00000097          	auipc	ra,0x0
 874:	f56080e7          	jalr	-170(ra) # 7c6 <putc>
  while(--i >= 0)
 878:	197d                	addi	s2,s2,-1
 87a:	ff3918e3          	bne	s2,s3,86a <printint+0x82>
}
 87e:	70e2                	ld	ra,56(sp)
 880:	7442                	ld	s0,48(sp)
 882:	74a2                	ld	s1,40(sp)
 884:	7902                	ld	s2,32(sp)
 886:	69e2                	ld	s3,24(sp)
 888:	6121                	addi	sp,sp,64
 88a:	8082                	ret
    x = -xx;
 88c:	40b005bb          	negw	a1,a1
    neg = 1;
 890:	4885                	li	a7,1
    x = -xx;
 892:	bf85                	j	802 <printint+0x1a>

0000000000000894 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 894:	715d                	addi	sp,sp,-80
 896:	e486                	sd	ra,72(sp)
 898:	e0a2                	sd	s0,64(sp)
 89a:	fc26                	sd	s1,56(sp)
 89c:	f84a                	sd	s2,48(sp)
 89e:	f44e                	sd	s3,40(sp)
 8a0:	f052                	sd	s4,32(sp)
 8a2:	ec56                	sd	s5,24(sp)
 8a4:	e85a                	sd	s6,16(sp)
 8a6:	e45e                	sd	s7,8(sp)
 8a8:	e062                	sd	s8,0(sp)
 8aa:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8ac:	0005c903          	lbu	s2,0(a1)
 8b0:	18090c63          	beqz	s2,a48 <vprintf+0x1b4>
 8b4:	8aaa                	mv	s5,a0
 8b6:	8bb2                	mv	s7,a2
 8b8:	00158493          	addi	s1,a1,1
  state = 0;
 8bc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8be:	02500a13          	li	s4,37
 8c2:	4b55                	li	s6,21
 8c4:	a839                	j	8e2 <vprintf+0x4e>
        putc(fd, c);
 8c6:	85ca                	mv	a1,s2
 8c8:	8556                	mv	a0,s5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	efc080e7          	jalr	-260(ra) # 7c6 <putc>
 8d2:	a019                	j	8d8 <vprintf+0x44>
    } else if(state == '%'){
 8d4:	01498d63          	beq	s3,s4,8ee <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8d8:	0485                	addi	s1,s1,1
 8da:	fff4c903          	lbu	s2,-1(s1)
 8de:	16090563          	beqz	s2,a48 <vprintf+0x1b4>
    if(state == 0){
 8e2:	fe0999e3          	bnez	s3,8d4 <vprintf+0x40>
      if(c == '%'){
 8e6:	ff4910e3          	bne	s2,s4,8c6 <vprintf+0x32>
        state = '%';
 8ea:	89d2                	mv	s3,s4
 8ec:	b7f5                	j	8d8 <vprintf+0x44>
      if(c == 'd'){
 8ee:	13490263          	beq	s2,s4,a12 <vprintf+0x17e>
 8f2:	f9d9079b          	addiw	a5,s2,-99
 8f6:	0ff7f793          	zext.b	a5,a5
 8fa:	12fb6563          	bltu	s6,a5,a24 <vprintf+0x190>
 8fe:	f9d9079b          	addiw	a5,s2,-99
 902:	0ff7f713          	zext.b	a4,a5
 906:	10eb6f63          	bltu	s6,a4,a24 <vprintf+0x190>
 90a:	00271793          	slli	a5,a4,0x2
 90e:	00000717          	auipc	a4,0x0
 912:	45a70713          	addi	a4,a4,1114 # d68 <malloc+0x222>
 916:	97ba                	add	a5,a5,a4
 918:	439c                	lw	a5,0(a5)
 91a:	97ba                	add	a5,a5,a4
 91c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 91e:	008b8913          	addi	s2,s7,8
 922:	4685                	li	a3,1
 924:	4629                	li	a2,10
 926:	000ba583          	lw	a1,0(s7)
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	ebc080e7          	jalr	-324(ra) # 7e8 <printint>
 934:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 936:	4981                	li	s3,0
 938:	b745                	j	8d8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 93a:	008b8913          	addi	s2,s7,8
 93e:	4681                	li	a3,0
 940:	4629                	li	a2,10
 942:	000ba583          	lw	a1,0(s7)
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	ea0080e7          	jalr	-352(ra) # 7e8 <printint>
 950:	8bca                	mv	s7,s2
      state = 0;
 952:	4981                	li	s3,0
 954:	b751                	j	8d8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 956:	008b8913          	addi	s2,s7,8
 95a:	4681                	li	a3,0
 95c:	4641                	li	a2,16
 95e:	000ba583          	lw	a1,0(s7)
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	e84080e7          	jalr	-380(ra) # 7e8 <printint>
 96c:	8bca                	mv	s7,s2
      state = 0;
 96e:	4981                	li	s3,0
 970:	b7a5                	j	8d8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 972:	008b8c13          	addi	s8,s7,8
 976:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 97a:	03000593          	li	a1,48
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	e46080e7          	jalr	-442(ra) # 7c6 <putc>
  putc(fd, 'x');
 988:	07800593          	li	a1,120
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	e38080e7          	jalr	-456(ra) # 7c6 <putc>
 996:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 998:	00000b97          	auipc	s7,0x0
 99c:	428b8b93          	addi	s7,s7,1064 # dc0 <digits>
 9a0:	03c9d793          	srli	a5,s3,0x3c
 9a4:	97de                	add	a5,a5,s7
 9a6:	0007c583          	lbu	a1,0(a5)
 9aa:	8556                	mv	a0,s5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	e1a080e7          	jalr	-486(ra) # 7c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9b4:	0992                	slli	s3,s3,0x4
 9b6:	397d                	addiw	s2,s2,-1
 9b8:	fe0914e3          	bnez	s2,9a0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9bc:	8be2                	mv	s7,s8
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	bf21                	j	8d8 <vprintf+0x44>
        s = va_arg(ap, char*);
 9c2:	008b8993          	addi	s3,s7,8
 9c6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9ca:	02090163          	beqz	s2,9ec <vprintf+0x158>
        while(*s != 0){
 9ce:	00094583          	lbu	a1,0(s2)
 9d2:	c9a5                	beqz	a1,a42 <vprintf+0x1ae>
          putc(fd, *s);
 9d4:	8556                	mv	a0,s5
 9d6:	00000097          	auipc	ra,0x0
 9da:	df0080e7          	jalr	-528(ra) # 7c6 <putc>
          s++;
 9de:	0905                	addi	s2,s2,1
        while(*s != 0){
 9e0:	00094583          	lbu	a1,0(s2)
 9e4:	f9e5                	bnez	a1,9d4 <vprintf+0x140>
        s = va_arg(ap, char*);
 9e6:	8bce                	mv	s7,s3
      state = 0;
 9e8:	4981                	li	s3,0
 9ea:	b5fd                	j	8d8 <vprintf+0x44>
          s = "(null)";
 9ec:	00000917          	auipc	s2,0x0
 9f0:	37490913          	addi	s2,s2,884 # d60 <malloc+0x21a>
        while(*s != 0){
 9f4:	02800593          	li	a1,40
 9f8:	bff1                	j	9d4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9fa:	008b8913          	addi	s2,s7,8
 9fe:	000bc583          	lbu	a1,0(s7)
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	dc2080e7          	jalr	-574(ra) # 7c6 <putc>
 a0c:	8bca                	mv	s7,s2
      state = 0;
 a0e:	4981                	li	s3,0
 a10:	b5e1                	j	8d8 <vprintf+0x44>
        putc(fd, c);
 a12:	02500593          	li	a1,37
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	dae080e7          	jalr	-594(ra) # 7c6 <putc>
      state = 0;
 a20:	4981                	li	s3,0
 a22:	bd5d                	j	8d8 <vprintf+0x44>
        putc(fd, '%');
 a24:	02500593          	li	a1,37
 a28:	8556                	mv	a0,s5
 a2a:	00000097          	auipc	ra,0x0
 a2e:	d9c080e7          	jalr	-612(ra) # 7c6 <putc>
        putc(fd, c);
 a32:	85ca                	mv	a1,s2
 a34:	8556                	mv	a0,s5
 a36:	00000097          	auipc	ra,0x0
 a3a:	d90080e7          	jalr	-624(ra) # 7c6 <putc>
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	bd61                	j	8d8 <vprintf+0x44>
        s = va_arg(ap, char*);
 a42:	8bce                	mv	s7,s3
      state = 0;
 a44:	4981                	li	s3,0
 a46:	bd49                	j	8d8 <vprintf+0x44>
    }
  }
}
 a48:	60a6                	ld	ra,72(sp)
 a4a:	6406                	ld	s0,64(sp)
 a4c:	74e2                	ld	s1,56(sp)
 a4e:	7942                	ld	s2,48(sp)
 a50:	79a2                	ld	s3,40(sp)
 a52:	7a02                	ld	s4,32(sp)
 a54:	6ae2                	ld	s5,24(sp)
 a56:	6b42                	ld	s6,16(sp)
 a58:	6ba2                	ld	s7,8(sp)
 a5a:	6c02                	ld	s8,0(sp)
 a5c:	6161                	addi	sp,sp,80
 a5e:	8082                	ret

0000000000000a60 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a60:	715d                	addi	sp,sp,-80
 a62:	ec06                	sd	ra,24(sp)
 a64:	e822                	sd	s0,16(sp)
 a66:	1000                	addi	s0,sp,32
 a68:	e010                	sd	a2,0(s0)
 a6a:	e414                	sd	a3,8(s0)
 a6c:	e818                	sd	a4,16(s0)
 a6e:	ec1c                	sd	a5,24(s0)
 a70:	03043023          	sd	a6,32(s0)
 a74:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a78:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a7c:	8622                	mv	a2,s0
 a7e:	00000097          	auipc	ra,0x0
 a82:	e16080e7          	jalr	-490(ra) # 894 <vprintf>
}
 a86:	60e2                	ld	ra,24(sp)
 a88:	6442                	ld	s0,16(sp)
 a8a:	6161                	addi	sp,sp,80
 a8c:	8082                	ret

0000000000000a8e <printf>:

void
printf(const char *fmt, ...)
{
 a8e:	711d                	addi	sp,sp,-96
 a90:	ec06                	sd	ra,24(sp)
 a92:	e822                	sd	s0,16(sp)
 a94:	1000                	addi	s0,sp,32
 a96:	e40c                	sd	a1,8(s0)
 a98:	e810                	sd	a2,16(s0)
 a9a:	ec14                	sd	a3,24(s0)
 a9c:	f018                	sd	a4,32(s0)
 a9e:	f41c                	sd	a5,40(s0)
 aa0:	03043823          	sd	a6,48(s0)
 aa4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aa8:	00840613          	addi	a2,s0,8
 aac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ab0:	85aa                	mv	a1,a0
 ab2:	4505                	li	a0,1
 ab4:	00000097          	auipc	ra,0x0
 ab8:	de0080e7          	jalr	-544(ra) # 894 <vprintf>
}
 abc:	60e2                	ld	ra,24(sp)
 abe:	6442                	ld	s0,16(sp)
 ac0:	6125                	addi	sp,sp,96
 ac2:	8082                	ret

0000000000000ac4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ac4:	1141                	addi	sp,sp,-16
 ac6:	e422                	sd	s0,8(sp)
 ac8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aca:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ace:	00000797          	auipc	a5,0x0
 ad2:	54a7b783          	ld	a5,1354(a5) # 1018 <freep>
 ad6:	a02d                	j	b00 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ad8:	4618                	lw	a4,8(a2)
 ada:	9f2d                	addw	a4,a4,a1
 adc:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ae0:	6398                	ld	a4,0(a5)
 ae2:	6310                	ld	a2,0(a4)
 ae4:	a83d                	j	b22 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ae6:	ff852703          	lw	a4,-8(a0)
 aea:	9f31                	addw	a4,a4,a2
 aec:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 aee:	ff053683          	ld	a3,-16(a0)
 af2:	a091                	j	b36 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af4:	6398                	ld	a4,0(a5)
 af6:	00e7e463          	bltu	a5,a4,afe <free+0x3a>
 afa:	00e6ea63          	bltu	a3,a4,b0e <free+0x4a>
{
 afe:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b00:	fed7fae3          	bgeu	a5,a3,af4 <free+0x30>
 b04:	6398                	ld	a4,0(a5)
 b06:	00e6e463          	bltu	a3,a4,b0e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0a:	fee7eae3          	bltu	a5,a4,afe <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b0e:	ff852583          	lw	a1,-8(a0)
 b12:	6390                	ld	a2,0(a5)
 b14:	02059813          	slli	a6,a1,0x20
 b18:	01c85713          	srli	a4,a6,0x1c
 b1c:	9736                	add	a4,a4,a3
 b1e:	fae60de3          	beq	a2,a4,ad8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b22:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b26:	4790                	lw	a2,8(a5)
 b28:	02061593          	slli	a1,a2,0x20
 b2c:	01c5d713          	srli	a4,a1,0x1c
 b30:	973e                	add	a4,a4,a5
 b32:	fae68ae3          	beq	a3,a4,ae6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b36:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b38:	00000717          	auipc	a4,0x0
 b3c:	4ef73023          	sd	a5,1248(a4) # 1018 <freep>
}
 b40:	6422                	ld	s0,8(sp)
 b42:	0141                	addi	sp,sp,16
 b44:	8082                	ret

0000000000000b46 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b46:	7139                	addi	sp,sp,-64
 b48:	fc06                	sd	ra,56(sp)
 b4a:	f822                	sd	s0,48(sp)
 b4c:	f426                	sd	s1,40(sp)
 b4e:	f04a                	sd	s2,32(sp)
 b50:	ec4e                	sd	s3,24(sp)
 b52:	e852                	sd	s4,16(sp)
 b54:	e456                	sd	s5,8(sp)
 b56:	e05a                	sd	s6,0(sp)
 b58:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b5a:	02051493          	slli	s1,a0,0x20
 b5e:	9081                	srli	s1,s1,0x20
 b60:	04bd                	addi	s1,s1,15
 b62:	8091                	srli	s1,s1,0x4
 b64:	0014899b          	addiw	s3,s1,1
 b68:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b6a:	00000517          	auipc	a0,0x0
 b6e:	4ae53503          	ld	a0,1198(a0) # 1018 <freep>
 b72:	c515                	beqz	a0,b9e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b74:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b76:	4798                	lw	a4,8(a5)
 b78:	02977f63          	bgeu	a4,s1,bb6 <malloc+0x70>
    if (nu < 4096)
 b7c:	8a4e                	mv	s4,s3
 b7e:	0009871b          	sext.w	a4,s3
 b82:	6685                	lui	a3,0x1
 b84:	00d77363          	bgeu	a4,a3,b8a <malloc+0x44>
 b88:	6a05                	lui	s4,0x1
 b8a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b8e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b92:	00000917          	auipc	s2,0x0
 b96:	48690913          	addi	s2,s2,1158 # 1018 <freep>
    if (p == (char *)-1)
 b9a:	5afd                	li	s5,-1
 b9c:	a895                	j	c10 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b9e:	00000797          	auipc	a5,0x0
 ba2:	50278793          	addi	a5,a5,1282 # 10a0 <base>
 ba6:	00000717          	auipc	a4,0x0
 baa:	46f73923          	sd	a5,1138(a4) # 1018 <freep>
 bae:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bb0:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bb4:	b7e1                	j	b7c <malloc+0x36>
            if (p->s.size == nunits)
 bb6:	02e48c63          	beq	s1,a4,bee <malloc+0xa8>
                p->s.size -= nunits;
 bba:	4137073b          	subw	a4,a4,s3
 bbe:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bc0:	02071693          	slli	a3,a4,0x20
 bc4:	01c6d713          	srli	a4,a3,0x1c
 bc8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bca:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bce:	00000717          	auipc	a4,0x0
 bd2:	44a73523          	sd	a0,1098(a4) # 1018 <freep>
            return (void *)(p + 1);
 bd6:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bda:	70e2                	ld	ra,56(sp)
 bdc:	7442                	ld	s0,48(sp)
 bde:	74a2                	ld	s1,40(sp)
 be0:	7902                	ld	s2,32(sp)
 be2:	69e2                	ld	s3,24(sp)
 be4:	6a42                	ld	s4,16(sp)
 be6:	6aa2                	ld	s5,8(sp)
 be8:	6b02                	ld	s6,0(sp)
 bea:	6121                	addi	sp,sp,64
 bec:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bee:	6398                	ld	a4,0(a5)
 bf0:	e118                	sd	a4,0(a0)
 bf2:	bff1                	j	bce <malloc+0x88>
    hp->s.size = nu;
 bf4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bf8:	0541                	addi	a0,a0,16
 bfa:	00000097          	auipc	ra,0x0
 bfe:	eca080e7          	jalr	-310(ra) # ac4 <free>
    return freep;
 c02:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c06:	d971                	beqz	a0,bda <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c08:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c0a:	4798                	lw	a4,8(a5)
 c0c:	fa9775e3          	bgeu	a4,s1,bb6 <malloc+0x70>
        if (p == freep)
 c10:	00093703          	ld	a4,0(s2)
 c14:	853e                	mv	a0,a5
 c16:	fef719e3          	bne	a4,a5,c08 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c1a:	8552                	mv	a0,s4
 c1c:	00000097          	auipc	ra,0x0
 c20:	b7a080e7          	jalr	-1158(ra) # 796 <sbrk>
    if (p == (char *)-1)
 c24:	fd5518e3          	bne	a0,s5,bf4 <malloc+0xae>
                return 0;
 c28:	4501                	li	a0,0
 c2a:	bf45                	j	bda <malloc+0x94>
