
user/_schedset:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc != 2)
   8:	4789                	li	a5,2
   a:	00f50f63          	beq	a0,a5,28 <main+0x28>
    {
        printf("Usage: schedset [SCHED ID]\n");
   e:	00001517          	auipc	a0,0x1
  12:	c1250513          	addi	a0,a0,-1006 # c20 <malloc+0xe8>
  16:	00001097          	auipc	ra,0x1
  1a:	a6a080e7          	jalr	-1430(ra) # a80 <printf>
        exit(1);
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	6e0080e7          	jalr	1760(ra) # 700 <exit>
    }
    int schedid = (*argv[1]) - '0';
  28:	659c                	ld	a5,8(a1)
  2a:	0007c503          	lbu	a0,0(a5)
    schedset(schedid);
  2e:	fd05051b          	addiw	a0,a0,-48
  32:	00000097          	auipc	ra,0x0
  36:	77e080e7          	jalr	1918(ra) # 7b0 <schedset>
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	6c4080e7          	jalr	1732(ra) # 700 <exit>

0000000000000044 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  44:	1141                	addi	sp,sp,-16
  46:	e422                	sd	s0,8(sp)
  48:	0800                	addi	s0,sp,16
    lk->name = name;
  4a:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  4c:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  50:	57fd                	li	a5,-1
  52:	00f50823          	sb	a5,16(a0)
}
  56:	6422                	ld	s0,8(sp)
  58:	0141                	addi	sp,sp,16
  5a:	8082                	ret

000000000000005c <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  5c:	00054783          	lbu	a5,0(a0)
  60:	e399                	bnez	a5,66 <holding+0xa>
  62:	4501                	li	a0,0
}
  64:	8082                	ret
{
  66:	1101                	addi	sp,sp,-32
  68:	ec06                	sd	ra,24(sp)
  6a:	e822                	sd	s0,16(sp)
  6c:	e426                	sd	s1,8(sp)
  6e:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  70:	01054483          	lbu	s1,16(a0)
  74:	00000097          	auipc	ra,0x0
  78:	2dc080e7          	jalr	732(ra) # 350 <twhoami>
  7c:	2501                	sext.w	a0,a0
  7e:	40a48533          	sub	a0,s1,a0
  82:	00153513          	seqz	a0,a0
}
  86:	60e2                	ld	ra,24(sp)
  88:	6442                	ld	s0,16(sp)
  8a:	64a2                	ld	s1,8(sp)
  8c:	6105                	addi	sp,sp,32
  8e:	8082                	ret

0000000000000090 <acquire>:

void acquire(struct lock *lk)
{
  90:	7179                	addi	sp,sp,-48
  92:	f406                	sd	ra,40(sp)
  94:	f022                	sd	s0,32(sp)
  96:	ec26                	sd	s1,24(sp)
  98:	e84a                	sd	s2,16(sp)
  9a:	e44e                	sd	s3,8(sp)
  9c:	e052                	sd	s4,0(sp)
  9e:	1800                	addi	s0,sp,48
  a0:	8a2a                	mv	s4,a0
    if (holding(lk))
  a2:	00000097          	auipc	ra,0x0
  a6:	fba080e7          	jalr	-70(ra) # 5c <holding>
  aa:	e919                	bnez	a0,c0 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  ac:	ffca7493          	andi	s1,s4,-4
  b0:	003a7913          	andi	s2,s4,3
  b4:	0039191b          	slliw	s2,s2,0x3
  b8:	4985                	li	s3,1
  ba:	012999bb          	sllw	s3,s3,s2
  be:	a015                	j	e2 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  c0:	00001517          	auipc	a0,0x1
  c4:	b8050513          	addi	a0,a0,-1152 # c40 <malloc+0x108>
  c8:	00001097          	auipc	ra,0x1
  cc:	9b8080e7          	jalr	-1608(ra) # a80 <printf>
        exit(-1);
  d0:	557d                	li	a0,-1
  d2:	00000097          	auipc	ra,0x0
  d6:	62e080e7          	jalr	1582(ra) # 700 <exit>
    {
        // give up the cpu for other threads
        tyield();
  da:	00000097          	auipc	ra,0x0
  de:	252080e7          	jalr	594(ra) # 32c <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  e2:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  e6:	0127d7bb          	srlw	a5,a5,s2
  ea:	0ff7f793          	zext.b	a5,a5
  ee:	f7f5                	bnez	a5,da <acquire+0x4a>
    }

    __sync_synchronize();
  f0:	0ff0000f          	fence

    lk->tid = twhoami();
  f4:	00000097          	auipc	ra,0x0
  f8:	25c080e7          	jalr	604(ra) # 350 <twhoami>
  fc:	00aa0823          	sb	a0,16(s4)
}
 100:	70a2                	ld	ra,40(sp)
 102:	7402                	ld	s0,32(sp)
 104:	64e2                	ld	s1,24(sp)
 106:	6942                	ld	s2,16(sp)
 108:	69a2                	ld	s3,8(sp)
 10a:	6a02                	ld	s4,0(sp)
 10c:	6145                	addi	sp,sp,48
 10e:	8082                	ret

0000000000000110 <release>:

void release(struct lock *lk)
{
 110:	1101                	addi	sp,sp,-32
 112:	ec06                	sd	ra,24(sp)
 114:	e822                	sd	s0,16(sp)
 116:	e426                	sd	s1,8(sp)
 118:	1000                	addi	s0,sp,32
 11a:	84aa                	mv	s1,a0
    if (!holding(lk))
 11c:	00000097          	auipc	ra,0x0
 120:	f40080e7          	jalr	-192(ra) # 5c <holding>
 124:	c11d                	beqz	a0,14a <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 126:	57fd                	li	a5,-1
 128:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 12c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 130:	0ff0000f          	fence
 134:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 138:	00000097          	auipc	ra,0x0
 13c:	1f4080e7          	jalr	500(ra) # 32c <tyield>
}
 140:	60e2                	ld	ra,24(sp)
 142:	6442                	ld	s0,16(sp)
 144:	64a2                	ld	s1,8(sp)
 146:	6105                	addi	sp,sp,32
 148:	8082                	ret
        printf("releasing lock we are not holding");
 14a:	00001517          	auipc	a0,0x1
 14e:	b1e50513          	addi	a0,a0,-1250 # c68 <malloc+0x130>
 152:	00001097          	auipc	ra,0x1
 156:	92e080e7          	jalr	-1746(ra) # a80 <printf>
        exit(-1);
 15a:	557d                	li	a0,-1
 15c:	00000097          	auipc	ra,0x0
 160:	5a4080e7          	jalr	1444(ra) # 700 <exit>

