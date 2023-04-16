
user/_ln:     file format elf64-littleriscv


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
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	c3058593          	addi	a1,a1,-976 # c40 <malloc+0xec>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	a54080e7          	jalr	-1452(ra) # a6e <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	6f8080e7          	jalr	1784(ra) # 71c <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	74a080e7          	jalr	1866(ra) # 77c <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	6dc080e7          	jalr	1756(ra) # 71c <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	c0c58593          	addi	a1,a1,-1012 # c58 <malloc+0x104>
  54:	4509                	li	a0,2
  56:	00001097          	auipc	ra,0x1
  5a:	a18080e7          	jalr	-1512(ra) # a6e <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
    lk->name = name;
  66:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  68:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  6c:	57fd                	li	a5,-1
  6e:	00f50823          	sb	a5,16(a0)
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  78:	00054783          	lbu	a5,0(a0)
  7c:	e399                	bnez	a5,82 <holding+0xa>
  7e:	4501                	li	a0,0
}
  80:	8082                	ret
{
  82:	1101                	addi	sp,sp,-32
  84:	ec06                	sd	ra,24(sp)
  86:	e822                	sd	s0,16(sp)
  88:	e426                	sd	s1,8(sp)
  8a:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  8c:	01054483          	lbu	s1,16(a0)
  90:	00000097          	auipc	ra,0x0
  94:	2dc080e7          	jalr	732(ra) # 36c <twhoami>
  98:	2501                	sext.w	a0,a0
  9a:	40a48533          	sub	a0,s1,a0
  9e:	00153513          	seqz	a0,a0
}
  a2:	60e2                	ld	ra,24(sp)
  a4:	6442                	ld	s0,16(sp)
  a6:	64a2                	ld	s1,8(sp)
  a8:	6105                	addi	sp,sp,32
  aa:	8082                	ret

00000000000000ac <acquire>:

void acquire(struct lock *lk)
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	ec26                	sd	s1,24(sp)
  b4:	e84a                	sd	s2,16(sp)
  b6:	e44e                	sd	s3,8(sp)
  b8:	e052                	sd	s4,0(sp)
  ba:	1800                	addi	s0,sp,48
  bc:	8a2a                	mv	s4,a0
    if (holding(lk))
  be:	00000097          	auipc	ra,0x0
  c2:	fba080e7          	jalr	-70(ra) # 78 <holding>
  c6:	e919                	bnez	a0,dc <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c8:	ffca7493          	andi	s1,s4,-4
  cc:	003a7913          	andi	s2,s4,3
  d0:	0039191b          	slliw	s2,s2,0x3
  d4:	4985                	li	s3,1
  d6:	012999bb          	sllw	s3,s3,s2
  da:	a015                	j	fe <acquire+0x52>
        printf("re-acquiring lock we already hold");
  dc:	00001517          	auipc	a0,0x1
  e0:	b9450513          	addi	a0,a0,-1132 # c70 <malloc+0x11c>
  e4:	00001097          	auipc	ra,0x1
  e8:	9b8080e7          	jalr	-1608(ra) # a9c <printf>
        exit(-1);
  ec:	557d                	li	a0,-1
  ee:	00000097          	auipc	ra,0x0
  f2:	62e080e7          	jalr	1582(ra) # 71c <exit>
    {
        // give up the cpu for other threads
        tyield();
  f6:	00000097          	auipc	ra,0x0
  fa:	252080e7          	jalr	594(ra) # 348 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  fe:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 102:	0127d7bb          	srlw	a5,a5,s2
 106:	0ff7f793          	zext.b	a5,a5
 10a:	f7f5                	bnez	a5,f6 <acquire+0x4a>
    }

    __sync_synchronize();
 10c:	0ff0000f          	fence

    lk->tid = twhoami();
 110:	00000097          	auipc	ra,0x0
 114:	25c080e7          	jalr	604(ra) # 36c <twhoami>
 118:	00aa0823          	sb	a0,16(s4)
}
 11c:	70a2                	ld	ra,40(sp)
 11e:	7402                	ld	s0,32(sp)
 120:	64e2                	ld	s1,24(sp)
 122:	6942                	ld	s2,16(sp)
 124:	69a2                	ld	s3,8(sp)
 126:	6a02                	ld	s4,0(sp)
 128:	6145                	addi	sp,sp,48
 12a:	8082                	ret

000000000000012c <release>:

void release(struct lock *lk)
{
 12c:	1101                	addi	sp,sp,-32
 12e:	ec06                	sd	ra,24(sp)
 130:	e822                	sd	s0,16(sp)
 132:	e426                	sd	s1,8(sp)
 134:	1000                	addi	s0,sp,32
 136:	84aa                	mv	s1,a0
    if (!holding(lk))
 138:	00000097          	auipc	ra,0x0
 13c:	f40080e7          	jalr	-192(ra) # 78 <holding>
 140:	c11d                	beqz	a0,166 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 142:	57fd                	li	a5,-1
 144:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 148:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 14c:	0ff0000f          	fence
 150:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 154:	00000097          	auipc	ra,0x0
 158:	1f4080e7          	jalr	500(ra) # 348 <tyield>
}
 15c:	60e2                	ld	ra,24(sp)
 15e:	6442                	ld	s0,16(sp)
 160:	64a2                	ld	s1,8(sp)
 162:	6105                	addi	sp,sp,32
 164:	8082                	ret
        printf("releasing lock we are not holding");
 166:	00001517          	auipc	a0,0x1
 16a:	b3250513          	addi	a0,a0,-1230 # c98 <malloc+0x144>
 16e:	00001097          	auipc	ra,0x1
 172:	92e080e7          	jalr	-1746(ra) # a9c <printf>
        exit(-1);
 176:	557d                	li	a0,-1
 178:	00000097          	auipc	ra,0x0
 17c:	5a4080e7          	jalr	1444(ra) # 71c <exit>

