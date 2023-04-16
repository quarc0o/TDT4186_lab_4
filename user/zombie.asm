
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	6d6080e7          	jalr	1750(ra) # 6de <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	6d0080e7          	jalr	1744(ra) # 6e6 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	756080e7          	jalr	1878(ra) # 776 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	addi	s0,sp,16
    lk->name = name;
  30:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  32:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  36:	57fd                	li	a5,-1
  38:	00f50823          	sb	a5,16(a0)
}
  3c:	6422                	ld	s0,8(sp)
  3e:	0141                	addi	sp,sp,16
  40:	8082                	ret

0000000000000042 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  42:	00054783          	lbu	a5,0(a0)
  46:	e399                	bnez	a5,4c <holding+0xa>
  48:	4501                	li	a0,0
}
  4a:	8082                	ret
{
  4c:	1101                	addi	sp,sp,-32
  4e:	ec06                	sd	ra,24(sp)
  50:	e822                	sd	s0,16(sp)
  52:	e426                	sd	s1,8(sp)
  54:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  56:	01054483          	lbu	s1,16(a0)
  5a:	00000097          	auipc	ra,0x0
  5e:	2dc080e7          	jalr	732(ra) # 336 <twhoami>
  62:	2501                	sext.w	a0,a0
  64:	40a48533          	sub	a0,s1,a0
  68:	00153513          	seqz	a0,a0
}
  6c:	60e2                	ld	ra,24(sp)
  6e:	6442                	ld	s0,16(sp)
  70:	64a2                	ld	s1,8(sp)
  72:	6105                	addi	sp,sp,32
  74:	8082                	ret

0000000000000076 <acquire>:

void acquire(struct lock *lk)
{
  76:	7179                	addi	sp,sp,-48
  78:	f406                	sd	ra,40(sp)
  7a:	f022                	sd	s0,32(sp)
  7c:	ec26                	sd	s1,24(sp)
  7e:	e84a                	sd	s2,16(sp)
  80:	e44e                	sd	s3,8(sp)
  82:	e052                	sd	s4,0(sp)
  84:	1800                	addi	s0,sp,48
  86:	8a2a                	mv	s4,a0
    if (holding(lk))
  88:	00000097          	auipc	ra,0x0
  8c:	fba080e7          	jalr	-70(ra) # 42 <holding>
  90:	e919                	bnez	a0,a6 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  92:	ffca7493          	andi	s1,s4,-4
  96:	003a7913          	andi	s2,s4,3
  9a:	0039191b          	slliw	s2,s2,0x3
  9e:	4985                	li	s3,1
  a0:	012999bb          	sllw	s3,s3,s2
  a4:	a015                	j	c8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  a6:	00001517          	auipc	a0,0x1
  aa:	b6a50513          	addi	a0,a0,-1174 # c10 <malloc+0xf2>
  ae:	00001097          	auipc	ra,0x1
  b2:	9b8080e7          	jalr	-1608(ra) # a66 <printf>
        exit(-1);
  b6:	557d                	li	a0,-1
  b8:	00000097          	auipc	ra,0x0
  bc:	62e080e7          	jalr	1582(ra) # 6e6 <exit>
    {
        // give up the cpu for other threads
        tyield();
  c0:	00000097          	auipc	ra,0x0
  c4:	252080e7          	jalr	594(ra) # 312 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  cc:	0127d7bb          	srlw	a5,a5,s2
  d0:	0ff7f793          	zext.b	a5,a5
  d4:	f7f5                	bnez	a5,c0 <acquire+0x4a>
    }

    __sync_synchronize();
  d6:	0ff0000f          	fence

    lk->tid = twhoami();
  da:	00000097          	auipc	ra,0x0
  de:	25c080e7          	jalr	604(ra) # 336 <twhoami>
  e2:	00aa0823          	sb	a0,16(s4)
}
  e6:	70a2                	ld	ra,40(sp)
  e8:	7402                	ld	s0,32(sp)
  ea:	64e2                	ld	s1,24(sp)
  ec:	6942                	ld	s2,16(sp)
  ee:	69a2                	ld	s3,8(sp)
  f0:	6a02                	ld	s4,0(sp)
  f2:	6145                	addi	sp,sp,48
  f4:	8082                	ret

00000000000000f6 <release>:

void release(struct lock *lk)
{
  f6:	1101                	addi	sp,sp,-32
  f8:	ec06                	sd	ra,24(sp)
  fa:	e822                	sd	s0,16(sp)
  fc:	e426                	sd	s1,8(sp)
  fe:	1000                	addi	s0,sp,32
 100:	84aa                	mv	s1,a0
    if (!holding(lk))
 102:	00000097          	auipc	ra,0x0
 106:	f40080e7          	jalr	-192(ra) # 42 <holding>
 10a:	c11d                	beqz	a0,130 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 10c:	57fd                	li	a5,-1
 10e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 112:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 116:	0ff0000f          	fence
 11a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 11e:	00000097          	auipc	ra,0x0
 122:	1f4080e7          	jalr	500(ra) # 312 <tyield>
}
 126:	60e2                	ld	ra,24(sp)
 128:	6442                	ld	s0,16(sp)
 12a:	64a2                	ld	s1,8(sp)
 12c:	6105                	addi	sp,sp,32
 12e:	8082                	ret
        printf("releasing lock we are not holding");
 130:	00001517          	auipc	a0,0x1
 134:	b0850513          	addi	a0,a0,-1272 # c38 <malloc+0x11a>
 138:	00001097          	auipc	ra,0x1
 13c:	92e080e7          	jalr	-1746(ra) # a66 <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	5a4080e7          	jalr	1444(ra) # 6e6 <exit>