0000000000000164 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 164:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 166:	00001617          	auipc	a2,0x1
 16a:	eba60613          	addi	a2,a2,-326 # 1020 <threads>
 16e:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 170:	45c1                	li	a1,16
 172:	a021                	j	17a <tsched+0x16>
 174:	2685                	addiw	a3,a3,1
 176:	08b68c63          	beq	a3,a1,20e <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 17a:	41f6d71b          	sraiw	a4,a3,0x1f
 17e:	01c7571b          	srliw	a4,a4,0x1c
 182:	00d707bb          	addw	a5,a4,a3
 186:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 188:	9f99                	subw	a5,a5,a4
 18a:	078e                	slli	a5,a5,0x3
 18c:	97b2                	add	a5,a5,a2
 18e:	639c                	ld	a5,0(a5)
 190:	d3f5                	beqz	a5,174 <tsched+0x10>
 192:	5fb8                	lw	a4,120(a5)
 194:	fea710e3          	bne	a4,a0,174 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 198:	00001717          	auipc	a4,0x1
 19c:	e8873703          	ld	a4,-376(a4) # 1020 <threads>
 1a0:	5f30                	lw	a2,120(a4)
 1a2:	468d                	li	a3,3
 1a4:	06d60363          	beq	a2,a3,20a <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1a8:	c3a5                	beqz	a5,208 <tsched+0xa4>
{
 1aa:	1101                	addi	sp,sp,-32
 1ac:	ec06                	sd	ra,24(sp)
 1ae:	e822                	sd	s0,16(sp)
 1b0:	e426                	sd	s1,8(sp)
 1b2:	e04a                	sd	s2,0(sp)
 1b4:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1b6:	00001497          	auipc	s1,0x1
 1ba:	e5a48493          	addi	s1,s1,-422 # 1010 <current_thread>
 1be:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1c2:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1c4:	0007c603          	lbu	a2,0(a5)
 1c8:	00094583          	lbu	a1,0(s2)
 1cc:	00001517          	auipc	a0,0x1
 1d0:	ac450513          	addi	a0,a0,-1340 # c90 <malloc+0x158>
 1d4:	00001097          	auipc	ra,0x1
 1d8:	8ac080e7          	jalr	-1876(ra) # a80 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1dc:	608c                	ld	a1,0(s1)
 1de:	05a1                	addi	a1,a1,8
 1e0:	00890513          	addi	a0,s2,8
 1e4:	00000097          	auipc	ra,0x0
 1e8:	184080e7          	jalr	388(ra) # 368 <tswtch>
        printf("Thread switch complete\n");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	acc50513          	addi	a0,a0,-1332 # cb8 <malloc+0x180>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	88c080e7          	jalr	-1908(ra) # a80 <printf>
    }
}
 1fc:	60e2                	ld	ra,24(sp)
 1fe:	6442                	ld	s0,16(sp)
 200:	64a2                	ld	s1,8(sp)
 202:	6902                	ld	s2,0(sp)
 204:	6105                	addi	sp,sp,32
 206:	8082                	ret
 208:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 20a:	87ba                	mv	a5,a4
 20c:	bf79                	j	1aa <tsched+0x46>
 20e:	00001797          	auipc	a5,0x1
 212:	e127b783          	ld	a5,-494(a5) # 1020 <threads>
 216:	5fb4                	lw	a3,120(a5)
 218:	470d                	li	a4,3
 21a:	f8e688e3          	beq	a3,a4,1aa <tsched+0x46>
 21e:	8082                	ret

