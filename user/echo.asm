
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
  34:	c40a8a93          	addi	s5,s5,-960 # c70 <malloc+0xee>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	72a080e7          	jalr	1834(ra) # 76a <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	4d2080e7          	jalr	1234(ra) # 526 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	706080e7          	jalr	1798(ra) # 76a <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	cbe58593          	addi	a1,a1,-834 # d30 <malloc+0x1ae>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	6ee080e7          	jalr	1774(ra) # 76a <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	6c4080e7          	jalr	1732(ra) # 74a <exit>

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
  c2:	2dc080e7          	jalr	732(ra) # 39a <twhoami>
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
 10e:	b6e50513          	addi	a0,a0,-1170 # c78 <malloc+0xf6>
 112:	00001097          	auipc	ra,0x1
 116:	9b8080e7          	jalr	-1608(ra) # aca <printf>
        exit(-1);
 11a:	557d                	li	a0,-1
 11c:	00000097          	auipc	ra,0x0
 120:	62e080e7          	jalr	1582(ra) # 74a <exit>
    {
        // give up the cpu for other threads
        tyield();
 124:	00000097          	auipc	ra,0x0
 128:	252080e7          	jalr	594(ra) # 376 <tyield>
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
 142:	25c080e7          	jalr	604(ra) # 39a <twhoami>
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
 186:	1f4080e7          	jalr	500(ra) # 376 <tyield>
}
 18a:	60e2                	ld	ra,24(sp)
 18c:	6442                	ld	s0,16(sp)
 18e:	64a2                	ld	s1,8(sp)
 190:	6105                	addi	sp,sp,32
 192:	8082                	ret
        printf("releasing lock we are not holding");
 194:	00001517          	auipc	a0,0x1
 198:	b0c50513          	addi	a0,a0,-1268 # ca0 <malloc+0x11e>
 19c:	00001097          	auipc	ra,0x1
 1a0:	92e080e7          	jalr	-1746(ra) # aca <printf>
        exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	5a4080e7          	jalr	1444(ra) # 74a <exit>

00000000000001ae <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 1ae:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1b0:	00001617          	auipc	a2,0x1
 1b4:	e7060613          	addi	a2,a2,-400 # 1020 <threads>
 1b8:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 1ba:	45c1                	li	a1,16
 1bc:	a021                	j	1c4 <tsched+0x16>
 1be:	2685                	addiw	a3,a3,1
 1c0:	08b68c63          	beq	a3,a1,258 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 1c4:	41f6d71b          	sraiw	a4,a3,0x1f
 1c8:	01c7571b          	srliw	a4,a4,0x1c
 1cc:	00d707bb          	addw	a5,a4,a3
 1d0:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1d2:	9f99                	subw	a5,a5,a4
 1d4:	078e                	slli	a5,a5,0x3
 1d6:	97b2                	add	a5,a5,a2
 1d8:	639c                	ld	a5,0(a5)
 1da:	d3f5                	beqz	a5,1be <tsched+0x10>
 1dc:	5fb8                	lw	a4,120(a5)
 1de:	fea710e3          	bne	a4,a0,1be <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1e2:	00001717          	auipc	a4,0x1
 1e6:	e3e73703          	ld	a4,-450(a4) # 1020 <threads>
 1ea:	5f30                	lw	a2,120(a4)
 1ec:	468d                	li	a3,3
 1ee:	06d60363          	beq	a2,a3,254 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1f2:	c3a5                	beqz	a5,252 <tsched+0xa4>
{
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e426                	sd	s1,8(sp)
 1fc:	e04a                	sd	s2,0(sp)
 1fe:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 200:	00001497          	auipc	s1,0x1
 204:	e1048493          	addi	s1,s1,-496 # 1010 <current_thread>
 208:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 20c:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 20e:	0007c603          	lbu	a2,0(a5)
 212:	00094583          	lbu	a1,0(s2)
 216:	00001517          	auipc	a0,0x1
 21a:	ab250513          	addi	a0,a0,-1358 # cc8 <malloc+0x146>
 21e:	00001097          	auipc	ra,0x1
 222:	8ac080e7          	jalr	-1876(ra) # aca <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 226:	608c                	ld	a1,0(s1)
 228:	05a1                	addi	a1,a1,8
 22a:	00890513          	addi	a0,s2,8
 22e:	00000097          	auipc	ra,0x0
 232:	184080e7          	jalr	388(ra) # 3b2 <tswtch>
        printf("Thread switch complete\n");
 236:	00001517          	auipc	a0,0x1
 23a:	aba50513          	addi	a0,a0,-1350 # cf0 <malloc+0x16e>
 23e:	00001097          	auipc	ra,0x1
 242:	88c080e7          	jalr	-1908(ra) # aca <printf>
    }
}
 246:	60e2                	ld	ra,24(sp)
 248:	6442                	ld	s0,16(sp)
 24a:	64a2                	ld	s1,8(sp)
 24c:	6902                	ld	s2,0(sp)
 24e:	6105                	addi	sp,sp,32
 250:	8082                	ret
 252:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 254:	87ba                	mv	a5,a4
 256:	bf79                	j	1f4 <tsched+0x46>
 258:	00001797          	auipc	a5,0x1
 25c:	dc87b783          	ld	a5,-568(a5) # 1020 <threads>
 260:	5fb4                	lw	a3,120(a5)
 262:	470d                	li	a4,3
 264:	f8e688e3          	beq	a3,a4,1f4 <tsched+0x46>
 268:	8082                	ret