000000000000014a <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 14a:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 14c:	00001617          	auipc	a2,0x1
 150:	ed460613          	addi	a2,a2,-300 # 1020 <threads>
 154:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 156:	45c1                	li	a1,16
 158:	a021                	j	160 <tsched+0x16>
 15a:	2685                	addiw	a3,a3,1
 15c:	08b68c63          	beq	a3,a1,1f4 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 160:	41f6d71b          	sraiw	a4,a3,0x1f
 164:	01c7571b          	srliw	a4,a4,0x1c
 168:	00d707bb          	addw	a5,a4,a3
 16c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 16e:	9f99                	subw	a5,a5,a4
 170:	078e                	slli	a5,a5,0x3
 172:	97b2                	add	a5,a5,a2
 174:	639c                	ld	a5,0(a5)
 176:	d3f5                	beqz	a5,15a <tsched+0x10>
 178:	5fb8                	lw	a4,120(a5)
 17a:	fea710e3          	bne	a4,a0,15a <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 17e:	00001717          	auipc	a4,0x1
 182:	ea273703          	ld	a4,-350(a4) # 1020 <threads>
 186:	5f30                	lw	a2,120(a4)
 188:	468d                	li	a3,3
 18a:	06d60363          	beq	a2,a3,1f0 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 18e:	c3a5                	beqz	a5,1ee <tsched+0xa4>
{
 190:	1101                	addi	sp,sp,-32
 192:	ec06                	sd	ra,24(sp)
 194:	e822                	sd	s0,16(sp)
 196:	e426                	sd	s1,8(sp)
 198:	e04a                	sd	s2,0(sp)
 19a:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 19c:	00001497          	auipc	s1,0x1
 1a0:	e7448493          	addi	s1,s1,-396 # 1010 <current_thread>
 1a4:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1a8:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1aa:	0007c603          	lbu	a2,0(a5)
 1ae:	00094583          	lbu	a1,0(s2)
 1b2:	00001517          	auipc	a0,0x1
 1b6:	aae50513          	addi	a0,a0,-1362 # c60 <malloc+0x142>
 1ba:	00001097          	auipc	ra,0x1
 1be:	8ac080e7          	jalr	-1876(ra) # a66 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1c2:	608c                	ld	a1,0(s1)
 1c4:	05a1                	addi	a1,a1,8
 1c6:	00890513          	addi	a0,s2,8
 1ca:	00000097          	auipc	ra,0x0
 1ce:	184080e7          	jalr	388(ra) # 34e <tswtch>
        printf("Thread switch complete\n");
 1d2:	00001517          	auipc	a0,0x1
 1d6:	ab650513          	addi	a0,a0,-1354 # c88 <malloc+0x16a>
 1da:	00001097          	auipc	ra,0x1
 1de:	88c080e7          	jalr	-1908(ra) # a66 <printf>
    }
}
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	64a2                	ld	s1,8(sp)
 1e8:	6902                	ld	s2,0(sp)
 1ea:	6105                	addi	sp,sp,32
 1ec:	8082                	ret
 1ee:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 1f0:	87ba                	mv	a5,a4
 1f2:	bf79                	j	190 <tsched+0x46>
 1f4:	00001797          	auipc	a5,0x1
 1f8:	e2c7b783          	ld	a5,-468(a5) # 1020 <threads>
 1fc:	5fb4                	lw	a3,120(a5)
 1fe:	470d                	li	a4,3
 200:	f8e688e3          	beq	a3,a4,190 <tsched+0x46>
 204:	8082                	ret