0000000000000220 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 220:	7179                	addi	sp,sp,-48
 222:	f406                	sd	ra,40(sp)
 224:	f022                	sd	s0,32(sp)
 226:	ec26                	sd	s1,24(sp)
 228:	e84a                	sd	s2,16(sp)
 22a:	e44e                	sd	s3,8(sp)
 22c:	1800                	addi	s0,sp,48
 22e:	84aa                	mv	s1,a0
 230:	89b2                	mv	s3,a2
 232:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 234:	09000513          	li	a0,144
 238:	00001097          	auipc	ra,0x1
 23c:	900080e7          	jalr	-1792(ra) # b38 <malloc>
 240:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 242:	478d                	li	a5,3
 244:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 246:	609c                	ld	a5,0(s1)
 248:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 24c:	609c                	ld	a5,0(s1)
 24e:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 252:	00001717          	auipc	a4,0x1
 256:	dae70713          	addi	a4,a4,-594 # 1000 <next_tid>
 25a:	431c                	lw	a5,0(a4)
 25c:	0017869b          	addiw	a3,a5,1
 260:	c314                	sw	a3,0(a4)
 262:	6098                	ld	a4,0(s1)
 264:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 268:	00001717          	auipc	a4,0x1
 26c:	db870713          	addi	a4,a4,-584 # 1020 <threads>
 270:	4781                	li	a5,0
 272:	4641                	li	a2,16
    if (threads[i] == NULL) {
 274:	6314                	ld	a3,0(a4)
 276:	ce81                	beqz	a3,28e <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 278:	2785                	addiw	a5,a5,1
 27a:	0721                	addi	a4,a4,8
 27c:	fec79ce3          	bne	a5,a2,274 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 280:	70a2                	ld	ra,40(sp)
 282:	7402                	ld	s0,32(sp)
 284:	64e2                	ld	s1,24(sp)
 286:	6942                	ld	s2,16(sp)
 288:	69a2                	ld	s3,8(sp)
 28a:	6145                	addi	sp,sp,48
 28c:	8082                	ret
        threads[i] = *thread;
 28e:	6094                	ld	a3,0(s1)
 290:	078e                	slli	a5,a5,0x3
 292:	00001717          	auipc	a4,0x1
 296:	d8e70713          	addi	a4,a4,-626 # 1020 <threads>
 29a:	97ba                	add	a5,a5,a4
 29c:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 29e:	0006c583          	lbu	a1,0(a3)
 2a2:	00001517          	auipc	a0,0x1
 2a6:	a2e50513          	addi	a0,a0,-1490 # cd0 <malloc+0x198>
 2aa:	00000097          	auipc	ra,0x0
 2ae:	7d6080e7          	jalr	2006(ra) # a80 <printf>
        break;
 2b2:	b7f9                	j	280 <tcreate+0x60>

00000000000002b4 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2b4:	7179                	addi	sp,sp,-48
 2b6:	f406                	sd	ra,40(sp)
 2b8:	f022                	sd	s0,32(sp)
 2ba:	ec26                	sd	s1,24(sp)
 2bc:	e84a                	sd	s2,16(sp)
 2be:	e44e                	sd	s3,8(sp)
 2c0:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2c2:	00001797          	auipc	a5,0x1
 2c6:	d5e78793          	addi	a5,a5,-674 # 1020 <threads>
 2ca:	00001697          	auipc	a3,0x1
 2ce:	dd668693          	addi	a3,a3,-554 # 10a0 <base>
 2d2:	a021                	j	2da <tjoin+0x26>
 2d4:	07a1                	addi	a5,a5,8
 2d6:	04d78763          	beq	a5,a3,324 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2da:	6384                	ld	s1,0(a5)
 2dc:	dce5                	beqz	s1,2d4 <tjoin+0x20>
 2de:	0004c703          	lbu	a4,0(s1)
 2e2:	fea719e3          	bne	a4,a0,2d4 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 2e6:	5cb8                	lw	a4,120(s1)
 2e8:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2ea:	00001997          	auipc	s3,0x1
 2ee:	a1698993          	addi	s3,s3,-1514 # d00 <malloc+0x1c8>
    while (target_thread->state != EXITED) {
 2f2:	4919                	li	s2,6
 2f4:	02f70a63          	beq	a4,a5,328 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2f8:	0004c583          	lbu	a1,0(s1)
 2fc:	854e                	mv	a0,s3
 2fe:	00000097          	auipc	ra,0x0
 302:	782080e7          	jalr	1922(ra) # a80 <printf>
        tsched();
 306:	00000097          	auipc	ra,0x0
 30a:	e5e080e7          	jalr	-418(ra) # 164 <tsched>
    while (target_thread->state != EXITED) {
 30e:	5cbc                	lw	a5,120(s1)
 310:	ff2794e3          	bne	a5,s2,2f8 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 314:	4501                	li	a0,0
}
 316:	70a2                	ld	ra,40(sp)
 318:	7402                	ld	s0,32(sp)
 31a:	64e2                	ld	s1,24(sp)
 31c:	6942                	ld	s2,16(sp)
 31e:	69a2                	ld	s3,8(sp)
 320:	6145                	addi	sp,sp,48
 322:	8082                	ret
        return -1;
 324:	557d                	li	a0,-1
 326:	bfc5                	j	316 <tjoin+0x62>
    return 0;
 328:	4501                	li	a0,0
 32a:	b7f5                	j	316 <tjoin+0x62>

000000000000032c <tyield>:


void tyield()
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 334:	00001797          	auipc	a5,0x1
 338:	cdc7b783          	ld	a5,-804(a5) # 1010 <current_thread>
 33c:	470d                	li	a4,3
 33e:	dfb8                	sw	a4,120(a5)
    tsched();
 340:	00000097          	auipc	ra,0x0
 344:	e24080e7          	jalr	-476(ra) # 164 <tsched>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <twhoami>:

uint8 twhoami()
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 356:	00001797          	auipc	a5,0x1
 35a:	cba7b783          	ld	a5,-838(a5) # 1010 <current_thread>
 35e:	0007c503          	lbu	a0,0(a5)
 362:	6422                	ld	s0,8(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret

0000000000000368 <tswtch>:
 368:	00153023          	sd	ra,0(a0)
 36c:	00253423          	sd	sp,8(a0)
 370:	e900                	sd	s0,16(a0)
 372:	ed04                	sd	s1,24(a0)
 374:	03253023          	sd	s2,32(a0)
 378:	03353423          	sd	s3,40(a0)
 37c:	03453823          	sd	s4,48(a0)
 380:	03553c23          	sd	s5,56(a0)
 384:	05653023          	sd	s6,64(a0)
 388:	05753423          	sd	s7,72(a0)
 38c:	05853823          	sd	s8,80(a0)
 390:	05953c23          	sd	s9,88(a0)
 394:	07a53023          	sd	s10,96(a0)
 398:	07b53423          	sd	s11,104(a0)
 39c:	0005b083          	ld	ra,0(a1)
 3a0:	0085b103          	ld	sp,8(a1)
 3a4:	6980                	ld	s0,16(a1)
 3a6:	6d84                	ld	s1,24(a1)
 3a8:	0205b903          	ld	s2,32(a1)
 3ac:	0285b983          	ld	s3,40(a1)
 3b0:	0305ba03          	ld	s4,48(a1)
 3b4:	0385ba83          	ld	s5,56(a1)
 3b8:	0405bb03          	ld	s6,64(a1)
 3bc:	0485bb83          	ld	s7,72(a1)
 3c0:	0505bc03          	ld	s8,80(a1)
 3c4:	0585bc83          	ld	s9,88(a1)
 3c8:	0605bd03          	ld	s10,96(a1)
 3cc:	0685bd83          	ld	s11,104(a1)
 3d0:	8082                	ret

00000000000003d2 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3d2:	715d                	addi	sp,sp,-80
 3d4:	e486                	sd	ra,72(sp)
 3d6:	e0a2                	sd	s0,64(sp)
 3d8:	fc26                	sd	s1,56(sp)
 3da:	f84a                	sd	s2,48(sp)
 3dc:	f44e                	sd	s3,40(sp)
 3de:	f052                	sd	s4,32(sp)
 3e0:	ec56                	sd	s5,24(sp)
 3e2:	e85a                	sd	s6,16(sp)
 3e4:	e45e                	sd	s7,8(sp)
 3e6:	0880                	addi	s0,sp,80
 3e8:	892a                	mv	s2,a0
 3ea:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 3ec:	00001517          	auipc	a0,0x1
 3f0:	93450513          	addi	a0,a0,-1740 # d20 <malloc+0x1e8>
 3f4:	00000097          	auipc	ra,0x0
 3f8:	68c080e7          	jalr	1676(ra) # a80 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3fc:	09000513          	li	a0,144
 400:	00000097          	auipc	ra,0x0
 404:	738080e7          	jalr	1848(ra) # b38 <malloc>

    main_thread->tid = 0;
 408:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 40c:	4791                	li	a5,4
 40e:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 410:	00001797          	auipc	a5,0x1
 414:	c0a7b023          	sd	a0,-1024(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 418:	00001a17          	auipc	s4,0x1
 41c:	c08a0a13          	addi	s4,s4,-1016 # 1020 <threads>
 420:	00001497          	auipc	s1,0x1
 424:	c8048493          	addi	s1,s1,-896 # 10a0 <base>
    current_thread = main_thread;
 428:	87d2                	mv	a5,s4
        threads[i] = NULL;
 42a:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 42e:	07a1                	addi	a5,a5,8
 430:	fe979de3          	bne	a5,s1,42a <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 434:	00001797          	auipc	a5,0x1
 438:	bea7b623          	sd	a0,-1044(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 43c:	85ce                	mv	a1,s3
 43e:	854a                	mv	a0,s2
 440:	00000097          	auipc	ra,0x0
 444:	bc0080e7          	jalr	-1088(ra) # 0 <main>
 448:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 44a:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 44c:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 44e:	00001a97          	auipc	s5,0x1
 452:	8f2a8a93          	addi	s5,s5,-1806 # d40 <malloc+0x208>
 456:	a03d                	j	484 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 458:	07a1                	addi	a5,a5,8
 45a:	00978963          	beq	a5,s1,46c <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 45e:	6398                	ld	a4,0(a5)
 460:	df65                	beqz	a4,458 <_main+0x86>
 462:	5f38                	lw	a4,120(a4)
 464:	ff370ae3          	beq	a4,s3,458 <_main+0x86>
                running_threads++;
 468:	2905                	addiw	s2,s2,1
 46a:	b7fd                	j	458 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 46c:	85ca                	mv	a1,s2
 46e:	8556                	mv	a0,s5
 470:	00000097          	auipc	ra,0x0
 474:	610080e7          	jalr	1552(ra) # a80 <printf>
        if (running_threads > 0) {
 478:	01205963          	blez	s2,48a <_main+0xb8>
            tsched(); // Schedule another thread to run
 47c:	00000097          	auipc	ra,0x0
 480:	ce8080e7          	jalr	-792(ra) # 164 <tsched>
    current_thread = main_thread;
 484:	87d2                	mv	a5,s4
        running_threads = 0;
 486:	895a                	mv	s2,s6
 488:	bfd9                	j	45e <_main+0x8c>
        }
    }

    exit(res);
 48a:	855e                	mv	a0,s7
 48c:	00000097          	auipc	ra,0x0
 490:	274080e7          	jalr	628(ra) # 700 <exit>

0000000000000494 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 494:	1141                	addi	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 49a:	87aa                	mv	a5,a0
 49c:	0585                	addi	a1,a1,1
 49e:	0785                	addi	a5,a5,1
 4a0:	fff5c703          	lbu	a4,-1(a1)
 4a4:	fee78fa3          	sb	a4,-1(a5)
 4a8:	fb75                	bnez	a4,49c <strcpy+0x8>
        ;
    return os;
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <strcmp>:

int strcmp(const char *p, const char *q)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e422                	sd	s0,8(sp)
 4b4:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	cb91                	beqz	a5,4ce <strcmp+0x1e>
 4bc:	0005c703          	lbu	a4,0(a1)
 4c0:	00f71763          	bne	a4,a5,4ce <strcmp+0x1e>
        p++, q++;
 4c4:	0505                	addi	a0,a0,1
 4c6:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4c8:	00054783          	lbu	a5,0(a0)
 4cc:	fbe5                	bnez	a5,4bc <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4ce:	0005c503          	lbu	a0,0(a1)
}
 4d2:	40a7853b          	subw	a0,a5,a0
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <strlen>:

uint strlen(const char *s)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	cf91                	beqz	a5,502 <strlen+0x26>
 4e8:	0505                	addi	a0,a0,1
 4ea:	87aa                	mv	a5,a0
 4ec:	86be                	mv	a3,a5
 4ee:	0785                	addi	a5,a5,1
 4f0:	fff7c703          	lbu	a4,-1(a5)
 4f4:	ff65                	bnez	a4,4ec <strlen+0x10>
 4f6:	40a6853b          	subw	a0,a3,a0
 4fa:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret
    for (n = 0; s[n]; n++)
 502:	4501                	li	a0,0
 504:	bfe5                	j	4fc <strlen+0x20>

0000000000000506 <memset>:

void *
memset(void *dst, int c, uint n)
{
 506:	1141                	addi	sp,sp,-16
 508:	e422                	sd	s0,8(sp)
 50a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 50c:	ca19                	beqz	a2,522 <memset+0x1c>
 50e:	87aa                	mv	a5,a0
 510:	1602                	slli	a2,a2,0x20
 512:	9201                	srli	a2,a2,0x20
 514:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 518:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 51c:	0785                	addi	a5,a5,1
 51e:	fee79de3          	bne	a5,a4,518 <memset+0x12>
    }
    return dst;
}
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret

0000000000000528 <strchr>:

char *
strchr(const char *s, char c)
{
 528:	1141                	addi	sp,sp,-16
 52a:	e422                	sd	s0,8(sp)
 52c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 52e:	00054783          	lbu	a5,0(a0)
 532:	cb99                	beqz	a5,548 <strchr+0x20>
        if (*s == c)
 534:	00f58763          	beq	a1,a5,542 <strchr+0x1a>
    for (; *s; s++)
 538:	0505                	addi	a0,a0,1
 53a:	00054783          	lbu	a5,0(a0)
 53e:	fbfd                	bnez	a5,534 <strchr+0xc>
            return (char *)s;
    return 0;
 540:	4501                	li	a0,0
}
 542:	6422                	ld	s0,8(sp)
 544:	0141                	addi	sp,sp,16
 546:	8082                	ret
    return 0;
 548:	4501                	li	a0,0
 54a:	bfe5                	j	542 <strchr+0x1a>

000000000000054c <gets>:

char *
gets(char *buf, int max)
{
 54c:	711d                	addi	sp,sp,-96
 54e:	ec86                	sd	ra,88(sp)
 550:	e8a2                	sd	s0,80(sp)
 552:	e4a6                	sd	s1,72(sp)
 554:	e0ca                	sd	s2,64(sp)
 556:	fc4e                	sd	s3,56(sp)
 558:	f852                	sd	s4,48(sp)
 55a:	f456                	sd	s5,40(sp)
 55c:	f05a                	sd	s6,32(sp)
 55e:	ec5e                	sd	s7,24(sp)
 560:	1080                	addi	s0,sp,96
 562:	8baa                	mv	s7,a0
 564:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 566:	892a                	mv	s2,a0
 568:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 56a:	4aa9                	li	s5,10
 56c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 56e:	89a6                	mv	s3,s1
 570:	2485                	addiw	s1,s1,1
 572:	0344d863          	bge	s1,s4,5a2 <gets+0x56>
        cc = read(0, &c, 1);
 576:	4605                	li	a2,1
 578:	faf40593          	addi	a1,s0,-81
 57c:	4501                	li	a0,0
 57e:	00000097          	auipc	ra,0x0
 582:	19a080e7          	jalr	410(ra) # 718 <read>
        if (cc < 1)
 586:	00a05e63          	blez	a0,5a2 <gets+0x56>
        buf[i++] = c;
 58a:	faf44783          	lbu	a5,-81(s0)
 58e:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 592:	01578763          	beq	a5,s5,5a0 <gets+0x54>
 596:	0905                	addi	s2,s2,1
 598:	fd679be3          	bne	a5,s6,56e <gets+0x22>
    for (i = 0; i + 1 < max;)
 59c:	89a6                	mv	s3,s1
 59e:	a011                	j	5a2 <gets+0x56>
 5a0:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5a2:	99de                	add	s3,s3,s7
 5a4:	00098023          	sb	zero,0(s3)
    return buf;
}
 5a8:	855e                	mv	a0,s7
 5aa:	60e6                	ld	ra,88(sp)
 5ac:	6446                	ld	s0,80(sp)
 5ae:	64a6                	ld	s1,72(sp)
 5b0:	6906                	ld	s2,64(sp)
 5b2:	79e2                	ld	s3,56(sp)
 5b4:	7a42                	ld	s4,48(sp)
 5b6:	7aa2                	ld	s5,40(sp)
 5b8:	7b02                	ld	s6,32(sp)
 5ba:	6be2                	ld	s7,24(sp)
 5bc:	6125                	addi	sp,sp,96
 5be:	8082                	ret

00000000000005c0 <stat>:

int stat(const char *n, struct stat *st)
{
 5c0:	1101                	addi	sp,sp,-32
 5c2:	ec06                	sd	ra,24(sp)
 5c4:	e822                	sd	s0,16(sp)
 5c6:	e426                	sd	s1,8(sp)
 5c8:	e04a                	sd	s2,0(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5ce:	4581                	li	a1,0
 5d0:	00000097          	auipc	ra,0x0
 5d4:	170080e7          	jalr	368(ra) # 740 <open>
    if (fd < 0)
 5d8:	02054563          	bltz	a0,602 <stat+0x42>
 5dc:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5de:	85ca                	mv	a1,s2
 5e0:	00000097          	auipc	ra,0x0
 5e4:	178080e7          	jalr	376(ra) # 758 <fstat>
 5e8:	892a                	mv	s2,a0
    close(fd);
 5ea:	8526                	mv	a0,s1
 5ec:	00000097          	auipc	ra,0x0
 5f0:	13c080e7          	jalr	316(ra) # 728 <close>
    return r;
}
 5f4:	854a                	mv	a0,s2
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	64a2                	ld	s1,8(sp)
 5fc:	6902                	ld	s2,0(sp)
 5fe:	6105                	addi	sp,sp,32
 600:	8082                	ret
        return -1;
 602:	597d                	li	s2,-1
 604:	bfc5                	j	5f4 <stat+0x34>

0000000000000606 <atoi>:

int atoi(const char *s)
{
 606:	1141                	addi	sp,sp,-16
 608:	e422                	sd	s0,8(sp)
 60a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 60c:	00054683          	lbu	a3,0(a0)
 610:	fd06879b          	addiw	a5,a3,-48
 614:	0ff7f793          	zext.b	a5,a5
 618:	4625                	li	a2,9
 61a:	02f66863          	bltu	a2,a5,64a <atoi+0x44>
 61e:	872a                	mv	a4,a0
    n = 0;
 620:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 622:	0705                	addi	a4,a4,1
 624:	0025179b          	slliw	a5,a0,0x2
 628:	9fa9                	addw	a5,a5,a0
 62a:	0017979b          	slliw	a5,a5,0x1
 62e:	9fb5                	addw	a5,a5,a3
 630:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 634:	00074683          	lbu	a3,0(a4)
 638:	fd06879b          	addiw	a5,a3,-48
 63c:	0ff7f793          	zext.b	a5,a5
 640:	fef671e3          	bgeu	a2,a5,622 <atoi+0x1c>
    return n;
}
 644:	6422                	ld	s0,8(sp)
 646:	0141                	addi	sp,sp,16
 648:	8082                	ret
    n = 0;
 64a:	4501                	li	a0,0
 64c:	bfe5                	j	644 <atoi+0x3e>

000000000000064e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 64e:	1141                	addi	sp,sp,-16
 650:	e422                	sd	s0,8(sp)
 652:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 654:	02b57463          	bgeu	a0,a1,67c <memmove+0x2e>
    {
        while (n-- > 0)
 658:	00c05f63          	blez	a2,676 <memmove+0x28>
 65c:	1602                	slli	a2,a2,0x20
 65e:	9201                	srli	a2,a2,0x20
 660:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 664:	872a                	mv	a4,a0
            *dst++ = *src++;
 666:	0585                	addi	a1,a1,1
 668:	0705                	addi	a4,a4,1
 66a:	fff5c683          	lbu	a3,-1(a1)
 66e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 672:	fee79ae3          	bne	a5,a4,666 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 676:	6422                	ld	s0,8(sp)
 678:	0141                	addi	sp,sp,16
 67a:	8082                	ret
        dst += n;
 67c:	00c50733          	add	a4,a0,a2
        src += n;
 680:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 682:	fec05ae3          	blez	a2,676 <memmove+0x28>
 686:	fff6079b          	addiw	a5,a2,-1
 68a:	1782                	slli	a5,a5,0x20
 68c:	9381                	srli	a5,a5,0x20
 68e:	fff7c793          	not	a5,a5
 692:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 694:	15fd                	addi	a1,a1,-1
 696:	177d                	addi	a4,a4,-1
 698:	0005c683          	lbu	a3,0(a1)
 69c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6a0:	fee79ae3          	bne	a5,a4,694 <memmove+0x46>
 6a4:	bfc9                	j	676 <memmove+0x28>

00000000000006a6 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6a6:	1141                	addi	sp,sp,-16
 6a8:	e422                	sd	s0,8(sp)
 6aa:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6ac:	ca05                	beqz	a2,6dc <memcmp+0x36>
 6ae:	fff6069b          	addiw	a3,a2,-1
 6b2:	1682                	slli	a3,a3,0x20
 6b4:	9281                	srli	a3,a3,0x20
 6b6:	0685                	addi	a3,a3,1
 6b8:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6ba:	00054783          	lbu	a5,0(a0)
 6be:	0005c703          	lbu	a4,0(a1)
 6c2:	00e79863          	bne	a5,a4,6d2 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6c6:	0505                	addi	a0,a0,1
        p2++;
 6c8:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6ca:	fed518e3          	bne	a0,a3,6ba <memcmp+0x14>
    }
    return 0;
 6ce:	4501                	li	a0,0
 6d0:	a019                	j	6d6 <memcmp+0x30>
            return *p1 - *p2;
 6d2:	40e7853b          	subw	a0,a5,a4
}
 6d6:	6422                	ld	s0,8(sp)
 6d8:	0141                	addi	sp,sp,16
 6da:	8082                	ret
    return 0;
 6dc:	4501                	li	a0,0
 6de:	bfe5                	j	6d6 <memcmp+0x30>

00000000000006e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6e0:	1141                	addi	sp,sp,-16
 6e2:	e406                	sd	ra,8(sp)
 6e4:	e022                	sd	s0,0(sp)
 6e6:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6e8:	00000097          	auipc	ra,0x0
 6ec:	f66080e7          	jalr	-154(ra) # 64e <memmove>
}
 6f0:	60a2                	ld	ra,8(sp)
 6f2:	6402                	ld	s0,0(sp)
 6f4:	0141                	addi	sp,sp,16
 6f6:	8082                	ret

00000000000006f8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6f8:	4885                	li	a7,1
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <exit>:
.global exit
exit:
 li a7, SYS_exit
 700:	4889                	li	a7,2
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <wait>:
.global wait
wait:
 li a7, SYS_wait
 708:	488d                	li	a7,3
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 710:	4891                	li	a7,4
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <read>:
.global read
read:
 li a7, SYS_read
 718:	4895                	li	a7,5
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <write>:
.global write
write:
 li a7, SYS_write
 720:	48c1                	li	a7,16
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <close>:
.global close
close:
 li a7, SYS_close
 728:	48d5                	li	a7,21
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <kill>:
.global kill
kill:
 li a7, SYS_kill
 730:	4899                	li	a7,6
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <exec>:
.global exec
exec:
 li a7, SYS_exec
 738:	489d                	li	a7,7
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <open>:
.global open
open:
 li a7, SYS_open
 740:	48bd                	li	a7,15
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 748:	48c5                	li	a7,17
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 750:	48c9                	li	a7,18
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 758:	48a1                	li	a7,8
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <link>:
.global link
link:
 li a7, SYS_link
 760:	48cd                	li	a7,19
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 768:	48d1                	li	a7,20
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 770:	48a5                	li	a7,9
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <dup>:
.global dup
dup:
 li a7, SYS_dup
 778:	48a9                	li	a7,10
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 780:	48ad                	li	a7,11
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 788:	48b1                	li	a7,12
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 790:	48b5                	li	a7,13
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 798:	48b9                	li	a7,14
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7a0:	48d9                	li	a7,22
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7a8:	48dd                	li	a7,23
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7b0:	48e1                	li	a7,24
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7b8:	1101                	addi	sp,sp,-32
 7ba:	ec06                	sd	ra,24(sp)
 7bc:	e822                	sd	s0,16(sp)
 7be:	1000                	addi	s0,sp,32
 7c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7c4:	4605                	li	a2,1
 7c6:	fef40593          	addi	a1,s0,-17
 7ca:	00000097          	auipc	ra,0x0
 7ce:	f56080e7          	jalr	-170(ra) # 720 <write>
}
 7d2:	60e2                	ld	ra,24(sp)
 7d4:	6442                	ld	s0,16(sp)
 7d6:	6105                	addi	sp,sp,32
 7d8:	8082                	ret