000000000000026a <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 26a:	7179                	addi	sp,sp,-48
 26c:	f406                	sd	ra,40(sp)
 26e:	f022                	sd	s0,32(sp)
 270:	ec26                	sd	s1,24(sp)
 272:	e84a                	sd	s2,16(sp)
 274:	e44e                	sd	s3,8(sp)
 276:	1800                	addi	s0,sp,48
 278:	84aa                	mv	s1,a0
 27a:	89b2                	mv	s3,a2
 27c:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 27e:	09000513          	li	a0,144
 282:	00001097          	auipc	ra,0x1
 286:	900080e7          	jalr	-1792(ra) # b82 <malloc>
 28a:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 28c:	478d                	li	a5,3
 28e:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 290:	609c                	ld	a5,0(s1)
 292:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 296:	609c                	ld	a5,0(s1)
 298:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 29c:	00001717          	auipc	a4,0x1
 2a0:	d6470713          	addi	a4,a4,-668 # 1000 <next_tid>
 2a4:	431c                	lw	a5,0(a4)
 2a6:	0017869b          	addiw	a3,a5,1
 2aa:	c314                	sw	a3,0(a4)
 2ac:	6098                	ld	a4,0(s1)
 2ae:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 2b2:	00001717          	auipc	a4,0x1
 2b6:	d6e70713          	addi	a4,a4,-658 # 1020 <threads>
 2ba:	4781                	li	a5,0
 2bc:	4641                	li	a2,16
    if (threads[i] == NULL) {
 2be:	6314                	ld	a3,0(a4)
 2c0:	ce81                	beqz	a3,2d8 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 2c2:	2785                	addiw	a5,a5,1
 2c4:	0721                	addi	a4,a4,8
 2c6:	fec79ce3          	bne	a5,a2,2be <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 2ca:	70a2                	ld	ra,40(sp)
 2cc:	7402                	ld	s0,32(sp)
 2ce:	64e2                	ld	s1,24(sp)
 2d0:	6942                	ld	s2,16(sp)
 2d2:	69a2                	ld	s3,8(sp)
 2d4:	6145                	addi	sp,sp,48
 2d6:	8082                	ret
        threads[i] = *thread;
 2d8:	6094                	ld	a3,0(s1)
 2da:	078e                	slli	a5,a5,0x3
 2dc:	00001717          	auipc	a4,0x1
 2e0:	d4470713          	addi	a4,a4,-700 # 1020 <threads>
 2e4:	97ba                	add	a5,a5,a4
 2e6:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2e8:	0006c583          	lbu	a1,0(a3)
 2ec:	00001517          	auipc	a0,0x1
 2f0:	a1c50513          	addi	a0,a0,-1508 # d08 <malloc+0x186>
 2f4:	00000097          	auipc	ra,0x0
 2f8:	7d6080e7          	jalr	2006(ra) # aca <printf>
        break;
 2fc:	b7f9                	j	2ca <tcreate+0x60>

00000000000002fe <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2fe:	7179                	addi	sp,sp,-48
 300:	f406                	sd	ra,40(sp)
 302:	f022                	sd	s0,32(sp)
 304:	ec26                	sd	s1,24(sp)
 306:	e84a                	sd	s2,16(sp)
 308:	e44e                	sd	s3,8(sp)
 30a:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 30c:	00001797          	auipc	a5,0x1
 310:	d1478793          	addi	a5,a5,-748 # 1020 <threads>
 314:	00001697          	auipc	a3,0x1
 318:	d8c68693          	addi	a3,a3,-628 # 10a0 <base>
 31c:	a021                	j	324 <tjoin+0x26>
 31e:	07a1                	addi	a5,a5,8
 320:	04d78763          	beq	a5,a3,36e <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 324:	6384                	ld	s1,0(a5)
 326:	dce5                	beqz	s1,31e <tjoin+0x20>
 328:	0004c703          	lbu	a4,0(s1)
 32c:	fea719e3          	bne	a4,a0,31e <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 330:	5cb8                	lw	a4,120(s1)
 332:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 334:	00001997          	auipc	s3,0x1
 338:	a0498993          	addi	s3,s3,-1532 # d38 <malloc+0x1b6>
    while (target_thread->state != EXITED) {
 33c:	4919                	li	s2,6
 33e:	02f70a63          	beq	a4,a5,372 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 342:	0004c583          	lbu	a1,0(s1)
 346:	854e                	mv	a0,s3
 348:	00000097          	auipc	ra,0x0
 34c:	782080e7          	jalr	1922(ra) # aca <printf>
        tsched();
 350:	00000097          	auipc	ra,0x0
 354:	e5e080e7          	jalr	-418(ra) # 1ae <tsched>
    while (target_thread->state != EXITED) {
 358:	5cbc                	lw	a5,120(s1)
 35a:	ff2794e3          	bne	a5,s2,342 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 35e:	4501                	li	a0,0
}
 360:	70a2                	ld	ra,40(sp)
 362:	7402                	ld	s0,32(sp)
 364:	64e2                	ld	s1,24(sp)
 366:	6942                	ld	s2,16(sp)
 368:	69a2                	ld	s3,8(sp)
 36a:	6145                	addi	sp,sp,48
 36c:	8082                	ret
        return -1;
 36e:	557d                	li	a0,-1
 370:	bfc5                	j	360 <tjoin+0x62>
    return 0;
 372:	4501                	li	a0,0
 374:	b7f5                	j	360 <tjoin+0x62>

0000000000000376 <tyield>:


void tyield()
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 37e:	00001797          	auipc	a5,0x1
 382:	c927b783          	ld	a5,-878(a5) # 1010 <current_thread>
 386:	470d                	li	a4,3
 388:	dfb8                	sw	a4,120(a5)
    tsched();
 38a:	00000097          	auipc	ra,0x0
 38e:	e24080e7          	jalr	-476(ra) # 1ae <tsched>
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <twhoami>:

uint8 twhoami()
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 3a0:	00001797          	auipc	a5,0x1
 3a4:	c707b783          	ld	a5,-912(a5) # 1010 <current_thread>
 3a8:	0007c503          	lbu	a0,0(a5)
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	addi	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <tswtch>:
 3b2:	00153023          	sd	ra,0(a0)
 3b6:	00253423          	sd	sp,8(a0)
 3ba:	e900                	sd	s0,16(a0)
 3bc:	ed04                	sd	s1,24(a0)
 3be:	03253023          	sd	s2,32(a0)
 3c2:	03353423          	sd	s3,40(a0)
 3c6:	03453823          	sd	s4,48(a0)
 3ca:	03553c23          	sd	s5,56(a0)
 3ce:	05653023          	sd	s6,64(a0)
 3d2:	05753423          	sd	s7,72(a0)
 3d6:	05853823          	sd	s8,80(a0)
 3da:	05953c23          	sd	s9,88(a0)
 3de:	07a53023          	sd	s10,96(a0)
 3e2:	07b53423          	sd	s11,104(a0)
 3e6:	0005b083          	ld	ra,0(a1)
 3ea:	0085b103          	ld	sp,8(a1)
 3ee:	6980                	ld	s0,16(a1)
 3f0:	6d84                	ld	s1,24(a1)
 3f2:	0205b903          	ld	s2,32(a1)
 3f6:	0285b983          	ld	s3,40(a1)
 3fa:	0305ba03          	ld	s4,48(a1)
 3fe:	0385ba83          	ld	s5,56(a1)
 402:	0405bb03          	ld	s6,64(a1)
 406:	0485bb83          	ld	s7,72(a1)
 40a:	0505bc03          	ld	s8,80(a1)
 40e:	0585bc83          	ld	s9,88(a1)
 412:	0605bd03          	ld	s10,96(a1)
 416:	0685bd83          	ld	s11,104(a1)
 41a:	8082                	ret

000000000000041c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 41c:	715d                	addi	sp,sp,-80
 41e:	e486                	sd	ra,72(sp)
 420:	e0a2                	sd	s0,64(sp)
 422:	fc26                	sd	s1,56(sp)
 424:	f84a                	sd	s2,48(sp)
 426:	f44e                	sd	s3,40(sp)
 428:	f052                	sd	s4,32(sp)
 42a:	ec56                	sd	s5,24(sp)
 42c:	e85a                	sd	s6,16(sp)
 42e:	e45e                	sd	s7,8(sp)
 430:	0880                	addi	s0,sp,80
 432:	892a                	mv	s2,a0
 434:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 436:	00001517          	auipc	a0,0x1
 43a:	92250513          	addi	a0,a0,-1758 # d58 <malloc+0x1d6>
 43e:	00000097          	auipc	ra,0x0
 442:	68c080e7          	jalr	1676(ra) # aca <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 446:	09000513          	li	a0,144
 44a:	00000097          	auipc	ra,0x0
 44e:	738080e7          	jalr	1848(ra) # b82 <malloc>

    main_thread->tid = 0;
 452:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 456:	4791                	li	a5,4
 458:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 45a:	00001797          	auipc	a5,0x1
 45e:	baa7bb23          	sd	a0,-1098(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 462:	00001a17          	auipc	s4,0x1
 466:	bbea0a13          	addi	s4,s4,-1090 # 1020 <threads>
 46a:	00001497          	auipc	s1,0x1
 46e:	c3648493          	addi	s1,s1,-970 # 10a0 <base>
    current_thread = main_thread;
 472:	87d2                	mv	a5,s4
        threads[i] = NULL;
 474:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 478:	07a1                	addi	a5,a5,8
 47a:	fe979de3          	bne	a5,s1,474 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 47e:	00001797          	auipc	a5,0x1
 482:	baa7b123          	sd	a0,-1118(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 486:	85ce                	mv	a1,s3
 488:	854a                	mv	a0,s2
 48a:	00000097          	auipc	ra,0x0
 48e:	b76080e7          	jalr	-1162(ra) # 0 <main>
 492:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 494:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 496:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 498:	00001a97          	auipc	s5,0x1
 49c:	8e0a8a93          	addi	s5,s5,-1824 # d78 <malloc+0x1f6>
 4a0:	a03d                	j	4ce <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 4a2:	07a1                	addi	a5,a5,8
 4a4:	00978963          	beq	a5,s1,4b6 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 4a8:	6398                	ld	a4,0(a5)
 4aa:	df65                	beqz	a4,4a2 <_main+0x86>
 4ac:	5f38                	lw	a4,120(a4)
 4ae:	ff370ae3          	beq	a4,s3,4a2 <_main+0x86>
                running_threads++;
 4b2:	2905                	addiw	s2,s2,1
 4b4:	b7fd                	j	4a2 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 4b6:	85ca                	mv	a1,s2
 4b8:	8556                	mv	a0,s5
 4ba:	00000097          	auipc	ra,0x0
 4be:	610080e7          	jalr	1552(ra) # aca <printf>
        if (running_threads > 0) {
 4c2:	01205963          	blez	s2,4d4 <_main+0xb8>
            tsched(); // Schedule another thread to run
 4c6:	00000097          	auipc	ra,0x0
 4ca:	ce8080e7          	jalr	-792(ra) # 1ae <tsched>
    current_thread = main_thread;
 4ce:	87d2                	mv	a5,s4
        running_threads = 0;
 4d0:	895a                	mv	s2,s6
 4d2:	bfd9                	j	4a8 <_main+0x8c>
        }
    }

    exit(res);
 4d4:	855e                	mv	a0,s7
 4d6:	00000097          	auipc	ra,0x0
 4da:	274080e7          	jalr	628(ra) # 74a <exit>

00000000000004de <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4e4:	87aa                	mv	a5,a0
 4e6:	0585                	addi	a1,a1,1
 4e8:	0785                	addi	a5,a5,1
 4ea:	fff5c703          	lbu	a4,-1(a1)
 4ee:	fee78fa3          	sb	a4,-1(a5)
 4f2:	fb75                	bnez	a4,4e6 <strcpy+0x8>
        ;
    return os;
}
 4f4:	6422                	ld	s0,8(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret

00000000000004fa <strcmp>:

int strcmp(const char *p, const char *q)
{
 4fa:	1141                	addi	sp,sp,-16
 4fc:	e422                	sd	s0,8(sp)
 4fe:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 500:	00054783          	lbu	a5,0(a0)
 504:	cb91                	beqz	a5,518 <strcmp+0x1e>
 506:	0005c703          	lbu	a4,0(a1)
 50a:	00f71763          	bne	a4,a5,518 <strcmp+0x1e>
        p++, q++;
 50e:	0505                	addi	a0,a0,1
 510:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 512:	00054783          	lbu	a5,0(a0)
 516:	fbe5                	bnez	a5,506 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 518:	0005c503          	lbu	a0,0(a1)
}
 51c:	40a7853b          	subw	a0,a5,a0
 520:	6422                	ld	s0,8(sp)
 522:	0141                	addi	sp,sp,16
 524:	8082                	ret

0000000000000526 <strlen>:

uint strlen(const char *s)
{
 526:	1141                	addi	sp,sp,-16
 528:	e422                	sd	s0,8(sp)
 52a:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 52c:	00054783          	lbu	a5,0(a0)
 530:	cf91                	beqz	a5,54c <strlen+0x26>
 532:	0505                	addi	a0,a0,1
 534:	87aa                	mv	a5,a0
 536:	86be                	mv	a3,a5
 538:	0785                	addi	a5,a5,1
 53a:	fff7c703          	lbu	a4,-1(a5)
 53e:	ff65                	bnez	a4,536 <strlen+0x10>
 540:	40a6853b          	subw	a0,a3,a0
 544:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 546:	6422                	ld	s0,8(sp)
 548:	0141                	addi	sp,sp,16
 54a:	8082                	ret
    for (n = 0; s[n]; n++)
 54c:	4501                	li	a0,0
 54e:	bfe5                	j	546 <strlen+0x20>

0000000000000550 <memset>:

void *
memset(void *dst, int c, uint n)
{
 550:	1141                	addi	sp,sp,-16
 552:	e422                	sd	s0,8(sp)
 554:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 556:	ca19                	beqz	a2,56c <memset+0x1c>
 558:	87aa                	mv	a5,a0
 55a:	1602                	slli	a2,a2,0x20
 55c:	9201                	srli	a2,a2,0x20
 55e:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 562:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 566:	0785                	addi	a5,a5,1
 568:	fee79de3          	bne	a5,a4,562 <memset+0x12>
    }
    return dst;
}
 56c:	6422                	ld	s0,8(sp)
 56e:	0141                	addi	sp,sp,16
 570:	8082                	ret

0000000000000572 <strchr>:

char *
strchr(const char *s, char c)
{
 572:	1141                	addi	sp,sp,-16
 574:	e422                	sd	s0,8(sp)
 576:	0800                	addi	s0,sp,16
    for (; *s; s++)
 578:	00054783          	lbu	a5,0(a0)
 57c:	cb99                	beqz	a5,592 <strchr+0x20>
        if (*s == c)
 57e:	00f58763          	beq	a1,a5,58c <strchr+0x1a>
    for (; *s; s++)
 582:	0505                	addi	a0,a0,1
 584:	00054783          	lbu	a5,0(a0)
 588:	fbfd                	bnez	a5,57e <strchr+0xc>
            return (char *)s;
    return 0;
 58a:	4501                	li	a0,0
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret
    return 0;
 592:	4501                	li	a0,0
 594:	bfe5                	j	58c <strchr+0x1a>

0000000000000596 <gets>:

char *
gets(char *buf, int max)
{
 596:	711d                	addi	sp,sp,-96
 598:	ec86                	sd	ra,88(sp)
 59a:	e8a2                	sd	s0,80(sp)
 59c:	e4a6                	sd	s1,72(sp)
 59e:	e0ca                	sd	s2,64(sp)
 5a0:	fc4e                	sd	s3,56(sp)
 5a2:	f852                	sd	s4,48(sp)
 5a4:	f456                	sd	s5,40(sp)
 5a6:	f05a                	sd	s6,32(sp)
 5a8:	ec5e                	sd	s7,24(sp)
 5aa:	1080                	addi	s0,sp,96
 5ac:	8baa                	mv	s7,a0
 5ae:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5b0:	892a                	mv	s2,a0
 5b2:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5b4:	4aa9                	li	s5,10
 5b6:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5b8:	89a6                	mv	s3,s1
 5ba:	2485                	addiw	s1,s1,1
 5bc:	0344d863          	bge	s1,s4,5ec <gets+0x56>
        cc = read(0, &c, 1);
 5c0:	4605                	li	a2,1
 5c2:	faf40593          	addi	a1,s0,-81
 5c6:	4501                	li	a0,0
 5c8:	00000097          	auipc	ra,0x0
 5cc:	19a080e7          	jalr	410(ra) # 762 <read>
        if (cc < 1)
 5d0:	00a05e63          	blez	a0,5ec <gets+0x56>
        buf[i++] = c;
 5d4:	faf44783          	lbu	a5,-81(s0)
 5d8:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5dc:	01578763          	beq	a5,s5,5ea <gets+0x54>
 5e0:	0905                	addi	s2,s2,1
 5e2:	fd679be3          	bne	a5,s6,5b8 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5e6:	89a6                	mv	s3,s1
 5e8:	a011                	j	5ec <gets+0x56>
 5ea:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5ec:	99de                	add	s3,s3,s7
 5ee:	00098023          	sb	zero,0(s3)
    return buf;
}
 5f2:	855e                	mv	a0,s7
 5f4:	60e6                	ld	ra,88(sp)
 5f6:	6446                	ld	s0,80(sp)
 5f8:	64a6                	ld	s1,72(sp)
 5fa:	6906                	ld	s2,64(sp)
 5fc:	79e2                	ld	s3,56(sp)
 5fe:	7a42                	ld	s4,48(sp)
 600:	7aa2                	ld	s5,40(sp)
 602:	7b02                	ld	s6,32(sp)
 604:	6be2                	ld	s7,24(sp)
 606:	6125                	addi	sp,sp,96
 608:	8082                	ret

000000000000060a <stat>:

int stat(const char *n, struct stat *st)
{
 60a:	1101                	addi	sp,sp,-32
 60c:	ec06                	sd	ra,24(sp)
 60e:	e822                	sd	s0,16(sp)
 610:	e426                	sd	s1,8(sp)
 612:	e04a                	sd	s2,0(sp)
 614:	1000                	addi	s0,sp,32
 616:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 618:	4581                	li	a1,0
 61a:	00000097          	auipc	ra,0x0
 61e:	170080e7          	jalr	368(ra) # 78a <open>
    if (fd < 0)
 622:	02054563          	bltz	a0,64c <stat+0x42>
 626:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 628:	85ca                	mv	a1,s2
 62a:	00000097          	auipc	ra,0x0
 62e:	178080e7          	jalr	376(ra) # 7a2 <fstat>
 632:	892a                	mv	s2,a0
    close(fd);
 634:	8526                	mv	a0,s1
 636:	00000097          	auipc	ra,0x0
 63a:	13c080e7          	jalr	316(ra) # 772 <close>
    return r;
}
 63e:	854a                	mv	a0,s2
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	64a2                	ld	s1,8(sp)
 646:	6902                	ld	s2,0(sp)
 648:	6105                	addi	sp,sp,32
 64a:	8082                	ret
        return -1;
 64c:	597d                	li	s2,-1
 64e:	bfc5                	j	63e <stat+0x34>

0000000000000650 <atoi>:

int atoi(const char *s)
{
 650:	1141                	addi	sp,sp,-16
 652:	e422                	sd	s0,8(sp)
 654:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 656:	00054683          	lbu	a3,0(a0)
 65a:	fd06879b          	addiw	a5,a3,-48
 65e:	0ff7f793          	zext.b	a5,a5
 662:	4625                	li	a2,9
 664:	02f66863          	bltu	a2,a5,694 <atoi+0x44>
 668:	872a                	mv	a4,a0
    n = 0;
 66a:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 66c:	0705                	addi	a4,a4,1
 66e:	0025179b          	slliw	a5,a0,0x2
 672:	9fa9                	addw	a5,a5,a0
 674:	0017979b          	slliw	a5,a5,0x1
 678:	9fb5                	addw	a5,a5,a3
 67a:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 67e:	00074683          	lbu	a3,0(a4)
 682:	fd06879b          	addiw	a5,a3,-48
 686:	0ff7f793          	zext.b	a5,a5
 68a:	fef671e3          	bgeu	a2,a5,66c <atoi+0x1c>
    return n;
}
 68e:	6422                	ld	s0,8(sp)
 690:	0141                	addi	sp,sp,16
 692:	8082                	ret
    n = 0;
 694:	4501                	li	a0,0
 696:	bfe5                	j	68e <atoi+0x3e>

0000000000000698 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 698:	1141                	addi	sp,sp,-16
 69a:	e422                	sd	s0,8(sp)
 69c:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 69e:	02b57463          	bgeu	a0,a1,6c6 <memmove+0x2e>
    {
        while (n-- > 0)
 6a2:	00c05f63          	blez	a2,6c0 <memmove+0x28>
 6a6:	1602                	slli	a2,a2,0x20
 6a8:	9201                	srli	a2,a2,0x20
 6aa:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6ae:	872a                	mv	a4,a0
            *dst++ = *src++;
 6b0:	0585                	addi	a1,a1,1
 6b2:	0705                	addi	a4,a4,1
 6b4:	fff5c683          	lbu	a3,-1(a1)
 6b8:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6bc:	fee79ae3          	bne	a5,a4,6b0 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6c0:	6422                	ld	s0,8(sp)
 6c2:	0141                	addi	sp,sp,16
 6c4:	8082                	ret
        dst += n;
 6c6:	00c50733          	add	a4,a0,a2
        src += n;
 6ca:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6cc:	fec05ae3          	blez	a2,6c0 <memmove+0x28>
 6d0:	fff6079b          	addiw	a5,a2,-1
 6d4:	1782                	slli	a5,a5,0x20
 6d6:	9381                	srli	a5,a5,0x20
 6d8:	fff7c793          	not	a5,a5
 6dc:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6de:	15fd                	addi	a1,a1,-1
 6e0:	177d                	addi	a4,a4,-1
 6e2:	0005c683          	lbu	a3,0(a1)
 6e6:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6ea:	fee79ae3          	bne	a5,a4,6de <memmove+0x46>
 6ee:	bfc9                	j	6c0 <memmove+0x28>

00000000000006f0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6f0:	1141                	addi	sp,sp,-16
 6f2:	e422                	sd	s0,8(sp)
 6f4:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6f6:	ca05                	beqz	a2,726 <memcmp+0x36>
 6f8:	fff6069b          	addiw	a3,a2,-1
 6fc:	1682                	slli	a3,a3,0x20
 6fe:	9281                	srli	a3,a3,0x20
 700:	0685                	addi	a3,a3,1
 702:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 704:	00054783          	lbu	a5,0(a0)
 708:	0005c703          	lbu	a4,0(a1)
 70c:	00e79863          	bne	a5,a4,71c <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 710:	0505                	addi	a0,a0,1
        p2++;
 712:	0585                	addi	a1,a1,1
    while (n-- > 0)
 714:	fed518e3          	bne	a0,a3,704 <memcmp+0x14>
    }
    return 0;
 718:	4501                	li	a0,0
 71a:	a019                	j	720 <memcmp+0x30>
            return *p1 - *p2;
 71c:	40e7853b          	subw	a0,a5,a4
}
 720:	6422                	ld	s0,8(sp)
 722:	0141                	addi	sp,sp,16
 724:	8082                	ret
    return 0;
 726:	4501                	li	a0,0
 728:	bfe5                	j	720 <memcmp+0x30>

000000000000072a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 72a:	1141                	addi	sp,sp,-16
 72c:	e406                	sd	ra,8(sp)
 72e:	e022                	sd	s0,0(sp)
 730:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 732:	00000097          	auipc	ra,0x0
 736:	f66080e7          	jalr	-154(ra) # 698 <memmove>
}
 73a:	60a2                	ld	ra,8(sp)
 73c:	6402                	ld	s0,0(sp)
 73e:	0141                	addi	sp,sp,16
 740:	8082                	ret

0000000000000742 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 742:	4885                	li	a7,1
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <exit>:
.global exit
exit:
 li a7, SYS_exit
 74a:	4889                	li	a7,2
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <wait>:
.global wait
wait:
 li a7, SYS_wait
 752:	488d                	li	a7,3
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 75a:	4891                	li	a7,4
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <read>:
.global read
read:
 li a7, SYS_read
 762:	4895                	li	a7,5
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <write>:
.global write
write:
 li a7, SYS_write
 76a:	48c1                	li	a7,16
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <close>:
.global close
close:
 li a7, SYS_close
 772:	48d5                	li	a7,21
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <kill>:
.global kill
kill:
 li a7, SYS_kill
 77a:	4899                	li	a7,6
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <exec>:
.global exec
exec:
 li a7, SYS_exec
 782:	489d                	li	a7,7
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <open>:
.global open
open:
 li a7, SYS_open
 78a:	48bd                	li	a7,15
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 792:	48c5                	li	a7,17
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 79a:	48c9                	li	a7,18
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7a2:	48a1                	li	a7,8
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <link>:
.global link
link:
 li a7, SYS_link
 7aa:	48cd                	li	a7,19
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7b2:	48d1                	li	a7,20
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7ba:	48a5                	li	a7,9
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7c2:	48a9                	li	a7,10
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ca:	48ad                	li	a7,11
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7d2:	48b1                	li	a7,12
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7da:	48b5                	li	a7,13
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7e2:	48b9                	li	a7,14
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <ps>:
.global ps
ps:
 li a7, SYS_ps
 7ea:	48d9                	li	a7,22
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7f2:	48dd                	li	a7,23
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7fa:	48e1                	li	a7,24
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 802:	1101                	addi	sp,sp,-32
 804:	ec06                	sd	ra,24(sp)
 806:	e822                	sd	s0,16(sp)
 808:	1000                	addi	s0,sp,32
 80a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 80e:	4605                	li	a2,1
 810:	fef40593          	addi	a1,s0,-17
 814:	00000097          	auipc	ra,0x0
 818:	f56080e7          	jalr	-170(ra) # 76a <write>
}
 81c:	60e2                	ld	ra,24(sp)
 81e:	6442                	ld	s0,16(sp)
 820:	6105                	addi	sp,sp,32
 822:	8082                	ret

0000000000000824 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 824:	7139                	addi	sp,sp,-64
 826:	fc06                	sd	ra,56(sp)
 828:	f822                	sd	s0,48(sp)
 82a:	f426                	sd	s1,40(sp)
 82c:	f04a                	sd	s2,32(sp)
 82e:	ec4e                	sd	s3,24(sp)
 830:	0080                	addi	s0,sp,64
 832:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 834:	c299                	beqz	a3,83a <printint+0x16>
 836:	0805c963          	bltz	a1,8c8 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 83a:	2581                	sext.w	a1,a1
  neg = 0;
 83c:	4881                	li	a7,0
 83e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 842:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 844:	2601                	sext.w	a2,a2
 846:	00000517          	auipc	a0,0x0
 84a:	5b250513          	addi	a0,a0,1458 # df8 <digits>
 84e:	883a                	mv	a6,a4
 850:	2705                	addiw	a4,a4,1
 852:	02c5f7bb          	remuw	a5,a1,a2
 856:	1782                	slli	a5,a5,0x20
 858:	9381                	srli	a5,a5,0x20
 85a:	97aa                	add	a5,a5,a0
 85c:	0007c783          	lbu	a5,0(a5)
 860:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 864:	0005879b          	sext.w	a5,a1
 868:	02c5d5bb          	divuw	a1,a1,a2
 86c:	0685                	addi	a3,a3,1
 86e:	fec7f0e3          	bgeu	a5,a2,84e <printint+0x2a>
  if(neg)
 872:	00088c63          	beqz	a7,88a <printint+0x66>
    buf[i++] = '-';
 876:	fd070793          	addi	a5,a4,-48
 87a:	00878733          	add	a4,a5,s0
 87e:	02d00793          	li	a5,45
 882:	fef70823          	sb	a5,-16(a4)
 886:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 88a:	02e05863          	blez	a4,8ba <printint+0x96>
 88e:	fc040793          	addi	a5,s0,-64
 892:	00e78933          	add	s2,a5,a4
 896:	fff78993          	addi	s3,a5,-1
 89a:	99ba                	add	s3,s3,a4
 89c:	377d                	addiw	a4,a4,-1
 89e:	1702                	slli	a4,a4,0x20
 8a0:	9301                	srli	a4,a4,0x20
 8a2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8a6:	fff94583          	lbu	a1,-1(s2)
 8aa:	8526                	mv	a0,s1
 8ac:	00000097          	auipc	ra,0x0
 8b0:	f56080e7          	jalr	-170(ra) # 802 <putc>
  while(--i >= 0)
 8b4:	197d                	addi	s2,s2,-1
 8b6:	ff3918e3          	bne	s2,s3,8a6 <printint+0x82>
}
 8ba:	70e2                	ld	ra,56(sp)
 8bc:	7442                	ld	s0,48(sp)
 8be:	74a2                	ld	s1,40(sp)
 8c0:	7902                	ld	s2,32(sp)
 8c2:	69e2                	ld	s3,24(sp)
 8c4:	6121                	addi	sp,sp,64
 8c6:	8082                	ret
    x = -xx;
 8c8:	40b005bb          	negw	a1,a1
    neg = 1;
 8cc:	4885                	li	a7,1
    x = -xx;
 8ce:	bf85                	j	83e <printint+0x1a>