0000000000000206 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 206:	7179                	addi	sp,sp,-48
 208:	f406                	sd	ra,40(sp)
 20a:	f022                	sd	s0,32(sp)
 20c:	ec26                	sd	s1,24(sp)
 20e:	e84a                	sd	s2,16(sp)
 210:	e44e                	sd	s3,8(sp)
 212:	1800                	addi	s0,sp,48
 214:	84aa                	mv	s1,a0
 216:	89b2                	mv	s3,a2
 218:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 21a:	09000513          	li	a0,144
 21e:	00001097          	auipc	ra,0x1
 222:	900080e7          	jalr	-1792(ra) # b1e <malloc>
 226:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 228:	478d                	li	a5,3
 22a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 22c:	609c                	ld	a5,0(s1)
 22e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 232:	609c                	ld	a5,0(s1)
 234:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 238:	00001717          	auipc	a4,0x1
 23c:	dc870713          	addi	a4,a4,-568 # 1000 <next_tid>
 240:	431c                	lw	a5,0(a4)
 242:	0017869b          	addiw	a3,a5,1
 246:	c314                	sw	a3,0(a4)
 248:	6098                	ld	a4,0(s1)
 24a:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 24e:	00001717          	auipc	a4,0x1
 252:	dd270713          	addi	a4,a4,-558 # 1020 <threads>
 256:	4781                	li	a5,0
 258:	4641                	li	a2,16
    if (threads[i] == NULL) {
 25a:	6314                	ld	a3,0(a4)
 25c:	ce81                	beqz	a3,274 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 25e:	2785                	addiw	a5,a5,1
 260:	0721                	addi	a4,a4,8
 262:	fec79ce3          	bne	a5,a2,25a <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 266:	70a2                	ld	ra,40(sp)
 268:	7402                	ld	s0,32(sp)
 26a:	64e2                	ld	s1,24(sp)
 26c:	6942                	ld	s2,16(sp)
 26e:	69a2                	ld	s3,8(sp)
 270:	6145                	addi	sp,sp,48
 272:	8082                	ret
        threads[i] = *thread;
 274:	6094                	ld	a3,0(s1)
 276:	078e                	slli	a5,a5,0x3
 278:	00001717          	auipc	a4,0x1
 27c:	da870713          	addi	a4,a4,-600 # 1020 <threads>
 280:	97ba                	add	a5,a5,a4
 282:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 284:	0006c583          	lbu	a1,0(a3)
 288:	00001517          	auipc	a0,0x1
 28c:	a1850513          	addi	a0,a0,-1512 # ca0 <malloc+0x182>
 290:	00000097          	auipc	ra,0x0
 294:	7d6080e7          	jalr	2006(ra) # a66 <printf>
        break;
 298:	b7f9                	j	266 <tcreate+0x60>

000000000000029a <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 29a:	7179                	addi	sp,sp,-48
 29c:	f406                	sd	ra,40(sp)
 29e:	f022                	sd	s0,32(sp)
 2a0:	ec26                	sd	s1,24(sp)
 2a2:	e84a                	sd	s2,16(sp)
 2a4:	e44e                	sd	s3,8(sp)
 2a6:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2a8:	00001797          	auipc	a5,0x1
 2ac:	d7878793          	addi	a5,a5,-648 # 1020 <threads>
 2b0:	00001697          	auipc	a3,0x1
 2b4:	df068693          	addi	a3,a3,-528 # 10a0 <base>
 2b8:	a021                	j	2c0 <tjoin+0x26>
 2ba:	07a1                	addi	a5,a5,8
 2bc:	04d78763          	beq	a5,a3,30a <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2c0:	6384                	ld	s1,0(a5)
 2c2:	dce5                	beqz	s1,2ba <tjoin+0x20>
 2c4:	0004c703          	lbu	a4,0(s1)
 2c8:	fea719e3          	bne	a4,a0,2ba <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 2cc:	5cb8                	lw	a4,120(s1)
 2ce:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2d0:	00001997          	auipc	s3,0x1
 2d4:	a0098993          	addi	s3,s3,-1536 # cd0 <malloc+0x1b2>
    while (target_thread->state != EXITED) {
 2d8:	4919                	li	s2,6
 2da:	02f70a63          	beq	a4,a5,30e <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2de:	0004c583          	lbu	a1,0(s1)
 2e2:	854e                	mv	a0,s3
 2e4:	00000097          	auipc	ra,0x0
 2e8:	782080e7          	jalr	1922(ra) # a66 <printf>
        tsched();
 2ec:	00000097          	auipc	ra,0x0
 2f0:	e5e080e7          	jalr	-418(ra) # 14a <tsched>
    while (target_thread->state != EXITED) {
 2f4:	5cbc                	lw	a5,120(s1)
 2f6:	ff2794e3          	bne	a5,s2,2de <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 2fa:	4501                	li	a0,0
}
 2fc:	70a2                	ld	ra,40(sp)
 2fe:	7402                	ld	s0,32(sp)
 300:	64e2                	ld	s1,24(sp)
 302:	6942                	ld	s2,16(sp)
 304:	69a2                	ld	s3,8(sp)
 306:	6145                	addi	sp,sp,48
 308:	8082                	ret
        return -1;
 30a:	557d                	li	a0,-1
 30c:	bfc5                	j	2fc <tjoin+0x62>
    return 0;
 30e:	4501                	li	a0,0
 310:	b7f5                	j	2fc <tjoin+0x62>

0000000000000312 <tyield>:


void tyield()
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 31a:	00001797          	auipc	a5,0x1
 31e:	cf67b783          	ld	a5,-778(a5) # 1010 <current_thread>
 322:	470d                	li	a4,3
 324:	dfb8                	sw	a4,120(a5)
    tsched();
 326:	00000097          	auipc	ra,0x0
 32a:	e24080e7          	jalr	-476(ra) # 14a <tsched>
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <twhoami>:

uint8 twhoami()
{
 336:	1141                	addi	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 33c:	00001797          	auipc	a5,0x1
 340:	cd47b783          	ld	a5,-812(a5) # 1010 <current_thread>
 344:	0007c503          	lbu	a0,0(a5)
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <tswtch>:
 34e:	00153023          	sd	ra,0(a0)
 352:	00253423          	sd	sp,8(a0)
 356:	e900                	sd	s0,16(a0)
 358:	ed04                	sd	s1,24(a0)
 35a:	03253023          	sd	s2,32(a0)
 35e:	03353423          	sd	s3,40(a0)
 362:	03453823          	sd	s4,48(a0)
 366:	03553c23          	sd	s5,56(a0)
 36a:	05653023          	sd	s6,64(a0)
 36e:	05753423          	sd	s7,72(a0)
 372:	05853823          	sd	s8,80(a0)
 376:	05953c23          	sd	s9,88(a0)
 37a:	07a53023          	sd	s10,96(a0)
 37e:	07b53423          	sd	s11,104(a0)
 382:	0005b083          	ld	ra,0(a1)
 386:	0085b103          	ld	sp,8(a1)
 38a:	6980                	ld	s0,16(a1)
 38c:	6d84                	ld	s1,24(a1)
 38e:	0205b903          	ld	s2,32(a1)
 392:	0285b983          	ld	s3,40(a1)
 396:	0305ba03          	ld	s4,48(a1)
 39a:	0385ba83          	ld	s5,56(a1)
 39e:	0405bb03          	ld	s6,64(a1)
 3a2:	0485bb83          	ld	s7,72(a1)
 3a6:	0505bc03          	ld	s8,80(a1)
 3aa:	0585bc83          	ld	s9,88(a1)
 3ae:	0605bd03          	ld	s10,96(a1)
 3b2:	0685bd83          	ld	s11,104(a1)
 3b6:	8082                	ret

00000000000003b8 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3b8:	715d                	addi	sp,sp,-80
 3ba:	e486                	sd	ra,72(sp)
 3bc:	e0a2                	sd	s0,64(sp)
 3be:	fc26                	sd	s1,56(sp)
 3c0:	f84a                	sd	s2,48(sp)
 3c2:	f44e                	sd	s3,40(sp)
 3c4:	f052                	sd	s4,32(sp)
 3c6:	ec56                	sd	s5,24(sp)
 3c8:	e85a                	sd	s6,16(sp)
 3ca:	e45e                	sd	s7,8(sp)
 3cc:	0880                	addi	s0,sp,80
 3ce:	892a                	mv	s2,a0
 3d0:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 3d2:	00001517          	auipc	a0,0x1
 3d6:	91e50513          	addi	a0,a0,-1762 # cf0 <malloc+0x1d2>
 3da:	00000097          	auipc	ra,0x0
 3de:	68c080e7          	jalr	1676(ra) # a66 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3e2:	09000513          	li	a0,144
 3e6:	00000097          	auipc	ra,0x0
 3ea:	738080e7          	jalr	1848(ra) # b1e <malloc>

    main_thread->tid = 0;
 3ee:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 3f2:	4791                	li	a5,4
 3f4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3f6:	00001797          	auipc	a5,0x1
 3fa:	c0a7bd23          	sd	a0,-998(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3fe:	00001a17          	auipc	s4,0x1
 402:	c22a0a13          	addi	s4,s4,-990 # 1020 <threads>
 406:	00001497          	auipc	s1,0x1
 40a:	c9a48493          	addi	s1,s1,-870 # 10a0 <base>
    current_thread = main_thread;
 40e:	87d2                	mv	a5,s4
        threads[i] = NULL;
 410:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 414:	07a1                	addi	a5,a5,8
 416:	fe979de3          	bne	a5,s1,410 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 41a:	00001797          	auipc	a5,0x1
 41e:	c0a7b323          	sd	a0,-1018(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 422:	85ce                	mv	a1,s3
 424:	854a                	mv	a0,s2
 426:	00000097          	auipc	ra,0x0
 42a:	bda080e7          	jalr	-1062(ra) # 0 <main>
 42e:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 430:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 432:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 434:	00001a97          	auipc	s5,0x1
 438:	8dca8a93          	addi	s5,s5,-1828 # d10 <malloc+0x1f2>
 43c:	a03d                	j	46a <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 43e:	07a1                	addi	a5,a5,8
 440:	00978963          	beq	a5,s1,452 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 444:	6398                	ld	a4,0(a5)
 446:	df65                	beqz	a4,43e <_main+0x86>
 448:	5f38                	lw	a4,120(a4)
 44a:	ff370ae3          	beq	a4,s3,43e <_main+0x86>
                running_threads++;
 44e:	2905                	addiw	s2,s2,1
 450:	b7fd                	j	43e <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 452:	85ca                	mv	a1,s2
 454:	8556                	mv	a0,s5
 456:	00000097          	auipc	ra,0x0
 45a:	610080e7          	jalr	1552(ra) # a66 <printf>
        if (running_threads > 0) {
 45e:	01205963          	blez	s2,470 <_main+0xb8>
            tsched(); // Schedule another thread to run
 462:	00000097          	auipc	ra,0x0
 466:	ce8080e7          	jalr	-792(ra) # 14a <tsched>
    current_thread = main_thread;
 46a:	87d2                	mv	a5,s4
        running_threads = 0;
 46c:	895a                	mv	s2,s6
 46e:	bfd9                	j	444 <_main+0x8c>
        }
    }

    exit(res);
 470:	855e                	mv	a0,s7
 472:	00000097          	auipc	ra,0x0
 476:	274080e7          	jalr	628(ra) # 6e6 <exit>

000000000000047a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 480:	87aa                	mv	a5,a0
 482:	0585                	addi	a1,a1,1
 484:	0785                	addi	a5,a5,1
 486:	fff5c703          	lbu	a4,-1(a1)
 48a:	fee78fa3          	sb	a4,-1(a5)
 48e:	fb75                	bnez	a4,482 <strcpy+0x8>
        ;
    return os;
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <strcmp>:

int strcmp(const char *p, const char *q)
{
 496:	1141                	addi	sp,sp,-16
 498:	e422                	sd	s0,8(sp)
 49a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 49c:	00054783          	lbu	a5,0(a0)
 4a0:	cb91                	beqz	a5,4b4 <strcmp+0x1e>
 4a2:	0005c703          	lbu	a4,0(a1)
 4a6:	00f71763          	bne	a4,a5,4b4 <strcmp+0x1e>
        p++, q++;
 4aa:	0505                	addi	a0,a0,1
 4ac:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4ae:	00054783          	lbu	a5,0(a0)
 4b2:	fbe5                	bnez	a5,4a2 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4b4:	0005c503          	lbu	a0,0(a1)
}
 4b8:	40a7853b          	subw	a0,a5,a0
 4bc:	6422                	ld	s0,8(sp)
 4be:	0141                	addi	sp,sp,16
 4c0:	8082                	ret

00000000000004c2 <strlen>:

uint strlen(const char *s)
{
 4c2:	1141                	addi	sp,sp,-16
 4c4:	e422                	sd	s0,8(sp)
 4c6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4c8:	00054783          	lbu	a5,0(a0)
 4cc:	cf91                	beqz	a5,4e8 <strlen+0x26>
 4ce:	0505                	addi	a0,a0,1
 4d0:	87aa                	mv	a5,a0
 4d2:	86be                	mv	a3,a5
 4d4:	0785                	addi	a5,a5,1
 4d6:	fff7c703          	lbu	a4,-1(a5)
 4da:	ff65                	bnez	a4,4d2 <strlen+0x10>
 4dc:	40a6853b          	subw	a0,a3,a0
 4e0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4e2:	6422                	ld	s0,8(sp)
 4e4:	0141                	addi	sp,sp,16
 4e6:	8082                	ret
    for (n = 0; s[n]; n++)
 4e8:	4501                	li	a0,0
 4ea:	bfe5                	j	4e2 <strlen+0x20>

00000000000004ec <memset>:

void *
memset(void *dst, int c, uint n)
{
 4ec:	1141                	addi	sp,sp,-16
 4ee:	e422                	sd	s0,8(sp)
 4f0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4f2:	ca19                	beqz	a2,508 <memset+0x1c>
 4f4:	87aa                	mv	a5,a0
 4f6:	1602                	slli	a2,a2,0x20
 4f8:	9201                	srli	a2,a2,0x20
 4fa:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4fe:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 502:	0785                	addi	a5,a5,1
 504:	fee79de3          	bne	a5,a4,4fe <memset+0x12>
    }
    return dst;
}
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret

000000000000050e <strchr>:

char *
strchr(const char *s, char c)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	addi	s0,sp,16
    for (; *s; s++)
 514:	00054783          	lbu	a5,0(a0)
 518:	cb99                	beqz	a5,52e <strchr+0x20>
        if (*s == c)
 51a:	00f58763          	beq	a1,a5,528 <strchr+0x1a>
    for (; *s; s++)
 51e:	0505                	addi	a0,a0,1
 520:	00054783          	lbu	a5,0(a0)
 524:	fbfd                	bnez	a5,51a <strchr+0xc>
            return (char *)s;
    return 0;
 526:	4501                	li	a0,0
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
    return 0;
 52e:	4501                	li	a0,0
 530:	bfe5                	j	528 <strchr+0x1a>

0000000000000532 <gets>:

char *
gets(char *buf, int max)
{
 532:	711d                	addi	sp,sp,-96
 534:	ec86                	sd	ra,88(sp)
 536:	e8a2                	sd	s0,80(sp)
 538:	e4a6                	sd	s1,72(sp)
 53a:	e0ca                	sd	s2,64(sp)
 53c:	fc4e                	sd	s3,56(sp)
 53e:	f852                	sd	s4,48(sp)
 540:	f456                	sd	s5,40(sp)
 542:	f05a                	sd	s6,32(sp)
 544:	ec5e                	sd	s7,24(sp)
 546:	1080                	addi	s0,sp,96
 548:	8baa                	mv	s7,a0
 54a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 54c:	892a                	mv	s2,a0
 54e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 550:	4aa9                	li	s5,10
 552:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 554:	89a6                	mv	s3,s1
 556:	2485                	addiw	s1,s1,1
 558:	0344d863          	bge	s1,s4,588 <gets+0x56>
        cc = read(0, &c, 1);
 55c:	4605                	li	a2,1
 55e:	faf40593          	addi	a1,s0,-81
 562:	4501                	li	a0,0
 564:	00000097          	auipc	ra,0x0
 568:	19a080e7          	jalr	410(ra) # 6fe <read>
        if (cc < 1)
 56c:	00a05e63          	blez	a0,588 <gets+0x56>
        buf[i++] = c;
 570:	faf44783          	lbu	a5,-81(s0)
 574:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 578:	01578763          	beq	a5,s5,586 <gets+0x54>
 57c:	0905                	addi	s2,s2,1
 57e:	fd679be3          	bne	a5,s6,554 <gets+0x22>
    for (i = 0; i + 1 < max;)
 582:	89a6                	mv	s3,s1
 584:	a011                	j	588 <gets+0x56>
 586:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 588:	99de                	add	s3,s3,s7
 58a:	00098023          	sb	zero,0(s3)
    return buf;
}
 58e:	855e                	mv	a0,s7
 590:	60e6                	ld	ra,88(sp)
 592:	6446                	ld	s0,80(sp)
 594:	64a6                	ld	s1,72(sp)
 596:	6906                	ld	s2,64(sp)
 598:	79e2                	ld	s3,56(sp)
 59a:	7a42                	ld	s4,48(sp)
 59c:	7aa2                	ld	s5,40(sp)
 59e:	7b02                	ld	s6,32(sp)
 5a0:	6be2                	ld	s7,24(sp)
 5a2:	6125                	addi	sp,sp,96
 5a4:	8082                	ret

00000000000005a6 <stat>:

int stat(const char *n, struct stat *st)
{
 5a6:	1101                	addi	sp,sp,-32
 5a8:	ec06                	sd	ra,24(sp)
 5aa:	e822                	sd	s0,16(sp)
 5ac:	e426                	sd	s1,8(sp)
 5ae:	e04a                	sd	s2,0(sp)
 5b0:	1000                	addi	s0,sp,32
 5b2:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5b4:	4581                	li	a1,0
 5b6:	00000097          	auipc	ra,0x0
 5ba:	170080e7          	jalr	368(ra) # 726 <open>
    if (fd < 0)
 5be:	02054563          	bltz	a0,5e8 <stat+0x42>
 5c2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5c4:	85ca                	mv	a1,s2
 5c6:	00000097          	auipc	ra,0x0
 5ca:	178080e7          	jalr	376(ra) # 73e <fstat>
 5ce:	892a                	mv	s2,a0
    close(fd);
 5d0:	8526                	mv	a0,s1
 5d2:	00000097          	auipc	ra,0x0
 5d6:	13c080e7          	jalr	316(ra) # 70e <close>
    return r;
}
 5da:	854a                	mv	a0,s2
 5dc:	60e2                	ld	ra,24(sp)
 5de:	6442                	ld	s0,16(sp)
 5e0:	64a2                	ld	s1,8(sp)
 5e2:	6902                	ld	s2,0(sp)
 5e4:	6105                	addi	sp,sp,32
 5e6:	8082                	ret
        return -1;
 5e8:	597d                	li	s2,-1
 5ea:	bfc5                	j	5da <stat+0x34>

00000000000005ec <atoi>:

int atoi(const char *s)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5f2:	00054683          	lbu	a3,0(a0)
 5f6:	fd06879b          	addiw	a5,a3,-48
 5fa:	0ff7f793          	zext.b	a5,a5
 5fe:	4625                	li	a2,9
 600:	02f66863          	bltu	a2,a5,630 <atoi+0x44>
 604:	872a                	mv	a4,a0
    n = 0;
 606:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 608:	0705                	addi	a4,a4,1
 60a:	0025179b          	slliw	a5,a0,0x2
 60e:	9fa9                	addw	a5,a5,a0
 610:	0017979b          	slliw	a5,a5,0x1
 614:	9fb5                	addw	a5,a5,a3
 616:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 61a:	00074683          	lbu	a3,0(a4)
 61e:	fd06879b          	addiw	a5,a3,-48
 622:	0ff7f793          	zext.b	a5,a5
 626:	fef671e3          	bgeu	a2,a5,608 <atoi+0x1c>
    return n;
}
 62a:	6422                	ld	s0,8(sp)
 62c:	0141                	addi	sp,sp,16
 62e:	8082                	ret
    n = 0;
 630:	4501                	li	a0,0
 632:	bfe5                	j	62a <atoi+0x3e>

0000000000000634 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 634:	1141                	addi	sp,sp,-16
 636:	e422                	sd	s0,8(sp)
 638:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 63a:	02b57463          	bgeu	a0,a1,662 <memmove+0x2e>
    {
        while (n-- > 0)
 63e:	00c05f63          	blez	a2,65c <memmove+0x28>
 642:	1602                	slli	a2,a2,0x20
 644:	9201                	srli	a2,a2,0x20
 646:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 64a:	872a                	mv	a4,a0
            *dst++ = *src++;
 64c:	0585                	addi	a1,a1,1
 64e:	0705                	addi	a4,a4,1
 650:	fff5c683          	lbu	a3,-1(a1)
 654:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 658:	fee79ae3          	bne	a5,a4,64c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 65c:	6422                	ld	s0,8(sp)
 65e:	0141                	addi	sp,sp,16
 660:	8082                	ret
        dst += n;
 662:	00c50733          	add	a4,a0,a2
        src += n;
 666:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 668:	fec05ae3          	blez	a2,65c <memmove+0x28>
 66c:	fff6079b          	addiw	a5,a2,-1
 670:	1782                	slli	a5,a5,0x20
 672:	9381                	srli	a5,a5,0x20
 674:	fff7c793          	not	a5,a5
 678:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 67a:	15fd                	addi	a1,a1,-1
 67c:	177d                	addi	a4,a4,-1
 67e:	0005c683          	lbu	a3,0(a1)
 682:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 686:	fee79ae3          	bne	a5,a4,67a <memmove+0x46>
 68a:	bfc9                	j	65c <memmove+0x28>

000000000000068c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 68c:	1141                	addi	sp,sp,-16
 68e:	e422                	sd	s0,8(sp)
 690:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 692:	ca05                	beqz	a2,6c2 <memcmp+0x36>
 694:	fff6069b          	addiw	a3,a2,-1
 698:	1682                	slli	a3,a3,0x20
 69a:	9281                	srli	a3,a3,0x20
 69c:	0685                	addi	a3,a3,1
 69e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6a0:	00054783          	lbu	a5,0(a0)
 6a4:	0005c703          	lbu	a4,0(a1)
 6a8:	00e79863          	bne	a5,a4,6b8 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6ac:	0505                	addi	a0,a0,1
        p2++;
 6ae:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6b0:	fed518e3          	bne	a0,a3,6a0 <memcmp+0x14>
    }
    return 0;
 6b4:	4501                	li	a0,0
 6b6:	a019                	j	6bc <memcmp+0x30>
            return *p1 - *p2;
 6b8:	40e7853b          	subw	a0,a5,a4
}
 6bc:	6422                	ld	s0,8(sp)
 6be:	0141                	addi	sp,sp,16
 6c0:	8082                	ret
    return 0;
 6c2:	4501                	li	a0,0
 6c4:	bfe5                	j	6bc <memcmp+0x30>

00000000000006c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6c6:	1141                	addi	sp,sp,-16
 6c8:	e406                	sd	ra,8(sp)
 6ca:	e022                	sd	s0,0(sp)
 6cc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6ce:	00000097          	auipc	ra,0x0
 6d2:	f66080e7          	jalr	-154(ra) # 634 <memmove>
}
 6d6:	60a2                	ld	ra,8(sp)
 6d8:	6402                	ld	s0,0(sp)
 6da:	0141                	addi	sp,sp,16
 6dc:	8082                	ret

00000000000006de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6de:	4885                	li	a7,1
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e6:	4889                	li	a7,2
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ee:	488d                	li	a7,3
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f6:	4891                	li	a7,4
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <read>:
.global read
read:
 li a7, SYS_read
 6fe:	4895                	li	a7,5
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <write>:
.global write
write:
 li a7, SYS_write
 706:	48c1                	li	a7,16
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <close>:
.global close
close:
 li a7, SYS_close
 70e:	48d5                	li	a7,21
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <kill>:
.global kill
kill:
 li a7, SYS_kill
 716:	4899                	li	a7,6
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <exec>:
.global exec
exec:
 li a7, SYS_exec
 71e:	489d                	li	a7,7
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <open>:
.global open
open:
 li a7, SYS_open
 726:	48bd                	li	a7,15
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 72e:	48c5                	li	a7,17
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 736:	48c9                	li	a7,18
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 73e:	48a1                	li	a7,8
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <link>:
.global link
link:
 li a7, SYS_link
 746:	48cd                	li	a7,19
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 74e:	48d1                	li	a7,20
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 756:	48a5                	li	a7,9
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <dup>:
.global dup
dup:
 li a7, SYS_dup
 75e:	48a9                	li	a7,10
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 766:	48ad                	li	a7,11
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 76e:	48b1                	li	a7,12
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 776:	48b5                	li	a7,13
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 77e:	48b9                	li	a7,14
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <ps>:
.global ps
ps:
 li a7, SYS_ps
 786:	48d9                	li	a7,22
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 78e:	48dd                	li	a7,23
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 796:	48e1                	li	a7,24
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 79e:	1101                	addi	sp,sp,-32
 7a0:	ec06                	sd	ra,24(sp)
 7a2:	e822                	sd	s0,16(sp)
 7a4:	1000                	addi	s0,sp,32
 7a6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7aa:	4605                	li	a2,1
 7ac:	fef40593          	addi	a1,s0,-17
 7b0:	00000097          	auipc	ra,0x0
 7b4:	f56080e7          	jalr	-170(ra) # 706 <write>
}
 7b8:	60e2                	ld	ra,24(sp)
 7ba:	6442                	ld	s0,16(sp)
 7bc:	6105                	addi	sp,sp,32
 7be:	8082                	ret