00000000000007da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7da:	7139                	addi	sp,sp,-64
 7dc:	fc06                	sd	ra,56(sp)
 7de:	f822                	sd	s0,48(sp)
 7e0:	f426                	sd	s1,40(sp)
 7e2:	f04a                	sd	s2,32(sp)
 7e4:	ec4e                	sd	s3,24(sp)
 7e6:	0080                	addi	s0,sp,64
 7e8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7ea:	c299                	beqz	a3,7f0 <printint+0x16>
 7ec:	0805c963          	bltz	a1,87e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7f0:	2581                	sext.w	a1,a1
  neg = 0;
 7f2:	4881                	li	a7,0
 7f4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7f8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7fa:	2601                	sext.w	a2,a2
 7fc:	00000517          	auipc	a0,0x0
 800:	5c450513          	addi	a0,a0,1476 # dc0 <digits>
 804:	883a                	mv	a6,a4
 806:	2705                	addiw	a4,a4,1
 808:	02c5f7bb          	remuw	a5,a1,a2
 80c:	1782                	slli	a5,a5,0x20
 80e:	9381                	srli	a5,a5,0x20
 810:	97aa                	add	a5,a5,a0
 812:	0007c783          	lbu	a5,0(a5)
 816:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 81a:	0005879b          	sext.w	a5,a1
 81e:	02c5d5bb          	divuw	a1,a1,a2
 822:	0685                	addi	a3,a3,1
 824:	fec7f0e3          	bgeu	a5,a2,804 <printint+0x2a>
  if(neg)
 828:	00088c63          	beqz	a7,840 <printint+0x66>
    buf[i++] = '-';
 82c:	fd070793          	addi	a5,a4,-48
 830:	00878733          	add	a4,a5,s0
 834:	02d00793          	li	a5,45
 838:	fef70823          	sb	a5,-16(a4)
 83c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 840:	02e05863          	blez	a4,870 <printint+0x96>
 844:	fc040793          	addi	a5,s0,-64
 848:	00e78933          	add	s2,a5,a4
 84c:	fff78993          	addi	s3,a5,-1
 850:	99ba                	add	s3,s3,a4
 852:	377d                	addiw	a4,a4,-1
 854:	1702                	slli	a4,a4,0x20
 856:	9301                	srli	a4,a4,0x20
 858:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 85c:	fff94583          	lbu	a1,-1(s2)
 860:	8526                	mv	a0,s1
 862:	00000097          	auipc	ra,0x0
 866:	f56080e7          	jalr	-170(ra) # 7b8 <putc>
  while(--i >= 0)
 86a:	197d                	addi	s2,s2,-1
 86c:	ff3918e3          	bne	s2,s3,85c <printint+0x82>
}
 870:	70e2                	ld	ra,56(sp)
 872:	7442                	ld	s0,48(sp)
 874:	74a2                	ld	s1,40(sp)
 876:	7902                	ld	s2,32(sp)
 878:	69e2                	ld	s3,24(sp)
 87a:	6121                	addi	sp,sp,64
 87c:	8082                	ret
    x = -xx;
 87e:	40b005bb          	negw	a1,a1
    neg = 1;
 882:	4885                	li	a7,1
    x = -xx;
 884:	bf85                	j	7f4 <printint+0x1a>