0000000000000180 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 180:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 182:	00001617          	auipc	a2,0x1
 186:	e9e60613          	addi	a2,a2,-354 # 1020 <threads>
 18a:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 18c:	45c1                	li	a1,16
 18e:	a021                	j	196 <tsched+0x16>
 190:	2685                	addiw	a3,a3,1
 192:	08b68c63          	beq	a3,a1,22a <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 196:	41f6d71b          	sraiw	a4,a3,0x1f
 19a:	01c7571b          	srliw	a4,a4,0x1c
 19e:	00d707bb          	addw	a5,a4,a3
 1a2:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1a4:	9f99                	subw	a5,a5,a4
 1a6:	078e                	slli	a5,a5,0x3
 1a8:	97b2                	add	a5,a5,a2
 1aa:	639c                	ld	a5,0(a5)
 1ac:	d3f5                	beqz	a5,190 <tsched+0x10>
 1ae:	5fb8                	lw	a4,120(a5)
 1b0:	fea710e3          	bne	a4,a0,190 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1b4:	00001717          	auipc	a4,0x1
 1b8:	e6c73703          	ld	a4,-404(a4) # 1020 <threads>
 1bc:	5f30                	lw	a2,120(a4)
 1be:	468d                	li	a3,3
 1c0:	06d60363          	beq	a2,a3,226 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1c4:	c3a5                	beqz	a5,224 <tsched+0xa4>
{
 1c6:	1101                	addi	sp,sp,-32
 1c8:	ec06                	sd	ra,24(sp)
 1ca:	e822                	sd	s0,16(sp)
 1cc:	e426                	sd	s1,8(sp)
 1ce:	e04a                	sd	s2,0(sp)
 1d0:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1d2:	00001497          	auipc	s1,0x1
 1d6:	e3e48493          	addi	s1,s1,-450 # 1010 <current_thread>
 1da:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1de:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1e0:	0007c603          	lbu	a2,0(a5)
 1e4:	00094583          	lbu	a1,0(s2)
 1e8:	00001517          	auipc	a0,0x1
 1ec:	ad850513          	addi	a0,a0,-1320 # cc0 <malloc+0x16c>
 1f0:	00001097          	auipc	ra,0x1
 1f4:	8ac080e7          	jalr	-1876(ra) # a9c <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1f8:	608c                	ld	a1,0(s1)
 1fa:	05a1                	addi	a1,a1,8
 1fc:	00890513          	addi	a0,s2,8
 200:	00000097          	auipc	ra,0x0
 204:	184080e7          	jalr	388(ra) # 384 <tswtch>
        printf("Thread switch complete\n");
 208:	00001517          	auipc	a0,0x1
 20c:	ae050513          	addi	a0,a0,-1312 # ce8 <malloc+0x194>
 210:	00001097          	auipc	ra,0x1
 214:	88c080e7          	jalr	-1908(ra) # a9c <printf>
    }
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6902                	ld	s2,0(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret
 224:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 226:	87ba                	mv	a5,a4
 228:	bf79                	j	1c6 <tsched+0x46>
 22a:	00001797          	auipc	a5,0x1
 22e:	df67b783          	ld	a5,-522(a5) # 1020 <threads>
 232:	5fb4                	lw	a3,120(a5)
 234:	470d                	li	a4,3
 236:	f8e688e3          	beq	a3,a4,1c6 <tsched+0x46>
 23a:	8082                	ret

000000000000023c <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 23c:	7179                	addi	sp,sp,-48
 23e:	f406                	sd	ra,40(sp)
 240:	f022                	sd	s0,32(sp)
 242:	ec26                	sd	s1,24(sp)
 244:	e84a                	sd	s2,16(sp)
 246:	e44e                	sd	s3,8(sp)
 248:	1800                	addi	s0,sp,48
 24a:	84aa                	mv	s1,a0
 24c:	89b2                	mv	s3,a2
 24e:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 250:	09000513          	li	a0,144
 254:	00001097          	auipc	ra,0x1
 258:	900080e7          	jalr	-1792(ra) # b54 <malloc>
 25c:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 25e:	478d                	li	a5,3
 260:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 262:	609c                	ld	a5,0(s1)
 264:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 268:	609c                	ld	a5,0(s1)
 26a:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 26e:	00001717          	auipc	a4,0x1
 272:	d9270713          	addi	a4,a4,-622 # 1000 <next_tid>
 276:	431c                	lw	a5,0(a4)
 278:	0017869b          	addiw	a3,a5,1
 27c:	c314                	sw	a3,0(a4)
 27e:	6098                	ld	a4,0(s1)
 280:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 284:	00001717          	auipc	a4,0x1
 288:	d9c70713          	addi	a4,a4,-612 # 1020 <threads>
 28c:	4781                	li	a5,0
 28e:	4641                	li	a2,16
    if (threads[i] == NULL) {
 290:	6314                	ld	a3,0(a4)
 292:	ce81                	beqz	a3,2aa <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 294:	2785                	addiw	a5,a5,1
 296:	0721                	addi	a4,a4,8
 298:	fec79ce3          	bne	a5,a2,290 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 29c:	70a2                	ld	ra,40(sp)
 29e:	7402                	ld	s0,32(sp)
 2a0:	64e2                	ld	s1,24(sp)
 2a2:	6942                	ld	s2,16(sp)
 2a4:	69a2                	ld	s3,8(sp)
 2a6:	6145                	addi	sp,sp,48
 2a8:	8082                	ret
        threads[i] = *thread;
 2aa:	6094                	ld	a3,0(s1)
 2ac:	078e                	slli	a5,a5,0x3
 2ae:	00001717          	auipc	a4,0x1
 2b2:	d7270713          	addi	a4,a4,-654 # 1020 <threads>
 2b6:	97ba                	add	a5,a5,a4
 2b8:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2ba:	0006c583          	lbu	a1,0(a3)
 2be:	00001517          	auipc	a0,0x1
 2c2:	a4250513          	addi	a0,a0,-1470 # d00 <malloc+0x1ac>
 2c6:	00000097          	auipc	ra,0x0
 2ca:	7d6080e7          	jalr	2006(ra) # a9c <printf>
        break;
 2ce:	b7f9                	j	29c <tcreate+0x60>

00000000000002d0 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2d0:	7179                	addi	sp,sp,-48
 2d2:	f406                	sd	ra,40(sp)
 2d4:	f022                	sd	s0,32(sp)
 2d6:	ec26                	sd	s1,24(sp)
 2d8:	e84a                	sd	s2,16(sp)
 2da:	e44e                	sd	s3,8(sp)
 2dc:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2de:	00001797          	auipc	a5,0x1
 2e2:	d4278793          	addi	a5,a5,-702 # 1020 <threads>
 2e6:	00001697          	auipc	a3,0x1
 2ea:	dba68693          	addi	a3,a3,-582 # 10a0 <base>
 2ee:	a021                	j	2f6 <tjoin+0x26>
 2f0:	07a1                	addi	a5,a5,8
 2f2:	04d78763          	beq	a5,a3,340 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2f6:	6384                	ld	s1,0(a5)
 2f8:	dce5                	beqz	s1,2f0 <tjoin+0x20>
 2fa:	0004c703          	lbu	a4,0(s1)
 2fe:	fea719e3          	bne	a4,a0,2f0 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 302:	5cb8                	lw	a4,120(s1)
 304:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 306:	00001997          	auipc	s3,0x1
 30a:	a2a98993          	addi	s3,s3,-1494 # d30 <malloc+0x1dc>
    while (target_thread->state != EXITED) {
 30e:	4919                	li	s2,6
 310:	02f70a63          	beq	a4,a5,344 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 314:	0004c583          	lbu	a1,0(s1)
 318:	854e                	mv	a0,s3
 31a:	00000097          	auipc	ra,0x0
 31e:	782080e7          	jalr	1922(ra) # a9c <printf>
        tsched();
 322:	00000097          	auipc	ra,0x0
 326:	e5e080e7          	jalr	-418(ra) # 180 <tsched>
    while (target_thread->state != EXITED) {
 32a:	5cbc                	lw	a5,120(s1)
 32c:	ff2794e3          	bne	a5,s2,314 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 330:	4501                	li	a0,0
}
 332:	70a2                	ld	ra,40(sp)
 334:	7402                	ld	s0,32(sp)
 336:	64e2                	ld	s1,24(sp)
 338:	6942                	ld	s2,16(sp)
 33a:	69a2                	ld	s3,8(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret
        return -1;
 340:	557d                	li	a0,-1
 342:	bfc5                	j	332 <tjoin+0x62>
    return 0;
 344:	4501                	li	a0,0
 346:	b7f5                	j	332 <tjoin+0x62>

0000000000000348 <tyield>:


void tyield()
{
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 350:	00001797          	auipc	a5,0x1
 354:	cc07b783          	ld	a5,-832(a5) # 1010 <current_thread>
 358:	470d                	li	a4,3
 35a:	dfb8                	sw	a4,120(a5)
    tsched();
 35c:	00000097          	auipc	ra,0x0
 360:	e24080e7          	jalr	-476(ra) # 180 <tsched>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <twhoami>:

uint8 twhoami()
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 372:	00001797          	auipc	a5,0x1
 376:	c9e7b783          	ld	a5,-866(a5) # 1010 <current_thread>
 37a:	0007c503          	lbu	a0,0(a5)
 37e:	6422                	ld	s0,8(sp)
 380:	0141                	addi	sp,sp,16
 382:	8082                	ret

0000000000000384 <tswtch>:
 384:	00153023          	sd	ra,0(a0)
 388:	00253423          	sd	sp,8(a0)
 38c:	e900                	sd	s0,16(a0)
 38e:	ed04                	sd	s1,24(a0)
 390:	03253023          	sd	s2,32(a0)
 394:	03353423          	sd	s3,40(a0)
 398:	03453823          	sd	s4,48(a0)
 39c:	03553c23          	sd	s5,56(a0)
 3a0:	05653023          	sd	s6,64(a0)
 3a4:	05753423          	sd	s7,72(a0)
 3a8:	05853823          	sd	s8,80(a0)
 3ac:	05953c23          	sd	s9,88(a0)
 3b0:	07a53023          	sd	s10,96(a0)
 3b4:	07b53423          	sd	s11,104(a0)
 3b8:	0005b083          	ld	ra,0(a1)
 3bc:	0085b103          	ld	sp,8(a1)
 3c0:	6980                	ld	s0,16(a1)
 3c2:	6d84                	ld	s1,24(a1)
 3c4:	0205b903          	ld	s2,32(a1)
 3c8:	0285b983          	ld	s3,40(a1)
 3cc:	0305ba03          	ld	s4,48(a1)
 3d0:	0385ba83          	ld	s5,56(a1)
 3d4:	0405bb03          	ld	s6,64(a1)
 3d8:	0485bb83          	ld	s7,72(a1)
 3dc:	0505bc03          	ld	s8,80(a1)
 3e0:	0585bc83          	ld	s9,88(a1)
 3e4:	0605bd03          	ld	s10,96(a1)
 3e8:	0685bd83          	ld	s11,104(a1)
 3ec:	8082                	ret

00000000000003ee <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3ee:	715d                	addi	sp,sp,-80
 3f0:	e486                	sd	ra,72(sp)
 3f2:	e0a2                	sd	s0,64(sp)
 3f4:	fc26                	sd	s1,56(sp)
 3f6:	f84a                	sd	s2,48(sp)
 3f8:	f44e                	sd	s3,40(sp)
 3fa:	f052                	sd	s4,32(sp)
 3fc:	ec56                	sd	s5,24(sp)
 3fe:	e85a                	sd	s6,16(sp)
 400:	e45e                	sd	s7,8(sp)
 402:	0880                	addi	s0,sp,80
 404:	892a                	mv	s2,a0
 406:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 408:	00001517          	auipc	a0,0x1
 40c:	94850513          	addi	a0,a0,-1720 # d50 <malloc+0x1fc>
 410:	00000097          	auipc	ra,0x0
 414:	68c080e7          	jalr	1676(ra) # a9c <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 418:	09000513          	li	a0,144
 41c:	00000097          	auipc	ra,0x0
 420:	738080e7          	jalr	1848(ra) # b54 <malloc>

    main_thread->tid = 0;
 424:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 428:	4791                	li	a5,4
 42a:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 42c:	00001797          	auipc	a5,0x1
 430:	bea7b223          	sd	a0,-1052(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 434:	00001a17          	auipc	s4,0x1
 438:	beca0a13          	addi	s4,s4,-1044 # 1020 <threads>
 43c:	00001497          	auipc	s1,0x1
 440:	c6448493          	addi	s1,s1,-924 # 10a0 <base>
    current_thread = main_thread;
 444:	87d2                	mv	a5,s4
        threads[i] = NULL;
 446:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 44a:	07a1                	addi	a5,a5,8
 44c:	fe979de3          	bne	a5,s1,446 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 450:	00001797          	auipc	a5,0x1
 454:	bca7b823          	sd	a0,-1072(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 458:	85ce                	mv	a1,s3
 45a:	854a                	mv	a0,s2
 45c:	00000097          	auipc	ra,0x0
 460:	ba4080e7          	jalr	-1116(ra) # 0 <main>
 464:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 466:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 468:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 46a:	00001a97          	auipc	s5,0x1
 46e:	906a8a93          	addi	s5,s5,-1786 # d70 <malloc+0x21c>
 472:	a03d                	j	4a0 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 474:	07a1                	addi	a5,a5,8
 476:	00978963          	beq	a5,s1,488 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 47a:	6398                	ld	a4,0(a5)
 47c:	df65                	beqz	a4,474 <_main+0x86>
 47e:	5f38                	lw	a4,120(a4)
 480:	ff370ae3          	beq	a4,s3,474 <_main+0x86>
                running_threads++;
 484:	2905                	addiw	s2,s2,1
 486:	b7fd                	j	474 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 488:	85ca                	mv	a1,s2
 48a:	8556                	mv	a0,s5
 48c:	00000097          	auipc	ra,0x0
 490:	610080e7          	jalr	1552(ra) # a9c <printf>
        if (running_threads > 0) {
 494:	01205963          	blez	s2,4a6 <_main+0xb8>
            tsched(); // Schedule another thread to run
 498:	00000097          	auipc	ra,0x0
 49c:	ce8080e7          	jalr	-792(ra) # 180 <tsched>
    current_thread = main_thread;
 4a0:	87d2                	mv	a5,s4
        running_threads = 0;
 4a2:	895a                	mv	s2,s6
 4a4:	bfd9                	j	47a <_main+0x8c>
        }
    }

    exit(res);
 4a6:	855e                	mv	a0,s7
 4a8:	00000097          	auipc	ra,0x0
 4ac:	274080e7          	jalr	628(ra) # 71c <exit>

00000000000004b0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e422                	sd	s0,8(sp)
 4b4:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4b6:	87aa                	mv	a5,a0
 4b8:	0585                	addi	a1,a1,1
 4ba:	0785                	addi	a5,a5,1
 4bc:	fff5c703          	lbu	a4,-1(a1)
 4c0:	fee78fa3          	sb	a4,-1(a5)
 4c4:	fb75                	bnez	a4,4b8 <strcpy+0x8>
        ;
    return os;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <strcmp>:

int strcmp(const char *p, const char *q)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e422                	sd	s0,8(sp)
 4d0:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4d2:	00054783          	lbu	a5,0(a0)
 4d6:	cb91                	beqz	a5,4ea <strcmp+0x1e>
 4d8:	0005c703          	lbu	a4,0(a1)
 4dc:	00f71763          	bne	a4,a5,4ea <strcmp+0x1e>
        p++, q++;
 4e0:	0505                	addi	a0,a0,1
 4e2:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4e4:	00054783          	lbu	a5,0(a0)
 4e8:	fbe5                	bnez	a5,4d8 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4ea:	0005c503          	lbu	a0,0(a1)
}
 4ee:	40a7853b          	subw	a0,a5,a0
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <strlen>:

uint strlen(const char *s)
{
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e422                	sd	s0,8(sp)
 4fc:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4fe:	00054783          	lbu	a5,0(a0)
 502:	cf91                	beqz	a5,51e <strlen+0x26>
 504:	0505                	addi	a0,a0,1
 506:	87aa                	mv	a5,a0
 508:	86be                	mv	a3,a5
 50a:	0785                	addi	a5,a5,1
 50c:	fff7c703          	lbu	a4,-1(a5)
 510:	ff65                	bnez	a4,508 <strlen+0x10>
 512:	40a6853b          	subw	a0,a3,a0
 516:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 518:	6422                	ld	s0,8(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret
    for (n = 0; s[n]; n++)
 51e:	4501                	li	a0,0
 520:	bfe5                	j	518 <strlen+0x20>

0000000000000522 <memset>:

void *
memset(void *dst, int c, uint n)
{
 522:	1141                	addi	sp,sp,-16
 524:	e422                	sd	s0,8(sp)
 526:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 528:	ca19                	beqz	a2,53e <memset+0x1c>
 52a:	87aa                	mv	a5,a0
 52c:	1602                	slli	a2,a2,0x20
 52e:	9201                	srli	a2,a2,0x20
 530:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 534:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 538:	0785                	addi	a5,a5,1
 53a:	fee79de3          	bne	a5,a4,534 <memset+0x12>
    }
    return dst;
}
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	addi	sp,sp,16
 542:	8082                	ret

0000000000000544 <strchr>:

char *
strchr(const char *s, char c)
{
 544:	1141                	addi	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	addi	s0,sp,16
    for (; *s; s++)
 54a:	00054783          	lbu	a5,0(a0)
 54e:	cb99                	beqz	a5,564 <strchr+0x20>
        if (*s == c)
 550:	00f58763          	beq	a1,a5,55e <strchr+0x1a>
    for (; *s; s++)
 554:	0505                	addi	a0,a0,1
 556:	00054783          	lbu	a5,0(a0)
 55a:	fbfd                	bnez	a5,550 <strchr+0xc>
            return (char *)s;
    return 0;
 55c:	4501                	li	a0,0
}
 55e:	6422                	ld	s0,8(sp)
 560:	0141                	addi	sp,sp,16
 562:	8082                	ret
    return 0;
 564:	4501                	li	a0,0
 566:	bfe5                	j	55e <strchr+0x1a>

0000000000000568 <gets>:

char *
gets(char *buf, int max)
{
 568:	711d                	addi	sp,sp,-96
 56a:	ec86                	sd	ra,88(sp)
 56c:	e8a2                	sd	s0,80(sp)
 56e:	e4a6                	sd	s1,72(sp)
 570:	e0ca                	sd	s2,64(sp)
 572:	fc4e                	sd	s3,56(sp)
 574:	f852                	sd	s4,48(sp)
 576:	f456                	sd	s5,40(sp)
 578:	f05a                	sd	s6,32(sp)
 57a:	ec5e                	sd	s7,24(sp)
 57c:	1080                	addi	s0,sp,96
 57e:	8baa                	mv	s7,a0
 580:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 582:	892a                	mv	s2,a0
 584:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 586:	4aa9                	li	s5,10
 588:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 58a:	89a6                	mv	s3,s1
 58c:	2485                	addiw	s1,s1,1
 58e:	0344d863          	bge	s1,s4,5be <gets+0x56>
        cc = read(0, &c, 1);
 592:	4605                	li	a2,1
 594:	faf40593          	addi	a1,s0,-81
 598:	4501                	li	a0,0
 59a:	00000097          	auipc	ra,0x0
 59e:	19a080e7          	jalr	410(ra) # 734 <read>
        if (cc < 1)
 5a2:	00a05e63          	blez	a0,5be <gets+0x56>
        buf[i++] = c;
 5a6:	faf44783          	lbu	a5,-81(s0)
 5aa:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5ae:	01578763          	beq	a5,s5,5bc <gets+0x54>
 5b2:	0905                	addi	s2,s2,1
 5b4:	fd679be3          	bne	a5,s6,58a <gets+0x22>
    for (i = 0; i + 1 < max;)
 5b8:	89a6                	mv	s3,s1
 5ba:	a011                	j	5be <gets+0x56>
 5bc:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5be:	99de                	add	s3,s3,s7
 5c0:	00098023          	sb	zero,0(s3)
    return buf;
}
 5c4:	855e                	mv	a0,s7
 5c6:	60e6                	ld	ra,88(sp)
 5c8:	6446                	ld	s0,80(sp)
 5ca:	64a6                	ld	s1,72(sp)
 5cc:	6906                	ld	s2,64(sp)
 5ce:	79e2                	ld	s3,56(sp)
 5d0:	7a42                	ld	s4,48(sp)
 5d2:	7aa2                	ld	s5,40(sp)
 5d4:	7b02                	ld	s6,32(sp)
 5d6:	6be2                	ld	s7,24(sp)
 5d8:	6125                	addi	sp,sp,96
 5da:	8082                	ret

00000000000005dc <stat>:

int stat(const char *n, struct stat *st)
{
 5dc:	1101                	addi	sp,sp,-32
 5de:	ec06                	sd	ra,24(sp)
 5e0:	e822                	sd	s0,16(sp)
 5e2:	e426                	sd	s1,8(sp)
 5e4:	e04a                	sd	s2,0(sp)
 5e6:	1000                	addi	s0,sp,32
 5e8:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5ea:	4581                	li	a1,0
 5ec:	00000097          	auipc	ra,0x0
 5f0:	170080e7          	jalr	368(ra) # 75c <open>
    if (fd < 0)
 5f4:	02054563          	bltz	a0,61e <stat+0x42>
 5f8:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5fa:	85ca                	mv	a1,s2
 5fc:	00000097          	auipc	ra,0x0
 600:	178080e7          	jalr	376(ra) # 774 <fstat>
 604:	892a                	mv	s2,a0
    close(fd);
 606:	8526                	mv	a0,s1
 608:	00000097          	auipc	ra,0x0
 60c:	13c080e7          	jalr	316(ra) # 744 <close>
    return r;
}
 610:	854a                	mv	a0,s2
 612:	60e2                	ld	ra,24(sp)
 614:	6442                	ld	s0,16(sp)
 616:	64a2                	ld	s1,8(sp)
 618:	6902                	ld	s2,0(sp)
 61a:	6105                	addi	sp,sp,32
 61c:	8082                	ret
        return -1;
 61e:	597d                	li	s2,-1
 620:	bfc5                	j	610 <stat+0x34>

0000000000000622 <atoi>:

int atoi(const char *s)
{
 622:	1141                	addi	sp,sp,-16
 624:	e422                	sd	s0,8(sp)
 626:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 628:	00054683          	lbu	a3,0(a0)
 62c:	fd06879b          	addiw	a5,a3,-48
 630:	0ff7f793          	zext.b	a5,a5
 634:	4625                	li	a2,9
 636:	02f66863          	bltu	a2,a5,666 <atoi+0x44>
 63a:	872a                	mv	a4,a0
    n = 0;
 63c:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 63e:	0705                	addi	a4,a4,1
 640:	0025179b          	slliw	a5,a0,0x2
 644:	9fa9                	addw	a5,a5,a0
 646:	0017979b          	slliw	a5,a5,0x1
 64a:	9fb5                	addw	a5,a5,a3
 64c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 650:	00074683          	lbu	a3,0(a4)
 654:	fd06879b          	addiw	a5,a3,-48
 658:	0ff7f793          	zext.b	a5,a5
 65c:	fef671e3          	bgeu	a2,a5,63e <atoi+0x1c>
    return n;
}
 660:	6422                	ld	s0,8(sp)
 662:	0141                	addi	sp,sp,16
 664:	8082                	ret
    n = 0;
 666:	4501                	li	a0,0
 668:	bfe5                	j	660 <atoi+0x3e>

000000000000066a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 66a:	1141                	addi	sp,sp,-16
 66c:	e422                	sd	s0,8(sp)
 66e:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 670:	02b57463          	bgeu	a0,a1,698 <memmove+0x2e>
    {
        while (n-- > 0)
 674:	00c05f63          	blez	a2,692 <memmove+0x28>
 678:	1602                	slli	a2,a2,0x20
 67a:	9201                	srli	a2,a2,0x20
 67c:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 680:	872a                	mv	a4,a0
            *dst++ = *src++;
 682:	0585                	addi	a1,a1,1
 684:	0705                	addi	a4,a4,1
 686:	fff5c683          	lbu	a3,-1(a1)
 68a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 68e:	fee79ae3          	bne	a5,a4,682 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 692:	6422                	ld	s0,8(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret
        dst += n;
 698:	00c50733          	add	a4,a0,a2
        src += n;
 69c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 69e:	fec05ae3          	blez	a2,692 <memmove+0x28>
 6a2:	fff6079b          	addiw	a5,a2,-1
 6a6:	1782                	slli	a5,a5,0x20
 6a8:	9381                	srli	a5,a5,0x20
 6aa:	fff7c793          	not	a5,a5
 6ae:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6b0:	15fd                	addi	a1,a1,-1
 6b2:	177d                	addi	a4,a4,-1
 6b4:	0005c683          	lbu	a3,0(a1)
 6b8:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6bc:	fee79ae3          	bne	a5,a4,6b0 <memmove+0x46>
 6c0:	bfc9                	j	692 <memmove+0x28>

00000000000006c2 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6c2:	1141                	addi	sp,sp,-16
 6c4:	e422                	sd	s0,8(sp)
 6c6:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6c8:	ca05                	beqz	a2,6f8 <memcmp+0x36>
 6ca:	fff6069b          	addiw	a3,a2,-1
 6ce:	1682                	slli	a3,a3,0x20
 6d0:	9281                	srli	a3,a3,0x20
 6d2:	0685                	addi	a3,a3,1
 6d4:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6d6:	00054783          	lbu	a5,0(a0)
 6da:	0005c703          	lbu	a4,0(a1)
 6de:	00e79863          	bne	a5,a4,6ee <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6e2:	0505                	addi	a0,a0,1
        p2++;
 6e4:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6e6:	fed518e3          	bne	a0,a3,6d6 <memcmp+0x14>
    }
    return 0;
 6ea:	4501                	li	a0,0
 6ec:	a019                	j	6f2 <memcmp+0x30>
            return *p1 - *p2;
 6ee:	40e7853b          	subw	a0,a5,a4
}
 6f2:	6422                	ld	s0,8(sp)
 6f4:	0141                	addi	sp,sp,16
 6f6:	8082                	ret
    return 0;
 6f8:	4501                	li	a0,0
 6fa:	bfe5                	j	6f2 <memcmp+0x30>

00000000000006fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6fc:	1141                	addi	sp,sp,-16
 6fe:	e406                	sd	ra,8(sp)
 700:	e022                	sd	s0,0(sp)
 702:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 704:	00000097          	auipc	ra,0x0
 708:	f66080e7          	jalr	-154(ra) # 66a <memmove>
}
 70c:	60a2                	ld	ra,8(sp)
 70e:	6402                	ld	s0,0(sp)
 710:	0141                	addi	sp,sp,16
 712:	8082                	ret

0000000000000714 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 714:	4885                	li	a7,1
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <exit>:
.global exit
exit:
 li a7, SYS_exit
 71c:	4889                	li	a7,2
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <wait>:
.global wait
wait:
 li a7, SYS_wait
 724:	488d                	li	a7,3
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 72c:	4891                	li	a7,4
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <read>:
.global read
read:
 li a7, SYS_read
 734:	4895                	li	a7,5
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <write>:
.global write
write:
 li a7, SYS_write
 73c:	48c1                	li	a7,16
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <close>:
.global close
close:
 li a7, SYS_close
 744:	48d5                	li	a7,21
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <kill>:
.global kill
kill:
 li a7, SYS_kill
 74c:	4899                	li	a7,6
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <exec>:
.global exec
exec:
 li a7, SYS_exec
 754:	489d                	li	a7,7
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <open>:
.global open
open:
 li a7, SYS_open
 75c:	48bd                	li	a7,15
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 764:	48c5                	li	a7,17
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 76c:	48c9                	li	a7,18
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 774:	48a1                	li	a7,8
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <link>:
.global link
link:
 li a7, SYS_link
 77c:	48cd                	li	a7,19
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 784:	48d1                	li	a7,20
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 78c:	48a5                	li	a7,9
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <dup>:
.global dup
dup:
 li a7, SYS_dup
 794:	48a9                	li	a7,10
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 79c:	48ad                	li	a7,11
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7a4:	48b1                	li	a7,12
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7ac:	48b5                	li	a7,13
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7b4:	48b9                	li	a7,14
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <ps>:
.global ps
ps:
 li a7, SYS_ps
 7bc:	48d9                	li	a7,22
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7c4:	48dd                	li	a7,23
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7cc:	48e1                	li	a7,24
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7d4:	1101                	addi	sp,sp,-32
 7d6:	ec06                	sd	ra,24(sp)
 7d8:	e822                	sd	s0,16(sp)
 7da:	1000                	addi	s0,sp,32
 7dc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7e0:	4605                	li	a2,1
 7e2:	fef40593          	addi	a1,s0,-17
 7e6:	00000097          	auipc	ra,0x0
 7ea:	f56080e7          	jalr	-170(ra) # 73c <write>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6105                	addi	sp,sp,32
 7f4:	8082                	ret

00000000000007f6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7f6:	7139                	addi	sp,sp,-64
 7f8:	fc06                	sd	ra,56(sp)
 7fa:	f822                	sd	s0,48(sp)
 7fc:	f426                	sd	s1,40(sp)
 7fe:	f04a                	sd	s2,32(sp)
 800:	ec4e                	sd	s3,24(sp)
 802:	0080                	addi	s0,sp,64
 804:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 806:	c299                	beqz	a3,80c <printint+0x16>
 808:	0805c963          	bltz	a1,89a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 80c:	2581                	sext.w	a1,a1
  neg = 0;
 80e:	4881                	li	a7,0
 810:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 814:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 816:	2601                	sext.w	a2,a2
 818:	00000517          	auipc	a0,0x0
 81c:	5d850513          	addi	a0,a0,1496 # df0 <digits>
 820:	883a                	mv	a6,a4
 822:	2705                	addiw	a4,a4,1
 824:	02c5f7bb          	remuw	a5,a1,a2
 828:	1782                	slli	a5,a5,0x20
 82a:	9381                	srli	a5,a5,0x20
 82c:	97aa                	add	a5,a5,a0
 82e:	0007c783          	lbu	a5,0(a5)
 832:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 836:	0005879b          	sext.w	a5,a1
 83a:	02c5d5bb          	divuw	a1,a1,a2
 83e:	0685                	addi	a3,a3,1
 840:	fec7f0e3          	bgeu	a5,a2,820 <printint+0x2a>
  if(neg)
 844:	00088c63          	beqz	a7,85c <printint+0x66>
    buf[i++] = '-';
 848:	fd070793          	addi	a5,a4,-48
 84c:	00878733          	add	a4,a5,s0
 850:	02d00793          	li	a5,45
 854:	fef70823          	sb	a5,-16(a4)
 858:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 85c:	02e05863          	blez	a4,88c <printint+0x96>
 860:	fc040793          	addi	a5,s0,-64
 864:	00e78933          	add	s2,a5,a4
 868:	fff78993          	addi	s3,a5,-1
 86c:	99ba                	add	s3,s3,a4
 86e:	377d                	addiw	a4,a4,-1
 870:	1702                	slli	a4,a4,0x20
 872:	9301                	srli	a4,a4,0x20
 874:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 878:	fff94583          	lbu	a1,-1(s2)
 87c:	8526                	mv	a0,s1
 87e:	00000097          	auipc	ra,0x0
 882:	f56080e7          	jalr	-170(ra) # 7d4 <putc>
  while(--i >= 0)
 886:	197d                	addi	s2,s2,-1
 888:	ff3918e3          	bne	s2,s3,878 <printint+0x82>
}
 88c:	70e2                	ld	ra,56(sp)
 88e:	7442                	ld	s0,48(sp)
 890:	74a2                	ld	s1,40(sp)
 892:	7902                	ld	s2,32(sp)
 894:	69e2                	ld	s3,24(sp)
 896:	6121                	addi	sp,sp,64
 898:	8082                	ret
    x = -xx;
 89a:	40b005bb          	negw	a1,a1
    neg = 1;
 89e:	4885                	li	a7,1
    x = -xx;
 8a0:	bf85                	j	810 <printint+0x1a>

00000000000008a2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8a2:	715d                	addi	sp,sp,-80
 8a4:	e486                	sd	ra,72(sp)
 8a6:	e0a2                	sd	s0,64(sp)
 8a8:	fc26                	sd	s1,56(sp)
 8aa:	f84a                	sd	s2,48(sp)
 8ac:	f44e                	sd	s3,40(sp)
 8ae:	f052                	sd	s4,32(sp)
 8b0:	ec56                	sd	s5,24(sp)
 8b2:	e85a                	sd	s6,16(sp)
 8b4:	e45e                	sd	s7,8(sp)
 8b6:	e062                	sd	s8,0(sp)
 8b8:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8ba:	0005c903          	lbu	s2,0(a1)
 8be:	18090c63          	beqz	s2,a56 <vprintf+0x1b4>
 8c2:	8aaa                	mv	s5,a0
 8c4:	8bb2                	mv	s7,a2
 8c6:	00158493          	addi	s1,a1,1
  state = 0;
 8ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8cc:	02500a13          	li	s4,37
 8d0:	4b55                	li	s6,21
 8d2:	a839                	j	8f0 <vprintf+0x4e>
        putc(fd, c);
 8d4:	85ca                	mv	a1,s2
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	efc080e7          	jalr	-260(ra) # 7d4 <putc>
 8e0:	a019                	j	8e6 <vprintf+0x44>
    } else if(state == '%'){
 8e2:	01498d63          	beq	s3,s4,8fc <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8e6:	0485                	addi	s1,s1,1
 8e8:	fff4c903          	lbu	s2,-1(s1)
 8ec:	16090563          	beqz	s2,a56 <vprintf+0x1b4>
    if(state == 0){
 8f0:	fe0999e3          	bnez	s3,8e2 <vprintf+0x40>
      if(c == '%'){
 8f4:	ff4910e3          	bne	s2,s4,8d4 <vprintf+0x32>
        state = '%';
 8f8:	89d2                	mv	s3,s4
 8fa:	b7f5                	j	8e6 <vprintf+0x44>
      if(c == 'd'){
 8fc:	13490263          	beq	s2,s4,a20 <vprintf+0x17e>
 900:	f9d9079b          	addiw	a5,s2,-99
 904:	0ff7f793          	zext.b	a5,a5
 908:	12fb6563          	bltu	s6,a5,a32 <vprintf+0x190>
 90c:	f9d9079b          	addiw	a5,s2,-99
 910:	0ff7f713          	zext.b	a4,a5
 914:	10eb6f63          	bltu	s6,a4,a32 <vprintf+0x190>
 918:	00271793          	slli	a5,a4,0x2
 91c:	00000717          	auipc	a4,0x0
 920:	47c70713          	addi	a4,a4,1148 # d98 <malloc+0x244>
 924:	97ba                	add	a5,a5,a4
 926:	439c                	lw	a5,0(a5)
 928:	97ba                	add	a5,a5,a4
 92a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 92c:	008b8913          	addi	s2,s7,8
 930:	4685                	li	a3,1
 932:	4629                	li	a2,10
 934:	000ba583          	lw	a1,0(s7)
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	ebc080e7          	jalr	-324(ra) # 7f6 <printint>
 942:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 944:	4981                	li	s3,0
 946:	b745                	j	8e6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 948:	008b8913          	addi	s2,s7,8
 94c:	4681                	li	a3,0
 94e:	4629                	li	a2,10
 950:	000ba583          	lw	a1,0(s7)
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	ea0080e7          	jalr	-352(ra) # 7f6 <printint>
 95e:	8bca                	mv	s7,s2
      state = 0;
 960:	4981                	li	s3,0
 962:	b751                	j	8e6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 964:	008b8913          	addi	s2,s7,8
 968:	4681                	li	a3,0
 96a:	4641                	li	a2,16
 96c:	000ba583          	lw	a1,0(s7)
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	e84080e7          	jalr	-380(ra) # 7f6 <printint>
 97a:	8bca                	mv	s7,s2
      state = 0;
 97c:	4981                	li	s3,0
 97e:	b7a5                	j	8e6 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 980:	008b8c13          	addi	s8,s7,8
 984:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 988:	03000593          	li	a1,48
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	e46080e7          	jalr	-442(ra) # 7d4 <putc>
  putc(fd, 'x');
 996:	07800593          	li	a1,120
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	e38080e7          	jalr	-456(ra) # 7d4 <putc>
 9a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9a6:	00000b97          	auipc	s7,0x0
 9aa:	44ab8b93          	addi	s7,s7,1098 # df0 <digits>
 9ae:	03c9d793          	srli	a5,s3,0x3c
 9b2:	97de                	add	a5,a5,s7
 9b4:	0007c583          	lbu	a1,0(a5)
 9b8:	8556                	mv	a0,s5
 9ba:	00000097          	auipc	ra,0x0
 9be:	e1a080e7          	jalr	-486(ra) # 7d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9c2:	0992                	slli	s3,s3,0x4
 9c4:	397d                	addiw	s2,s2,-1
 9c6:	fe0914e3          	bnez	s2,9ae <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9ca:	8be2                	mv	s7,s8
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	bf21                	j	8e6 <vprintf+0x44>
        s = va_arg(ap, char*);
 9d0:	008b8993          	addi	s3,s7,8
 9d4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9d8:	02090163          	beqz	s2,9fa <vprintf+0x158>
        while(*s != 0){
 9dc:	00094583          	lbu	a1,0(s2)
 9e0:	c9a5                	beqz	a1,a50 <vprintf+0x1ae>
          putc(fd, *s);
 9e2:	8556                	mv	a0,s5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	df0080e7          	jalr	-528(ra) # 7d4 <putc>
          s++;
 9ec:	0905                	addi	s2,s2,1
        while(*s != 0){
 9ee:	00094583          	lbu	a1,0(s2)
 9f2:	f9e5                	bnez	a1,9e2 <vprintf+0x140>
        s = va_arg(ap, char*);
 9f4:	8bce                	mv	s7,s3
      state = 0;
 9f6:	4981                	li	s3,0
 9f8:	b5fd                	j	8e6 <vprintf+0x44>
          s = "(null)";
 9fa:	00000917          	auipc	s2,0x0
 9fe:	39690913          	addi	s2,s2,918 # d90 <malloc+0x23c>
        while(*s != 0){
 a02:	02800593          	li	a1,40
 a06:	bff1                	j	9e2 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a08:	008b8913          	addi	s2,s7,8
 a0c:	000bc583          	lbu	a1,0(s7)
 a10:	8556                	mv	a0,s5
 a12:	00000097          	auipc	ra,0x0
 a16:	dc2080e7          	jalr	-574(ra) # 7d4 <putc>
 a1a:	8bca                	mv	s7,s2
      state = 0;
 a1c:	4981                	li	s3,0
 a1e:	b5e1                	j	8e6 <vprintf+0x44>
        putc(fd, c);
 a20:	02500593          	li	a1,37
 a24:	8556                	mv	a0,s5
 a26:	00000097          	auipc	ra,0x0
 a2a:	dae080e7          	jalr	-594(ra) # 7d4 <putc>
      state = 0;
 a2e:	4981                	li	s3,0
 a30:	bd5d                	j	8e6 <vprintf+0x44>
        putc(fd, '%');
 a32:	02500593          	li	a1,37
 a36:	8556                	mv	a0,s5
 a38:	00000097          	auipc	ra,0x0
 a3c:	d9c080e7          	jalr	-612(ra) # 7d4 <putc>
        putc(fd, c);
 a40:	85ca                	mv	a1,s2
 a42:	8556                	mv	a0,s5
 a44:	00000097          	auipc	ra,0x0
 a48:	d90080e7          	jalr	-624(ra) # 7d4 <putc>
      state = 0;
 a4c:	4981                	li	s3,0
 a4e:	bd61                	j	8e6 <vprintf+0x44>
        s = va_arg(ap, char*);
 a50:	8bce                	mv	s7,s3
      state = 0;
 a52:	4981                	li	s3,0
 a54:	bd49                	j	8e6 <vprintf+0x44>
    }
  }
}
 a56:	60a6                	ld	ra,72(sp)
 a58:	6406                	ld	s0,64(sp)
 a5a:	74e2                	ld	s1,56(sp)
 a5c:	7942                	ld	s2,48(sp)
 a5e:	79a2                	ld	s3,40(sp)
 a60:	7a02                	ld	s4,32(sp)
 a62:	6ae2                	ld	s5,24(sp)
 a64:	6b42                	ld	s6,16(sp)
 a66:	6ba2                	ld	s7,8(sp)
 a68:	6c02                	ld	s8,0(sp)
 a6a:	6161                	addi	sp,sp,80
 a6c:	8082                	ret

0000000000000a6e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a6e:	715d                	addi	sp,sp,-80
 a70:	ec06                	sd	ra,24(sp)
 a72:	e822                	sd	s0,16(sp)
 a74:	1000                	addi	s0,sp,32
 a76:	e010                	sd	a2,0(s0)
 a78:	e414                	sd	a3,8(s0)
 a7a:	e818                	sd	a4,16(s0)
 a7c:	ec1c                	sd	a5,24(s0)
 a7e:	03043023          	sd	a6,32(s0)
 a82:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a86:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a8a:	8622                	mv	a2,s0
 a8c:	00000097          	auipc	ra,0x0
 a90:	e16080e7          	jalr	-490(ra) # 8a2 <vprintf>
}
 a94:	60e2                	ld	ra,24(sp)
 a96:	6442                	ld	s0,16(sp)
 a98:	6161                	addi	sp,sp,80
 a9a:	8082                	ret

0000000000000a9c <printf>:

void
printf(const char *fmt, ...)
{
 a9c:	711d                	addi	sp,sp,-96
 a9e:	ec06                	sd	ra,24(sp)
 aa0:	e822                	sd	s0,16(sp)
 aa2:	1000                	addi	s0,sp,32
 aa4:	e40c                	sd	a1,8(s0)
 aa6:	e810                	sd	a2,16(s0)
 aa8:	ec14                	sd	a3,24(s0)
 aaa:	f018                	sd	a4,32(s0)
 aac:	f41c                	sd	a5,40(s0)
 aae:	03043823          	sd	a6,48(s0)
 ab2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab6:	00840613          	addi	a2,s0,8
 aba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 abe:	85aa                	mv	a1,a0
 ac0:	4505                	li	a0,1
 ac2:	00000097          	auipc	ra,0x0
 ac6:	de0080e7          	jalr	-544(ra) # 8a2 <vprintf>
}
 aca:	60e2                	ld	ra,24(sp)
 acc:	6442                	ld	s0,16(sp)
 ace:	6125                	addi	sp,sp,96
 ad0:	8082                	ret

0000000000000ad2 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ad2:	1141                	addi	sp,sp,-16
 ad4:	e422                	sd	s0,8(sp)
 ad6:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 ad8:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 adc:	00000797          	auipc	a5,0x0
 ae0:	53c7b783          	ld	a5,1340(a5) # 1018 <freep>
 ae4:	a02d                	j	b0e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ae6:	4618                	lw	a4,8(a2)
 ae8:	9f2d                	addw	a4,a4,a1
 aea:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aee:	6398                	ld	a4,0(a5)
 af0:	6310                	ld	a2,0(a4)
 af2:	a83d                	j	b30 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 af4:	ff852703          	lw	a4,-8(a0)
 af8:	9f31                	addw	a4,a4,a2
 afa:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 afc:	ff053683          	ld	a3,-16(a0)
 b00:	a091                	j	b44 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b02:	6398                	ld	a4,0(a5)
 b04:	00e7e463          	bltu	a5,a4,b0c <free+0x3a>
 b08:	00e6ea63          	bltu	a3,a4,b1c <free+0x4a>
{
 b0c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0e:	fed7fae3          	bgeu	a5,a3,b02 <free+0x30>
 b12:	6398                	ld	a4,0(a5)
 b14:	00e6e463          	bltu	a3,a4,b1c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	fee7eae3          	bltu	a5,a4,b0c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b1c:	ff852583          	lw	a1,-8(a0)
 b20:	6390                	ld	a2,0(a5)
 b22:	02059813          	slli	a6,a1,0x20
 b26:	01c85713          	srli	a4,a6,0x1c
 b2a:	9736                	add	a4,a4,a3
 b2c:	fae60de3          	beq	a2,a4,ae6 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b30:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b34:	4790                	lw	a2,8(a5)
 b36:	02061593          	slli	a1,a2,0x20
 b3a:	01c5d713          	srli	a4,a1,0x1c
 b3e:	973e                	add	a4,a4,a5
 b40:	fae68ae3          	beq	a3,a4,af4 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b44:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b46:	00000717          	auipc	a4,0x0
 b4a:	4cf73923          	sd	a5,1234(a4) # 1018 <freep>
}
 b4e:	6422                	ld	s0,8(sp)
 b50:	0141                	addi	sp,sp,16
 b52:	8082                	ret

0000000000000b54 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b54:	7139                	addi	sp,sp,-64
 b56:	fc06                	sd	ra,56(sp)
 b58:	f822                	sd	s0,48(sp)
 b5a:	f426                	sd	s1,40(sp)
 b5c:	f04a                	sd	s2,32(sp)
 b5e:	ec4e                	sd	s3,24(sp)
 b60:	e852                	sd	s4,16(sp)
 b62:	e456                	sd	s5,8(sp)
 b64:	e05a                	sd	s6,0(sp)
 b66:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b68:	02051493          	slli	s1,a0,0x20
 b6c:	9081                	srli	s1,s1,0x20
 b6e:	04bd                	addi	s1,s1,15
 b70:	8091                	srli	s1,s1,0x4
 b72:	0014899b          	addiw	s3,s1,1
 b76:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b78:	00000517          	auipc	a0,0x0
 b7c:	4a053503          	ld	a0,1184(a0) # 1018 <freep>
 b80:	c515                	beqz	a0,bac <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b82:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b84:	4798                	lw	a4,8(a5)
 b86:	02977f63          	bgeu	a4,s1,bc4 <malloc+0x70>
    if (nu < 4096)
 b8a:	8a4e                	mv	s4,s3
 b8c:	0009871b          	sext.w	a4,s3
 b90:	6685                	lui	a3,0x1
 b92:	00d77363          	bgeu	a4,a3,b98 <malloc+0x44>
 b96:	6a05                	lui	s4,0x1
 b98:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b9c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 ba0:	00000917          	auipc	s2,0x0
 ba4:	47890913          	addi	s2,s2,1144 # 1018 <freep>
    if (p == (char *)-1)
 ba8:	5afd                	li	s5,-1
 baa:	a895                	j	c1e <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bac:	00000797          	auipc	a5,0x0
 bb0:	4f478793          	addi	a5,a5,1268 # 10a0 <base>
 bb4:	00000717          	auipc	a4,0x0
 bb8:	46f73223          	sd	a5,1124(a4) # 1018 <freep>
 bbc:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bbe:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bc2:	b7e1                	j	b8a <malloc+0x36>
            if (p->s.size == nunits)
 bc4:	02e48c63          	beq	s1,a4,bfc <malloc+0xa8>
                p->s.size -= nunits;
 bc8:	4137073b          	subw	a4,a4,s3
 bcc:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bce:	02071693          	slli	a3,a4,0x20
 bd2:	01c6d713          	srli	a4,a3,0x1c
 bd6:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bd8:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bdc:	00000717          	auipc	a4,0x0
 be0:	42a73e23          	sd	a0,1084(a4) # 1018 <freep>
            return (void *)(p + 1);
 be4:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 be8:	70e2                	ld	ra,56(sp)
 bea:	7442                	ld	s0,48(sp)
 bec:	74a2                	ld	s1,40(sp)
 bee:	7902                	ld	s2,32(sp)
 bf0:	69e2                	ld	s3,24(sp)
 bf2:	6a42                	ld	s4,16(sp)
 bf4:	6aa2                	ld	s5,8(sp)
 bf6:	6b02                	ld	s6,0(sp)
 bf8:	6121                	addi	sp,sp,64
 bfa:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bfc:	6398                	ld	a4,0(a5)
 bfe:	e118                	sd	a4,0(a0)
 c00:	bff1                	j	bdc <malloc+0x88>
    hp->s.size = nu;
 c02:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c06:	0541                	addi	a0,a0,16
 c08:	00000097          	auipc	ra,0x0
 c0c:	eca080e7          	jalr	-310(ra) # ad2 <free>
    return freep;
 c10:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c14:	d971                	beqz	a0,be8 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c16:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c18:	4798                	lw	a4,8(a5)
 c1a:	fa9775e3          	bgeu	a4,s1,bc4 <malloc+0x70>
        if (p == freep)
 c1e:	00093703          	ld	a4,0(s2)
 c22:	853e                	mv	a0,a5
 c24:	fef719e3          	bne	a4,a5,c16 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c28:	8552                	mv	a0,s4
 c2a:	00000097          	auipc	ra,0x0
 c2e:	b7a080e7          	jalr	-1158(ra) # 7a4 <sbrk>
    if (p == (char *)-1)
 c32:	fd5518e3          	bne	a0,s5,c02 <malloc+0xae>
                return 0;
 c36:	4501                	li	a0,0
 c38:	bf45                	j	be8 <malloc+0x94>