00000000000007c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7c0:	7139                	addi	sp,sp,-64
 7c2:	fc06                	sd	ra,56(sp)
 7c4:	f822                	sd	s0,48(sp)
 7c6:	f426                	sd	s1,40(sp)
 7c8:	f04a                	sd	s2,32(sp)
 7ca:	ec4e                	sd	s3,24(sp)
 7cc:	0080                	addi	s0,sp,64
 7ce:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7d0:	c299                	beqz	a3,7d6 <printint+0x16>
 7d2:	0805c963          	bltz	a1,864 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7d6:	2581                	sext.w	a1,a1
  neg = 0;
 7d8:	4881                	li	a7,0
 7da:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7de:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7e0:	2601                	sext.w	a2,a2
 7e2:	00000517          	auipc	a0,0x0
 7e6:	5ae50513          	addi	a0,a0,1454 # d90 <digits>
 7ea:	883a                	mv	a6,a4
 7ec:	2705                	addiw	a4,a4,1
 7ee:	02c5f7bb          	remuw	a5,a1,a2
 7f2:	1782                	slli	a5,a5,0x20
 7f4:	9381                	srli	a5,a5,0x20
 7f6:	97aa                	add	a5,a5,a0
 7f8:	0007c783          	lbu	a5,0(a5)
 7fc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 800:	0005879b          	sext.w	a5,a1
 804:	02c5d5bb          	divuw	a1,a1,a2
 808:	0685                	addi	a3,a3,1
 80a:	fec7f0e3          	bgeu	a5,a2,7ea <printint+0x2a>
  if(neg)
 80e:	00088c63          	beqz	a7,826 <printint+0x66>
    buf[i++] = '-';
 812:	fd070793          	addi	a5,a4,-48
 816:	00878733          	add	a4,a5,s0
 81a:	02d00793          	li	a5,45
 81e:	fef70823          	sb	a5,-16(a4)
 822:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 826:	02e05863          	blez	a4,856 <printint+0x96>
 82a:	fc040793          	addi	a5,s0,-64
 82e:	00e78933          	add	s2,a5,a4
 832:	fff78993          	addi	s3,a5,-1
 836:	99ba                	add	s3,s3,a4
 838:	377d                	addiw	a4,a4,-1
 83a:	1702                	slli	a4,a4,0x20
 83c:	9301                	srli	a4,a4,0x20
 83e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 842:	fff94583          	lbu	a1,-1(s2)
 846:	8526                	mv	a0,s1
 848:	00000097          	auipc	ra,0x0
 84c:	f56080e7          	jalr	-170(ra) # 79e <putc>
  while(--i >= 0)
 850:	197d                	addi	s2,s2,-1
 852:	ff3918e3          	bne	s2,s3,842 <printint+0x82>
}
 856:	70e2                	ld	ra,56(sp)
 858:	7442                	ld	s0,48(sp)
 85a:	74a2                	ld	s1,40(sp)
 85c:	7902                	ld	s2,32(sp)
 85e:	69e2                	ld	s3,24(sp)
 860:	6121                	addi	sp,sp,64
 862:	8082                	ret
    x = -xx;
 864:	40b005bb          	negw	a1,a1
    neg = 1;
 868:	4885                	li	a7,1
    x = -xx;
 86a:	bf85                	j	7da <printint+0x1a>