0000000000000886 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 886:	715d                	addi	sp,sp,-80
 888:	e486                	sd	ra,72(sp)
 88a:	e0a2                	sd	s0,64(sp)
 88c:	fc26                	sd	s1,56(sp)
 88e:	f84a                	sd	s2,48(sp)
 890:	f44e                	sd	s3,40(sp)
 892:	f052                	sd	s4,32(sp)
 894:	ec56                	sd	s5,24(sp)
 896:	e85a                	sd	s6,16(sp)
 898:	e45e                	sd	s7,8(sp)
 89a:	e062                	sd	s8,0(sp)
 89c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 89e:	0005c903          	lbu	s2,0(a1)
 8a2:	18090c63          	beqz	s2,a3a <vprintf+0x1b4>
 8a6:	8aaa                	mv	s5,a0
 8a8:	8bb2                	mv	s7,a2
 8aa:	00158493          	addi	s1,a1,1
  state = 0;
 8ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8b0:	02500a13          	li	s4,37
 8b4:	4b55                	li	s6,21
 8b6:	a839                	j	8d4 <vprintf+0x4e>
        putc(fd, c);
 8b8:	85ca                	mv	a1,s2
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	efc080e7          	jalr	-260(ra) # 7b8 <putc>
 8c4:	a019                	j	8ca <vprintf+0x44>
    } else if(state == '%'){
 8c6:	01498d63          	beq	s3,s4,8e0 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8ca:	0485                	addi	s1,s1,1
 8cc:	fff4c903          	lbu	s2,-1(s1)
 8d0:	16090563          	beqz	s2,a3a <vprintf+0x1b4>
    if(state == 0){
 8d4:	fe0999e3          	bnez	s3,8c6 <vprintf+0x40>
      if(c == '%'){
 8d8:	ff4910e3          	bne	s2,s4,8b8 <vprintf+0x32>
        state = '%';
 8dc:	89d2                	mv	s3,s4
 8de:	b7f5                	j	8ca <vprintf+0x44>
      if(c == 'd'){
 8e0:	13490263          	beq	s2,s4,a04 <vprintf+0x17e>
 8e4:	f9d9079b          	addiw	a5,s2,-99
 8e8:	0ff7f793          	zext.b	a5,a5
 8ec:	12fb6563          	bltu	s6,a5,a16 <vprintf+0x190>
 8f0:	f9d9079b          	addiw	a5,s2,-99
 8f4:	0ff7f713          	zext.b	a4,a5
 8f8:	10eb6f63          	bltu	s6,a4,a16 <vprintf+0x190>
 8fc:	00271793          	slli	a5,a4,0x2
 900:	00000717          	auipc	a4,0x0
 904:	46870713          	addi	a4,a4,1128 # d68 <malloc+0x230>
 908:	97ba                	add	a5,a5,a4
 90a:	439c                	lw	a5,0(a5)
 90c:	97ba                	add	a5,a5,a4
 90e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 910:	008b8913          	addi	s2,s7,8
 914:	4685                	li	a3,1
 916:	4629                	li	a2,10
 918:	000ba583          	lw	a1,0(s7)
 91c:	8556                	mv	a0,s5
 91e:	00000097          	auipc	ra,0x0
 922:	ebc080e7          	jalr	-324(ra) # 7da <printint>
 926:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 928:	4981                	li	s3,0
 92a:	b745                	j	8ca <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 92c:	008b8913          	addi	s2,s7,8
 930:	4681                	li	a3,0
 932:	4629                	li	a2,10
 934:	000ba583          	lw	a1,0(s7)
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	ea0080e7          	jalr	-352(ra) # 7da <printint>
 942:	8bca                	mv	s7,s2
      state = 0;
 944:	4981                	li	s3,0
 946:	b751                	j	8ca <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 948:	008b8913          	addi	s2,s7,8
 94c:	4681                	li	a3,0
 94e:	4641                	li	a2,16
 950:	000ba583          	lw	a1,0(s7)
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	e84080e7          	jalr	-380(ra) # 7da <printint>
 95e:	8bca                	mv	s7,s2
      state = 0;
 960:	4981                	li	s3,0
 962:	b7a5                	j	8ca <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 964:	008b8c13          	addi	s8,s7,8
 968:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 96c:	03000593          	li	a1,48
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	e46080e7          	jalr	-442(ra) # 7b8 <putc>
  putc(fd, 'x');
 97a:	07800593          	li	a1,120
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	e38080e7          	jalr	-456(ra) # 7b8 <putc>
 988:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 98a:	00000b97          	auipc	s7,0x0
 98e:	436b8b93          	addi	s7,s7,1078 # dc0 <digits>
 992:	03c9d793          	srli	a5,s3,0x3c
 996:	97de                	add	a5,a5,s7
 998:	0007c583          	lbu	a1,0(a5)
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	e1a080e7          	jalr	-486(ra) # 7b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9a6:	0992                	slli	s3,s3,0x4
 9a8:	397d                	addiw	s2,s2,-1
 9aa:	fe0914e3          	bnez	s2,992 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9ae:	8be2                	mv	s7,s8
      state = 0;
 9b0:	4981                	li	s3,0
 9b2:	bf21                	j	8ca <vprintf+0x44>
        s = va_arg(ap, char*);
 9b4:	008b8993          	addi	s3,s7,8
 9b8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9bc:	02090163          	beqz	s2,9de <vprintf+0x158>
        while(*s != 0){
 9c0:	00094583          	lbu	a1,0(s2)
 9c4:	c9a5                	beqz	a1,a34 <vprintf+0x1ae>
          putc(fd, *s);
 9c6:	8556                	mv	a0,s5
 9c8:	00000097          	auipc	ra,0x0
 9cc:	df0080e7          	jalr	-528(ra) # 7b8 <putc>
          s++;
 9d0:	0905                	addi	s2,s2,1
        while(*s != 0){
 9d2:	00094583          	lbu	a1,0(s2)
 9d6:	f9e5                	bnez	a1,9c6 <vprintf+0x140>
        s = va_arg(ap, char*);
 9d8:	8bce                	mv	s7,s3
      state = 0;
 9da:	4981                	li	s3,0
 9dc:	b5fd                	j	8ca <vprintf+0x44>
          s = "(null)";
 9de:	00000917          	auipc	s2,0x0
 9e2:	38290913          	addi	s2,s2,898 # d60 <malloc+0x228>
        while(*s != 0){
 9e6:	02800593          	li	a1,40
 9ea:	bff1                	j	9c6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9ec:	008b8913          	addi	s2,s7,8
 9f0:	000bc583          	lbu	a1,0(s7)
 9f4:	8556                	mv	a0,s5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	dc2080e7          	jalr	-574(ra) # 7b8 <putc>
 9fe:	8bca                	mv	s7,s2
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b5e1                	j	8ca <vprintf+0x44>
        putc(fd, c);
 a04:	02500593          	li	a1,37
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	dae080e7          	jalr	-594(ra) # 7b8 <putc>
      state = 0;
 a12:	4981                	li	s3,0
 a14:	bd5d                	j	8ca <vprintf+0x44>
        putc(fd, '%');
 a16:	02500593          	li	a1,37
 a1a:	8556                	mv	a0,s5
 a1c:	00000097          	auipc	ra,0x0
 a20:	d9c080e7          	jalr	-612(ra) # 7b8 <putc>
        putc(fd, c);
 a24:	85ca                	mv	a1,s2
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	d90080e7          	jalr	-624(ra) # 7b8 <putc>
      state = 0;
 a30:	4981                	li	s3,0
 a32:	bd61                	j	8ca <vprintf+0x44>
        s = va_arg(ap, char*);
 a34:	8bce                	mv	s7,s3
      state = 0;
 a36:	4981                	li	s3,0
 a38:	bd49                	j	8ca <vprintf+0x44>
    }
  }
}
 a3a:	60a6                	ld	ra,72(sp)
 a3c:	6406                	ld	s0,64(sp)
 a3e:	74e2                	ld	s1,56(sp)
 a40:	7942                	ld	s2,48(sp)
 a42:	79a2                	ld	s3,40(sp)
 a44:	7a02                	ld	s4,32(sp)
 a46:	6ae2                	ld	s5,24(sp)
 a48:	6b42                	ld	s6,16(sp)
 a4a:	6ba2                	ld	s7,8(sp)
 a4c:	6c02                	ld	s8,0(sp)
 a4e:	6161                	addi	sp,sp,80
 a50:	8082                	ret

0000000000000a52 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a52:	715d                	addi	sp,sp,-80
 a54:	ec06                	sd	ra,24(sp)
 a56:	e822                	sd	s0,16(sp)
 a58:	1000                	addi	s0,sp,32
 a5a:	e010                	sd	a2,0(s0)
 a5c:	e414                	sd	a3,8(s0)
 a5e:	e818                	sd	a4,16(s0)
 a60:	ec1c                	sd	a5,24(s0)
 a62:	03043023          	sd	a6,32(s0)
 a66:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a6a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a6e:	8622                	mv	a2,s0
 a70:	00000097          	auipc	ra,0x0
 a74:	e16080e7          	jalr	-490(ra) # 886 <vprintf>
}
 a78:	60e2                	ld	ra,24(sp)
 a7a:	6442                	ld	s0,16(sp)
 a7c:	6161                	addi	sp,sp,80
 a7e:	8082                	ret

0000000000000a80 <printf>:

void
printf(const char *fmt, ...)
{
 a80:	711d                	addi	sp,sp,-96
 a82:	ec06                	sd	ra,24(sp)
 a84:	e822                	sd	s0,16(sp)
 a86:	1000                	addi	s0,sp,32
 a88:	e40c                	sd	a1,8(s0)
 a8a:	e810                	sd	a2,16(s0)
 a8c:	ec14                	sd	a3,24(s0)
 a8e:	f018                	sd	a4,32(s0)
 a90:	f41c                	sd	a5,40(s0)
 a92:	03043823          	sd	a6,48(s0)
 a96:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a9a:	00840613          	addi	a2,s0,8
 a9e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 aa2:	85aa                	mv	a1,a0
 aa4:	4505                	li	a0,1
 aa6:	00000097          	auipc	ra,0x0
 aaa:	de0080e7          	jalr	-544(ra) # 886 <vprintf>
}
 aae:	60e2                	ld	ra,24(sp)
 ab0:	6442                	ld	s0,16(sp)
 ab2:	6125                	addi	sp,sp,96
 ab4:	8082                	ret

0000000000000ab6 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ab6:	1141                	addi	sp,sp,-16
 ab8:	e422                	sd	s0,8(sp)
 aba:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 abc:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac0:	00000797          	auipc	a5,0x0
 ac4:	5587b783          	ld	a5,1368(a5) # 1018 <freep>
 ac8:	a02d                	j	af2 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 aca:	4618                	lw	a4,8(a2)
 acc:	9f2d                	addw	a4,a4,a1
 ace:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ad2:	6398                	ld	a4,0(a5)
 ad4:	6310                	ld	a2,0(a4)
 ad6:	a83d                	j	b14 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ad8:	ff852703          	lw	a4,-8(a0)
 adc:	9f31                	addw	a4,a4,a2
 ade:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ae0:	ff053683          	ld	a3,-16(a0)
 ae4:	a091                	j	b28 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae6:	6398                	ld	a4,0(a5)
 ae8:	00e7e463          	bltu	a5,a4,af0 <free+0x3a>
 aec:	00e6ea63          	bltu	a3,a4,b00 <free+0x4a>
{
 af0:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af2:	fed7fae3          	bgeu	a5,a3,ae6 <free+0x30>
 af6:	6398                	ld	a4,0(a5)
 af8:	00e6e463          	bltu	a3,a4,b00 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afc:	fee7eae3          	bltu	a5,a4,af0 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b00:	ff852583          	lw	a1,-8(a0)
 b04:	6390                	ld	a2,0(a5)
 b06:	02059813          	slli	a6,a1,0x20
 b0a:	01c85713          	srli	a4,a6,0x1c
 b0e:	9736                	add	a4,a4,a3
 b10:	fae60de3          	beq	a2,a4,aca <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b14:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b18:	4790                	lw	a2,8(a5)
 b1a:	02061593          	slli	a1,a2,0x20
 b1e:	01c5d713          	srli	a4,a1,0x1c
 b22:	973e                	add	a4,a4,a5
 b24:	fae68ae3          	beq	a3,a4,ad8 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b28:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b2a:	00000717          	auipc	a4,0x0
 b2e:	4ef73723          	sd	a5,1262(a4) # 1018 <freep>
}
 b32:	6422                	ld	s0,8(sp)
 b34:	0141                	addi	sp,sp,16
 b36:	8082                	ret

0000000000000b38 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b38:	7139                	addi	sp,sp,-64
 b3a:	fc06                	sd	ra,56(sp)
 b3c:	f822                	sd	s0,48(sp)
 b3e:	f426                	sd	s1,40(sp)
 b40:	f04a                	sd	s2,32(sp)
 b42:	ec4e                	sd	s3,24(sp)
 b44:	e852                	sd	s4,16(sp)
 b46:	e456                	sd	s5,8(sp)
 b48:	e05a                	sd	s6,0(sp)
 b4a:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b4c:	02051493          	slli	s1,a0,0x20
 b50:	9081                	srli	s1,s1,0x20
 b52:	04bd                	addi	s1,s1,15
 b54:	8091                	srli	s1,s1,0x4
 b56:	0014899b          	addiw	s3,s1,1
 b5a:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b5c:	00000517          	auipc	a0,0x0
 b60:	4bc53503          	ld	a0,1212(a0) # 1018 <freep>
 b64:	c515                	beqz	a0,b90 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b66:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b68:	4798                	lw	a4,8(a5)
 b6a:	02977f63          	bgeu	a4,s1,ba8 <malloc+0x70>
    if (nu < 4096)
 b6e:	8a4e                	mv	s4,s3
 b70:	0009871b          	sext.w	a4,s3
 b74:	6685                	lui	a3,0x1
 b76:	00d77363          	bgeu	a4,a3,b7c <malloc+0x44>
 b7a:	6a05                	lui	s4,0x1
 b7c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b80:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b84:	00000917          	auipc	s2,0x0
 b88:	49490913          	addi	s2,s2,1172 # 1018 <freep>
    if (p == (char *)-1)
 b8c:	5afd                	li	s5,-1
 b8e:	a895                	j	c02 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b90:	00000797          	auipc	a5,0x0
 b94:	51078793          	addi	a5,a5,1296 # 10a0 <base>
 b98:	00000717          	auipc	a4,0x0
 b9c:	48f73023          	sd	a5,1152(a4) # 1018 <freep>
 ba0:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 ba2:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 ba6:	b7e1                	j	b6e <malloc+0x36>
            if (p->s.size == nunits)
 ba8:	02e48c63          	beq	s1,a4,be0 <malloc+0xa8>
                p->s.size -= nunits;
 bac:	4137073b          	subw	a4,a4,s3
 bb0:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bb2:	02071693          	slli	a3,a4,0x20
 bb6:	01c6d713          	srli	a4,a3,0x1c
 bba:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bbc:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bc0:	00000717          	auipc	a4,0x0
 bc4:	44a73c23          	sd	a0,1112(a4) # 1018 <freep>
            return (void *)(p + 1);
 bc8:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bcc:	70e2                	ld	ra,56(sp)
 bce:	7442                	ld	s0,48(sp)
 bd0:	74a2                	ld	s1,40(sp)
 bd2:	7902                	ld	s2,32(sp)
 bd4:	69e2                	ld	s3,24(sp)
 bd6:	6a42                	ld	s4,16(sp)
 bd8:	6aa2                	ld	s5,8(sp)
 bda:	6b02                	ld	s6,0(sp)
 bdc:	6121                	addi	sp,sp,64
 bde:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 be0:	6398                	ld	a4,0(a5)
 be2:	e118                	sd	a4,0(a0)
 be4:	bff1                	j	bc0 <malloc+0x88>
    hp->s.size = nu;
 be6:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bea:	0541                	addi	a0,a0,16
 bec:	00000097          	auipc	ra,0x0
 bf0:	eca080e7          	jalr	-310(ra) # ab6 <free>
    return freep;
 bf4:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bf8:	d971                	beqz	a0,bcc <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bfa:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bfc:	4798                	lw	a4,8(a5)
 bfe:	fa9775e3          	bgeu	a4,s1,ba8 <malloc+0x70>
        if (p == freep)
 c02:	00093703          	ld	a4,0(s2)
 c06:	853e                	mv	a0,a5
 c08:	fef719e3          	bne	a4,a5,bfa <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c0c:	8552                	mv	a0,s4
 c0e:	00000097          	auipc	ra,0x0
 c12:	b7a080e7          	jalr	-1158(ra) # 788 <sbrk>
    if (p == (char *)-1)
 c16:	fd5518e3          	bne	a0,s5,be6 <malloc+0xae>
                return 0;
 c1a:	4501                	li	a0,0
 c1c:	bf45                	j	bcc <malloc+0x94>