00000000000008d0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8d0:	715d                	addi	sp,sp,-80
 8d2:	e486                	sd	ra,72(sp)
 8d4:	e0a2                	sd	s0,64(sp)
 8d6:	fc26                	sd	s1,56(sp)
 8d8:	f84a                	sd	s2,48(sp)
 8da:	f44e                	sd	s3,40(sp)
 8dc:	f052                	sd	s4,32(sp)
 8de:	ec56                	sd	s5,24(sp)
 8e0:	e85a                	sd	s6,16(sp)
 8e2:	e45e                	sd	s7,8(sp)
 8e4:	e062                	sd	s8,0(sp)
 8e6:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8e8:	0005c903          	lbu	s2,0(a1)
 8ec:	18090c63          	beqz	s2,a84 <vprintf+0x1b4>
 8f0:	8aaa                	mv	s5,a0
 8f2:	8bb2                	mv	s7,a2
 8f4:	00158493          	addi	s1,a1,1
  state = 0;
 8f8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8fa:	02500a13          	li	s4,37
 8fe:	4b55                	li	s6,21
 900:	a839                	j	91e <vprintf+0x4e>
        putc(fd, c);
 902:	85ca                	mv	a1,s2
 904:	8556                	mv	a0,s5
 906:	00000097          	auipc	ra,0x0
 90a:	efc080e7          	jalr	-260(ra) # 802 <putc>
 90e:	a019                	j	914 <vprintf+0x44>
    } else if(state == '%'){
 910:	01498d63          	beq	s3,s4,92a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 914:	0485                	addi	s1,s1,1
 916:	fff4c903          	lbu	s2,-1(s1)
 91a:	16090563          	beqz	s2,a84 <vprintf+0x1b4>
    if(state == 0){
 91e:	fe0999e3          	bnez	s3,910 <vprintf+0x40>
      if(c == '%'){
 922:	ff4910e3          	bne	s2,s4,902 <vprintf+0x32>
        state = '%';
 926:	89d2                	mv	s3,s4
 928:	b7f5                	j	914 <vprintf+0x44>
      if(c == 'd'){
 92a:	13490263          	beq	s2,s4,a4e <vprintf+0x17e>
 92e:	f9d9079b          	addiw	a5,s2,-99
 932:	0ff7f793          	zext.b	a5,a5
 936:	12fb6563          	bltu	s6,a5,a60 <vprintf+0x190>
 93a:	f9d9079b          	addiw	a5,s2,-99
 93e:	0ff7f713          	zext.b	a4,a5
 942:	10eb6f63          	bltu	s6,a4,a60 <vprintf+0x190>
 946:	00271793          	slli	a5,a4,0x2
 94a:	00000717          	auipc	a4,0x0
 94e:	45670713          	addi	a4,a4,1110 # da0 <malloc+0x21e>
 952:	97ba                	add	a5,a5,a4
 954:	439c                	lw	a5,0(a5)
 956:	97ba                	add	a5,a5,a4
 958:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 95a:	008b8913          	addi	s2,s7,8
 95e:	4685                	li	a3,1
 960:	4629                	li	a2,10
 962:	000ba583          	lw	a1,0(s7)
 966:	8556                	mv	a0,s5
 968:	00000097          	auipc	ra,0x0
 96c:	ebc080e7          	jalr	-324(ra) # 824 <printint>
 970:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 972:	4981                	li	s3,0
 974:	b745                	j	914 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 976:	008b8913          	addi	s2,s7,8
 97a:	4681                	li	a3,0
 97c:	4629                	li	a2,10
 97e:	000ba583          	lw	a1,0(s7)
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	ea0080e7          	jalr	-352(ra) # 824 <printint>
 98c:	8bca                	mv	s7,s2
      state = 0;
 98e:	4981                	li	s3,0
 990:	b751                	j	914 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 992:	008b8913          	addi	s2,s7,8
 996:	4681                	li	a3,0
 998:	4641                	li	a2,16
 99a:	000ba583          	lw	a1,0(s7)
 99e:	8556                	mv	a0,s5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	e84080e7          	jalr	-380(ra) # 824 <printint>
 9a8:	8bca                	mv	s7,s2
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b7a5                	j	914 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9ae:	008b8c13          	addi	s8,s7,8
 9b2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9b6:	03000593          	li	a1,48
 9ba:	8556                	mv	a0,s5
 9bc:	00000097          	auipc	ra,0x0
 9c0:	e46080e7          	jalr	-442(ra) # 802 <putc>
  putc(fd, 'x');
 9c4:	07800593          	li	a1,120
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	e38080e7          	jalr	-456(ra) # 802 <putc>
 9d2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9d4:	00000b97          	auipc	s7,0x0
 9d8:	424b8b93          	addi	s7,s7,1060 # df8 <digits>
 9dc:	03c9d793          	srli	a5,s3,0x3c
 9e0:	97de                	add	a5,a5,s7
 9e2:	0007c583          	lbu	a1,0(a5)
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	e1a080e7          	jalr	-486(ra) # 802 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9f0:	0992                	slli	s3,s3,0x4
 9f2:	397d                	addiw	s2,s2,-1
 9f4:	fe0914e3          	bnez	s2,9dc <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9f8:	8be2                	mv	s7,s8
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	bf21                	j	914 <vprintf+0x44>
        s = va_arg(ap, char*);
 9fe:	008b8993          	addi	s3,s7,8
 a02:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a06:	02090163          	beqz	s2,a28 <vprintf+0x158>
        while(*s != 0){
 a0a:	00094583          	lbu	a1,0(s2)
 a0e:	c9a5                	beqz	a1,a7e <vprintf+0x1ae>
          putc(fd, *s);
 a10:	8556                	mv	a0,s5
 a12:	00000097          	auipc	ra,0x0
 a16:	df0080e7          	jalr	-528(ra) # 802 <putc>
          s++;
 a1a:	0905                	addi	s2,s2,1
        while(*s != 0){
 a1c:	00094583          	lbu	a1,0(s2)
 a20:	f9e5                	bnez	a1,a10 <vprintf+0x140>
        s = va_arg(ap, char*);
 a22:	8bce                	mv	s7,s3
      state = 0;
 a24:	4981                	li	s3,0
 a26:	b5fd                	j	914 <vprintf+0x44>
          s = "(null)";
 a28:	00000917          	auipc	s2,0x0
 a2c:	37090913          	addi	s2,s2,880 # d98 <malloc+0x216>
        while(*s != 0){
 a30:	02800593          	li	a1,40
 a34:	bff1                	j	a10 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a36:	008b8913          	addi	s2,s7,8
 a3a:	000bc583          	lbu	a1,0(s7)
 a3e:	8556                	mv	a0,s5
 a40:	00000097          	auipc	ra,0x0
 a44:	dc2080e7          	jalr	-574(ra) # 802 <putc>
 a48:	8bca                	mv	s7,s2
      state = 0;
 a4a:	4981                	li	s3,0
 a4c:	b5e1                	j	914 <vprintf+0x44>
        putc(fd, c);
 a4e:	02500593          	li	a1,37
 a52:	8556                	mv	a0,s5
 a54:	00000097          	auipc	ra,0x0
 a58:	dae080e7          	jalr	-594(ra) # 802 <putc>
      state = 0;
 a5c:	4981                	li	s3,0
 a5e:	bd5d                	j	914 <vprintf+0x44>
        putc(fd, '%');
 a60:	02500593          	li	a1,37
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	d9c080e7          	jalr	-612(ra) # 802 <putc>
        putc(fd, c);
 a6e:	85ca                	mv	a1,s2
 a70:	8556                	mv	a0,s5
 a72:	00000097          	auipc	ra,0x0
 a76:	d90080e7          	jalr	-624(ra) # 802 <putc>
      state = 0;
 a7a:	4981                	li	s3,0
 a7c:	bd61                	j	914 <vprintf+0x44>
        s = va_arg(ap, char*);
 a7e:	8bce                	mv	s7,s3
      state = 0;
 a80:	4981                	li	s3,0
 a82:	bd49                	j	914 <vprintf+0x44>
    }
  }
}
 a84:	60a6                	ld	ra,72(sp)
 a86:	6406                	ld	s0,64(sp)
 a88:	74e2                	ld	s1,56(sp)
 a8a:	7942                	ld	s2,48(sp)
 a8c:	79a2                	ld	s3,40(sp)
 a8e:	7a02                	ld	s4,32(sp)
 a90:	6ae2                	ld	s5,24(sp)
 a92:	6b42                	ld	s6,16(sp)
 a94:	6ba2                	ld	s7,8(sp)
 a96:	6c02                	ld	s8,0(sp)
 a98:	6161                	addi	sp,sp,80
 a9a:	8082                	ret

0000000000000a9c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a9c:	715d                	addi	sp,sp,-80
 a9e:	ec06                	sd	ra,24(sp)
 aa0:	e822                	sd	s0,16(sp)
 aa2:	1000                	addi	s0,sp,32
 aa4:	e010                	sd	a2,0(s0)
 aa6:	e414                	sd	a3,8(s0)
 aa8:	e818                	sd	a4,16(s0)
 aaa:	ec1c                	sd	a5,24(s0)
 aac:	03043023          	sd	a6,32(s0)
 ab0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ab4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ab8:	8622                	mv	a2,s0
 aba:	00000097          	auipc	ra,0x0
 abe:	e16080e7          	jalr	-490(ra) # 8d0 <vprintf>
}
 ac2:	60e2                	ld	ra,24(sp)
 ac4:	6442                	ld	s0,16(sp)
 ac6:	6161                	addi	sp,sp,80
 ac8:	8082                	ret

0000000000000aca <printf>:

void
printf(const char *fmt, ...)
{
 aca:	711d                	addi	sp,sp,-96
 acc:	ec06                	sd	ra,24(sp)
 ace:	e822                	sd	s0,16(sp)
 ad0:	1000                	addi	s0,sp,32
 ad2:	e40c                	sd	a1,8(s0)
 ad4:	e810                	sd	a2,16(s0)
 ad6:	ec14                	sd	a3,24(s0)
 ad8:	f018                	sd	a4,32(s0)
 ada:	f41c                	sd	a5,40(s0)
 adc:	03043823          	sd	a6,48(s0)
 ae0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ae4:	00840613          	addi	a2,s0,8
 ae8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 aec:	85aa                	mv	a1,a0
 aee:	4505                	li	a0,1
 af0:	00000097          	auipc	ra,0x0
 af4:	de0080e7          	jalr	-544(ra) # 8d0 <vprintf>
}
 af8:	60e2                	ld	ra,24(sp)
 afa:	6442                	ld	s0,16(sp)
 afc:	6125                	addi	sp,sp,96
 afe:	8082                	ret

0000000000000b00 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b00:	1141                	addi	sp,sp,-16
 b02:	e422                	sd	s0,8(sp)
 b04:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b06:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0a:	00000797          	auipc	a5,0x0
 b0e:	50e7b783          	ld	a5,1294(a5) # 1018 <freep>
 b12:	a02d                	j	b3c <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b14:	4618                	lw	a4,8(a2)
 b16:	9f2d                	addw	a4,a4,a1
 b18:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b1c:	6398                	ld	a4,0(a5)
 b1e:	6310                	ld	a2,0(a4)
 b20:	a83d                	j	b5e <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b22:	ff852703          	lw	a4,-8(a0)
 b26:	9f31                	addw	a4,a4,a2
 b28:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b2a:	ff053683          	ld	a3,-16(a0)
 b2e:	a091                	j	b72 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b30:	6398                	ld	a4,0(a5)
 b32:	00e7e463          	bltu	a5,a4,b3a <free+0x3a>
 b36:	00e6ea63          	bltu	a3,a4,b4a <free+0x4a>
{
 b3a:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b3c:	fed7fae3          	bgeu	a5,a3,b30 <free+0x30>
 b40:	6398                	ld	a4,0(a5)
 b42:	00e6e463          	bltu	a3,a4,b4a <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b46:	fee7eae3          	bltu	a5,a4,b3a <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b4a:	ff852583          	lw	a1,-8(a0)
 b4e:	6390                	ld	a2,0(a5)
 b50:	02059813          	slli	a6,a1,0x20
 b54:	01c85713          	srli	a4,a6,0x1c
 b58:	9736                	add	a4,a4,a3
 b5a:	fae60de3          	beq	a2,a4,b14 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b5e:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b62:	4790                	lw	a2,8(a5)
 b64:	02061593          	slli	a1,a2,0x20
 b68:	01c5d713          	srli	a4,a1,0x1c
 b6c:	973e                	add	a4,a4,a5
 b6e:	fae68ae3          	beq	a3,a4,b22 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b72:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b74:	00000717          	auipc	a4,0x0
 b78:	4af73223          	sd	a5,1188(a4) # 1018 <freep>
}
 b7c:	6422                	ld	s0,8(sp)
 b7e:	0141                	addi	sp,sp,16
 b80:	8082                	ret

0000000000000b82 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b82:	7139                	addi	sp,sp,-64
 b84:	fc06                	sd	ra,56(sp)
 b86:	f822                	sd	s0,48(sp)
 b88:	f426                	sd	s1,40(sp)
 b8a:	f04a                	sd	s2,32(sp)
 b8c:	ec4e                	sd	s3,24(sp)
 b8e:	e852                	sd	s4,16(sp)
 b90:	e456                	sd	s5,8(sp)
 b92:	e05a                	sd	s6,0(sp)
 b94:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b96:	02051493          	slli	s1,a0,0x20
 b9a:	9081                	srli	s1,s1,0x20
 b9c:	04bd                	addi	s1,s1,15
 b9e:	8091                	srli	s1,s1,0x4
 ba0:	0014899b          	addiw	s3,s1,1
 ba4:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 ba6:	00000517          	auipc	a0,0x0
 baa:	47253503          	ld	a0,1138(a0) # 1018 <freep>
 bae:	c515                	beqz	a0,bda <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bb0:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bb2:	4798                	lw	a4,8(a5)
 bb4:	02977f63          	bgeu	a4,s1,bf2 <malloc+0x70>
    if (nu < 4096)
 bb8:	8a4e                	mv	s4,s3
 bba:	0009871b          	sext.w	a4,s3
 bbe:	6685                	lui	a3,0x1
 bc0:	00d77363          	bgeu	a4,a3,bc6 <malloc+0x44>
 bc4:	6a05                	lui	s4,0x1
 bc6:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bca:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bce:	00000917          	auipc	s2,0x0
 bd2:	44a90913          	addi	s2,s2,1098 # 1018 <freep>
    if (p == (char *)-1)
 bd6:	5afd                	li	s5,-1
 bd8:	a895                	j	c4c <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bda:	00000797          	auipc	a5,0x0
 bde:	4c678793          	addi	a5,a5,1222 # 10a0 <base>
 be2:	00000717          	auipc	a4,0x0
 be6:	42f73b23          	sd	a5,1078(a4) # 1018 <freep>
 bea:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bec:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bf0:	b7e1                	j	bb8 <malloc+0x36>
            if (p->s.size == nunits)
 bf2:	02e48c63          	beq	s1,a4,c2a <malloc+0xa8>
                p->s.size -= nunits;
 bf6:	4137073b          	subw	a4,a4,s3
 bfa:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bfc:	02071693          	slli	a3,a4,0x20
 c00:	01c6d713          	srli	a4,a3,0x1c
 c04:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c06:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c0a:	00000717          	auipc	a4,0x0
 c0e:	40a73723          	sd	a0,1038(a4) # 1018 <freep>
            return (void *)(p + 1);
 c12:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c16:	70e2                	ld	ra,56(sp)
 c18:	7442                	ld	s0,48(sp)
 c1a:	74a2                	ld	s1,40(sp)
 c1c:	7902                	ld	s2,32(sp)
 c1e:	69e2                	ld	s3,24(sp)
 c20:	6a42                	ld	s4,16(sp)
 c22:	6aa2                	ld	s5,8(sp)
 c24:	6b02                	ld	s6,0(sp)
 c26:	6121                	addi	sp,sp,64
 c28:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c2a:	6398                	ld	a4,0(a5)
 c2c:	e118                	sd	a4,0(a0)
 c2e:	bff1                	j	c0a <malloc+0x88>
    hp->s.size = nu;
 c30:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c34:	0541                	addi	a0,a0,16
 c36:	00000097          	auipc	ra,0x0
 c3a:	eca080e7          	jalr	-310(ra) # b00 <free>
    return freep;
 c3e:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c42:	d971                	beqz	a0,c16 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c44:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c46:	4798                	lw	a4,8(a5)
 c48:	fa9775e3          	bgeu	a4,s1,bf2 <malloc+0x70>
        if (p == freep)
 c4c:	00093703          	ld	a4,0(s2)
 c50:	853e                	mv	a0,a5
 c52:	fef719e3          	bne	a4,a5,c44 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c56:	8552                	mv	a0,s4
 c58:	00000097          	auipc	ra,0x0
 c5c:	b7a080e7          	jalr	-1158(ra) # 7d2 <sbrk>
    if (p == (char *)-1)
 c60:	fd5518e3          	bne	a0,s5,c30 <malloc+0xae>
                return 0;
 c64:	4501                	li	a0,0
 c66:	bf45                	j	c16 <malloc+0x94>