000000000000086c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 86c:	715d                	addi	sp,sp,-80
 86e:	e486                	sd	ra,72(sp)
 870:	e0a2                	sd	s0,64(sp)
 872:	fc26                	sd	s1,56(sp)
 874:	f84a                	sd	s2,48(sp)
 876:	f44e                	sd	s3,40(sp)
 878:	f052                	sd	s4,32(sp)
 87a:	ec56                	sd	s5,24(sp)
 87c:	e85a                	sd	s6,16(sp)
 87e:	e45e                	sd	s7,8(sp)
 880:	e062                	sd	s8,0(sp)
 882:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 884:	0005c903          	lbu	s2,0(a1)
 888:	18090c63          	beqz	s2,a20 <vprintf+0x1b4>
 88c:	8aaa                	mv	s5,a0
 88e:	8bb2                	mv	s7,a2
 890:	00158493          	addi	s1,a1,1
  state = 0;
 894:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 896:	02500a13          	li	s4,37
 89a:	4b55                	li	s6,21
 89c:	a839                	j	8ba <vprintf+0x4e>
        putc(fd, c);
 89e:	85ca                	mv	a1,s2
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	efc080e7          	jalr	-260(ra) # 79e <putc>
 8aa:	a019                	j	8b0 <vprintf+0x44>
    } else if(state == '%'){
 8ac:	01498d63          	beq	s3,s4,8c6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8b0:	0485                	addi	s1,s1,1
 8b2:	fff4c903          	lbu	s2,-1(s1)
 8b6:	16090563          	beqz	s2,a20 <vprintf+0x1b4>
    if(state == 0){
 8ba:	fe0999e3          	bnez	s3,8ac <vprintf+0x40>
      if(c == '%'){
 8be:	ff4910e3          	bne	s2,s4,89e <vprintf+0x32>
        state = '%';
 8c2:	89d2                	mv	s3,s4
 8c4:	b7f5                	j	8b0 <vprintf+0x44>
      if(c == 'd'){
 8c6:	13490263          	beq	s2,s4,9ea <vprintf+0x17e>
 8ca:	f9d9079b          	addiw	a5,s2,-99
 8ce:	0ff7f793          	zext.b	a5,a5
 8d2:	12fb6563          	bltu	s6,a5,9fc <vprintf+0x190>
 8d6:	f9d9079b          	addiw	a5,s2,-99
 8da:	0ff7f713          	zext.b	a4,a5
 8de:	10eb6f63          	bltu	s6,a4,9fc <vprintf+0x190>
 8e2:	00271793          	slli	a5,a4,0x2
 8e6:	00000717          	auipc	a4,0x0
 8ea:	45270713          	addi	a4,a4,1106 # d38 <malloc+0x21a>
 8ee:	97ba                	add	a5,a5,a4
 8f0:	439c                	lw	a5,0(a5)
 8f2:	97ba                	add	a5,a5,a4
 8f4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8f6:	008b8913          	addi	s2,s7,8
 8fa:	4685                	li	a3,1
 8fc:	4629                	li	a2,10
 8fe:	000ba583          	lw	a1,0(s7)
 902:	8556                	mv	a0,s5
 904:	00000097          	auipc	ra,0x0
 908:	ebc080e7          	jalr	-324(ra) # 7c0 <printint>
 90c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 90e:	4981                	li	s3,0
 910:	b745                	j	8b0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 912:	008b8913          	addi	s2,s7,8
 916:	4681                	li	a3,0
 918:	4629                	li	a2,10
 91a:	000ba583          	lw	a1,0(s7)
 91e:	8556                	mv	a0,s5
 920:	00000097          	auipc	ra,0x0
 924:	ea0080e7          	jalr	-352(ra) # 7c0 <printint>
 928:	8bca                	mv	s7,s2
      state = 0;
 92a:	4981                	li	s3,0
 92c:	b751                	j	8b0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 92e:	008b8913          	addi	s2,s7,8
 932:	4681                	li	a3,0
 934:	4641                	li	a2,16
 936:	000ba583          	lw	a1,0(s7)
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	e84080e7          	jalr	-380(ra) # 7c0 <printint>
 944:	8bca                	mv	s7,s2
      state = 0;
 946:	4981                	li	s3,0
 948:	b7a5                	j	8b0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 94a:	008b8c13          	addi	s8,s7,8
 94e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 952:	03000593          	li	a1,48
 956:	8556                	mv	a0,s5
 958:	00000097          	auipc	ra,0x0
 95c:	e46080e7          	jalr	-442(ra) # 79e <putc>
  putc(fd, 'x');
 960:	07800593          	li	a1,120
 964:	8556                	mv	a0,s5
 966:	00000097          	auipc	ra,0x0
 96a:	e38080e7          	jalr	-456(ra) # 79e <putc>
 96e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 970:	00000b97          	auipc	s7,0x0
 974:	420b8b93          	addi	s7,s7,1056 # d90 <digits>
 978:	03c9d793          	srli	a5,s3,0x3c
 97c:	97de                	add	a5,a5,s7
 97e:	0007c583          	lbu	a1,0(a5)
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	e1a080e7          	jalr	-486(ra) # 79e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 98c:	0992                	slli	s3,s3,0x4
 98e:	397d                	addiw	s2,s2,-1
 990:	fe0914e3          	bnez	s2,978 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 994:	8be2                	mv	s7,s8
      state = 0;
 996:	4981                	li	s3,0
 998:	bf21                	j	8b0 <vprintf+0x44>
        s = va_arg(ap, char*);
 99a:	008b8993          	addi	s3,s7,8
 99e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9a2:	02090163          	beqz	s2,9c4 <vprintf+0x158>
        while(*s != 0){
 9a6:	00094583          	lbu	a1,0(s2)
 9aa:	c9a5                	beqz	a1,a1a <vprintf+0x1ae>
          putc(fd, *s);
 9ac:	8556                	mv	a0,s5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	df0080e7          	jalr	-528(ra) # 79e <putc>
          s++;
 9b6:	0905                	addi	s2,s2,1
        while(*s != 0){
 9b8:	00094583          	lbu	a1,0(s2)
 9bc:	f9e5                	bnez	a1,9ac <vprintf+0x140>
        s = va_arg(ap, char*);
 9be:	8bce                	mv	s7,s3
      state = 0;
 9c0:	4981                	li	s3,0
 9c2:	b5fd                	j	8b0 <vprintf+0x44>
          s = "(null)";
 9c4:	00000917          	auipc	s2,0x0
 9c8:	36c90913          	addi	s2,s2,876 # d30 <malloc+0x212>
        while(*s != 0){
 9cc:	02800593          	li	a1,40
 9d0:	bff1                	j	9ac <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9d2:	008b8913          	addi	s2,s7,8
 9d6:	000bc583          	lbu	a1,0(s7)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	dc2080e7          	jalr	-574(ra) # 79e <putc>
 9e4:	8bca                	mv	s7,s2
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	b5e1                	j	8b0 <vprintf+0x44>
        putc(fd, c);
 9ea:	02500593          	li	a1,37
 9ee:	8556                	mv	a0,s5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	dae080e7          	jalr	-594(ra) # 79e <putc>
      state = 0;
 9f8:	4981                	li	s3,0
 9fa:	bd5d                	j	8b0 <vprintf+0x44>
        putc(fd, '%');
 9fc:	02500593          	li	a1,37
 a00:	8556                	mv	a0,s5
 a02:	00000097          	auipc	ra,0x0
 a06:	d9c080e7          	jalr	-612(ra) # 79e <putc>
        putc(fd, c);
 a0a:	85ca                	mv	a1,s2
 a0c:	8556                	mv	a0,s5
 a0e:	00000097          	auipc	ra,0x0
 a12:	d90080e7          	jalr	-624(ra) # 79e <putc>
      state = 0;
 a16:	4981                	li	s3,0
 a18:	bd61                	j	8b0 <vprintf+0x44>
        s = va_arg(ap, char*);
 a1a:	8bce                	mv	s7,s3
      state = 0;
 a1c:	4981                	li	s3,0
 a1e:	bd49                	j	8b0 <vprintf+0x44>
    }
  }
}
 a20:	60a6                	ld	ra,72(sp)
 a22:	6406                	ld	s0,64(sp)
 a24:	74e2                	ld	s1,56(sp)
 a26:	7942                	ld	s2,48(sp)
 a28:	79a2                	ld	s3,40(sp)
 a2a:	7a02                	ld	s4,32(sp)
 a2c:	6ae2                	ld	s5,24(sp)
 a2e:	6b42                	ld	s6,16(sp)
 a30:	6ba2                	ld	s7,8(sp)
 a32:	6c02                	ld	s8,0(sp)
 a34:	6161                	addi	sp,sp,80
 a36:	8082                	ret

0000000000000a38 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a38:	715d                	addi	sp,sp,-80
 a3a:	ec06                	sd	ra,24(sp)
 a3c:	e822                	sd	s0,16(sp)
 a3e:	1000                	addi	s0,sp,32
 a40:	e010                	sd	a2,0(s0)
 a42:	e414                	sd	a3,8(s0)
 a44:	e818                	sd	a4,16(s0)
 a46:	ec1c                	sd	a5,24(s0)
 a48:	03043023          	sd	a6,32(s0)
 a4c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a50:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a54:	8622                	mv	a2,s0
 a56:	00000097          	auipc	ra,0x0
 a5a:	e16080e7          	jalr	-490(ra) # 86c <vprintf>
}
 a5e:	60e2                	ld	ra,24(sp)
 a60:	6442                	ld	s0,16(sp)
 a62:	6161                	addi	sp,sp,80
 a64:	8082                	ret

0000000000000a66 <printf>:

void
printf(const char *fmt, ...)
{
 a66:	711d                	addi	sp,sp,-96
 a68:	ec06                	sd	ra,24(sp)
 a6a:	e822                	sd	s0,16(sp)
 a6c:	1000                	addi	s0,sp,32
 a6e:	e40c                	sd	a1,8(s0)
 a70:	e810                	sd	a2,16(s0)
 a72:	ec14                	sd	a3,24(s0)
 a74:	f018                	sd	a4,32(s0)
 a76:	f41c                	sd	a5,40(s0)
 a78:	03043823          	sd	a6,48(s0)
 a7c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a80:	00840613          	addi	a2,s0,8
 a84:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a88:	85aa                	mv	a1,a0
 a8a:	4505                	li	a0,1
 a8c:	00000097          	auipc	ra,0x0
 a90:	de0080e7          	jalr	-544(ra) # 86c <vprintf>
}
 a94:	60e2                	ld	ra,24(sp)
 a96:	6442                	ld	s0,16(sp)
 a98:	6125                	addi	sp,sp,96
 a9a:	8082                	ret

0000000000000a9c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a9c:	1141                	addi	sp,sp,-16
 a9e:	e422                	sd	s0,8(sp)
 aa0:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aa2:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa6:	00000797          	auipc	a5,0x0
 aaa:	5727b783          	ld	a5,1394(a5) # 1018 <freep>
 aae:	a02d                	j	ad8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ab0:	4618                	lw	a4,8(a2)
 ab2:	9f2d                	addw	a4,a4,a1
 ab4:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ab8:	6398                	ld	a4,0(a5)
 aba:	6310                	ld	a2,0(a4)
 abc:	a83d                	j	afa <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 abe:	ff852703          	lw	a4,-8(a0)
 ac2:	9f31                	addw	a4,a4,a2
 ac4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ac6:	ff053683          	ld	a3,-16(a0)
 aca:	a091                	j	b0e <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 acc:	6398                	ld	a4,0(a5)
 ace:	00e7e463          	bltu	a5,a4,ad6 <free+0x3a>
 ad2:	00e6ea63          	bltu	a3,a4,ae6 <free+0x4a>
{
 ad6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad8:	fed7fae3          	bgeu	a5,a3,acc <free+0x30>
 adc:	6398                	ld	a4,0(a5)
 ade:	00e6e463          	bltu	a3,a4,ae6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae2:	fee7eae3          	bltu	a5,a4,ad6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ae6:	ff852583          	lw	a1,-8(a0)
 aea:	6390                	ld	a2,0(a5)
 aec:	02059813          	slli	a6,a1,0x20
 af0:	01c85713          	srli	a4,a6,0x1c
 af4:	9736                	add	a4,a4,a3
 af6:	fae60de3          	beq	a2,a4,ab0 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 afa:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 afe:	4790                	lw	a2,8(a5)
 b00:	02061593          	slli	a1,a2,0x20
 b04:	01c5d713          	srli	a4,a1,0x1c
 b08:	973e                	add	a4,a4,a5
 b0a:	fae68ae3          	beq	a3,a4,abe <free+0x22>
        p->s.ptr = bp->s.ptr;
 b0e:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b10:	00000717          	auipc	a4,0x0
 b14:	50f73423          	sd	a5,1288(a4) # 1018 <freep>
}
 b18:	6422                	ld	s0,8(sp)
 b1a:	0141                	addi	sp,sp,16
 b1c:	8082                	ret

0000000000000b1e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b1e:	7139                	addi	sp,sp,-64
 b20:	fc06                	sd	ra,56(sp)
 b22:	f822                	sd	s0,48(sp)
 b24:	f426                	sd	s1,40(sp)
 b26:	f04a                	sd	s2,32(sp)
 b28:	ec4e                	sd	s3,24(sp)
 b2a:	e852                	sd	s4,16(sp)
 b2c:	e456                	sd	s5,8(sp)
 b2e:	e05a                	sd	s6,0(sp)
 b30:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b32:	02051493          	slli	s1,a0,0x20
 b36:	9081                	srli	s1,s1,0x20
 b38:	04bd                	addi	s1,s1,15
 b3a:	8091                	srli	s1,s1,0x4
 b3c:	0014899b          	addiw	s3,s1,1
 b40:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b42:	00000517          	auipc	a0,0x0
 b46:	4d653503          	ld	a0,1238(a0) # 1018 <freep>
 b4a:	c515                	beqz	a0,b76 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b4c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b4e:	4798                	lw	a4,8(a5)
 b50:	02977f63          	bgeu	a4,s1,b8e <malloc+0x70>
    if (nu < 4096)
 b54:	8a4e                	mv	s4,s3
 b56:	0009871b          	sext.w	a4,s3
 b5a:	6685                	lui	a3,0x1
 b5c:	00d77363          	bgeu	a4,a3,b62 <malloc+0x44>
 b60:	6a05                	lui	s4,0x1
 b62:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b66:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b6a:	00000917          	auipc	s2,0x0
 b6e:	4ae90913          	addi	s2,s2,1198 # 1018 <freep>
    if (p == (char *)-1)
 b72:	5afd                	li	s5,-1
 b74:	a895                	j	be8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b76:	00000797          	auipc	a5,0x0
 b7a:	52a78793          	addi	a5,a5,1322 # 10a0 <base>
 b7e:	00000717          	auipc	a4,0x0
 b82:	48f73d23          	sd	a5,1178(a4) # 1018 <freep>
 b86:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b88:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b8c:	b7e1                	j	b54 <malloc+0x36>
            if (p->s.size == nunits)
 b8e:	02e48c63          	beq	s1,a4,bc6 <malloc+0xa8>
                p->s.size -= nunits;
 b92:	4137073b          	subw	a4,a4,s3
 b96:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b98:	02071693          	slli	a3,a4,0x20
 b9c:	01c6d713          	srli	a4,a3,0x1c
 ba0:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 ba2:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 ba6:	00000717          	auipc	a4,0x0
 baa:	46a73923          	sd	a0,1138(a4) # 1018 <freep>
            return (void *)(p + 1);
 bae:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bb2:	70e2                	ld	ra,56(sp)
 bb4:	7442                	ld	s0,48(sp)
 bb6:	74a2                	ld	s1,40(sp)
 bb8:	7902                	ld	s2,32(sp)
 bba:	69e2                	ld	s3,24(sp)
 bbc:	6a42                	ld	s4,16(sp)
 bbe:	6aa2                	ld	s5,8(sp)
 bc0:	6b02                	ld	s6,0(sp)
 bc2:	6121                	addi	sp,sp,64
 bc4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bc6:	6398                	ld	a4,0(a5)
 bc8:	e118                	sd	a4,0(a0)
 bca:	bff1                	j	ba6 <malloc+0x88>
    hp->s.size = nu;
 bcc:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bd0:	0541                	addi	a0,a0,16
 bd2:	00000097          	auipc	ra,0x0
 bd6:	eca080e7          	jalr	-310(ra) # a9c <free>
    return freep;
 bda:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bde:	d971                	beqz	a0,bb2 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 be0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 be2:	4798                	lw	a4,8(a5)
 be4:	fa9775e3          	bgeu	a4,s1,b8e <malloc+0x70>
        if (p == freep)
 be8:	00093703          	ld	a4,0(s2)
 bec:	853e                	mv	a0,a5
 bee:	fef719e3          	bne	a4,a5,be0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bf2:	8552                	mv	a0,s4
 bf4:	00000097          	auipc	ra,0x0
 bf8:	b7a080e7          	jalr	-1158(ra) # 76e <sbrk>
    if (p == (char *)-1)
 bfc:	fd5518e3          	bne	a0,s5,bcc <malloc+0xae>
                return 0;
 c00:	4501                	li	a0,0
 c02:	bf45                	j	bb2 <malloc+0x94>
