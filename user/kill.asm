
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
  2c:	5fe080e7          	jalr	1534(ra) # 626 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	720080e7          	jalr	1824(ra) # 750 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	6e0080e7          	jalr	1760(ra) # 720 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	bf858593          	addi	a1,a1,-1032 # c40 <malloc+0xe8>
  50:	4509                	li	a0,2
  52:	00001097          	auipc	ra,0x1
  56:	a20080e7          	jalr	-1504(ra) # a72 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	6c4080e7          	jalr	1732(ra) # 720 <exit>

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
  98:	2dc080e7          	jalr	732(ra) # 370 <twhoami>
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
  e4:	b7850513          	addi	a0,a0,-1160 # c58 <malloc+0x100>
  e8:	00001097          	auipc	ra,0x1
  ec:	9b8080e7          	jalr	-1608(ra) # aa0 <printf>
        exit(-1);
  f0:	557d                	li	a0,-1
  f2:	00000097          	auipc	ra,0x0
  f6:	62e080e7          	jalr	1582(ra) # 720 <exit>
    {
        // give up the cpu for other threads
        tyield();
  fa:	00000097          	auipc	ra,0x0
  fe:	252080e7          	jalr	594(ra) # 34c <tyield>
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
 118:	25c080e7          	jalr	604(ra) # 370 <twhoami>
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
 15c:	1f4080e7          	jalr	500(ra) # 34c <tyield>
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret
        printf("releasing lock we are not holding");
 16a:	00001517          	auipc	a0,0x1
 16e:	b1650513          	addi	a0,a0,-1258 # c80 <malloc+0x128>
 172:	00001097          	auipc	ra,0x1
 176:	92e080e7          	jalr	-1746(ra) # aa0 <printf>
        exit(-1);
 17a:	557d                	li	a0,-1
 17c:	00000097          	auipc	ra,0x0
 180:	5a4080e7          	jalr	1444(ra) # 720 <exit>

0000000000000184 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 184:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 186:	00001617          	auipc	a2,0x1
 18a:	e9a60613          	addi	a2,a2,-358 # 1020 <threads>
 18e:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 190:	45c1                	li	a1,16
 192:	a021                	j	19a <tsched+0x16>
 194:	2685                	addiw	a3,a3,1
 196:	08b68c63          	beq	a3,a1,22e <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 19a:	41f6d71b          	sraiw	a4,a3,0x1f
 19e:	01c7571b          	srliw	a4,a4,0x1c
 1a2:	00d707bb          	addw	a5,a4,a3
 1a6:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1a8:	9f99                	subw	a5,a5,a4
 1aa:	078e                	slli	a5,a5,0x3
 1ac:	97b2                	add	a5,a5,a2
 1ae:	639c                	ld	a5,0(a5)
 1b0:	d3f5                	beqz	a5,194 <tsched+0x10>
 1b2:	5fb8                	lw	a4,120(a5)
 1b4:	fea710e3          	bne	a4,a0,194 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1b8:	00001717          	auipc	a4,0x1
 1bc:	e6873703          	ld	a4,-408(a4) # 1020 <threads>
 1c0:	5f30                	lw	a2,120(a4)
 1c2:	468d                	li	a3,3
 1c4:	06d60363          	beq	a2,a3,22a <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1c8:	c3a5                	beqz	a5,228 <tsched+0xa4>
{
 1ca:	1101                	addi	sp,sp,-32
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e822                	sd	s0,16(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	e04a                	sd	s2,0(sp)
 1d4:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1d6:	00001497          	auipc	s1,0x1
 1da:	e3a48493          	addi	s1,s1,-454 # 1010 <current_thread>
 1de:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1e2:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1e4:	0007c603          	lbu	a2,0(a5)
 1e8:	00094583          	lbu	a1,0(s2)
 1ec:	00001517          	auipc	a0,0x1
 1f0:	abc50513          	addi	a0,a0,-1348 # ca8 <malloc+0x150>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	8ac080e7          	jalr	-1876(ra) # aa0 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1fc:	608c                	ld	a1,0(s1)
 1fe:	05a1                	addi	a1,a1,8
 200:	00890513          	addi	a0,s2,8
 204:	00000097          	auipc	ra,0x0
 208:	184080e7          	jalr	388(ra) # 388 <tswtch>
        printf("Thread switch complete\n");
 20c:	00001517          	auipc	a0,0x1
 210:	ac450513          	addi	a0,a0,-1340 # cd0 <malloc+0x178>
 214:	00001097          	auipc	ra,0x1
 218:	88c080e7          	jalr	-1908(ra) # aa0 <printf>
    }
}
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	64a2                	ld	s1,8(sp)
 222:	6902                	ld	s2,0(sp)
 224:	6105                	addi	sp,sp,32
 226:	8082                	ret
 228:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 22a:	87ba                	mv	a5,a4
 22c:	bf79                	j	1ca <tsched+0x46>
 22e:	00001797          	auipc	a5,0x1
 232:	df27b783          	ld	a5,-526(a5) # 1020 <threads>
 236:	5fb4                	lw	a3,120(a5)
 238:	470d                	li	a4,3
 23a:	f8e688e3          	beq	a3,a4,1ca <tsched+0x46>
 23e:	8082                	ret

0000000000000240 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 240:	7179                	addi	sp,sp,-48
 242:	f406                	sd	ra,40(sp)
 244:	f022                	sd	s0,32(sp)
 246:	ec26                	sd	s1,24(sp)
 248:	e84a                	sd	s2,16(sp)
 24a:	e44e                	sd	s3,8(sp)
 24c:	1800                	addi	s0,sp,48
 24e:	84aa                	mv	s1,a0
 250:	89b2                	mv	s3,a2
 252:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 254:	09000513          	li	a0,144
 258:	00001097          	auipc	ra,0x1
 25c:	900080e7          	jalr	-1792(ra) # b58 <malloc>
 260:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 262:	478d                	li	a5,3
 264:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 266:	609c                	ld	a5,0(s1)
 268:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 26c:	609c                	ld	a5,0(s1)
 26e:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 272:	00001717          	auipc	a4,0x1
 276:	d8e70713          	addi	a4,a4,-626 # 1000 <next_tid>
 27a:	431c                	lw	a5,0(a4)
 27c:	0017869b          	addiw	a3,a5,1
 280:	c314                	sw	a3,0(a4)
 282:	6098                	ld	a4,0(s1)
 284:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 288:	00001717          	auipc	a4,0x1
 28c:	d9870713          	addi	a4,a4,-616 # 1020 <threads>
 290:	4781                	li	a5,0
 292:	4641                	li	a2,16
    if (threads[i] == NULL) {
 294:	6314                	ld	a3,0(a4)
 296:	ce81                	beqz	a3,2ae <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 298:	2785                	addiw	a5,a5,1
 29a:	0721                	addi	a4,a4,8
 29c:	fec79ce3          	bne	a5,a2,294 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 2a0:	70a2                	ld	ra,40(sp)
 2a2:	7402                	ld	s0,32(sp)
 2a4:	64e2                	ld	s1,24(sp)
 2a6:	6942                	ld	s2,16(sp)
 2a8:	69a2                	ld	s3,8(sp)
 2aa:	6145                	addi	sp,sp,48
 2ac:	8082                	ret
        threads[i] = *thread;
 2ae:	6094                	ld	a3,0(s1)
 2b0:	078e                	slli	a5,a5,0x3
 2b2:	00001717          	auipc	a4,0x1
 2b6:	d6e70713          	addi	a4,a4,-658 # 1020 <threads>
 2ba:	97ba                	add	a5,a5,a4
 2bc:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2be:	0006c583          	lbu	a1,0(a3)
 2c2:	00001517          	auipc	a0,0x1
 2c6:	a2650513          	addi	a0,a0,-1498 # ce8 <malloc+0x190>
 2ca:	00000097          	auipc	ra,0x0
 2ce:	7d6080e7          	jalr	2006(ra) # aa0 <printf>
        break;
 2d2:	b7f9                	j	2a0 <tcreate+0x60>

00000000000002d4 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2d4:	7179                	addi	sp,sp,-48
 2d6:	f406                	sd	ra,40(sp)
 2d8:	f022                	sd	s0,32(sp)
 2da:	ec26                	sd	s1,24(sp)
 2dc:	e84a                	sd	s2,16(sp)
 2de:	e44e                	sd	s3,8(sp)
 2e0:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2e2:	00001797          	auipc	a5,0x1
 2e6:	d3e78793          	addi	a5,a5,-706 # 1020 <threads>
 2ea:	00001697          	auipc	a3,0x1
 2ee:	db668693          	addi	a3,a3,-586 # 10a0 <base>
 2f2:	a021                	j	2fa <tjoin+0x26>
 2f4:	07a1                	addi	a5,a5,8
 2f6:	04d78763          	beq	a5,a3,344 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2fa:	6384                	ld	s1,0(a5)
 2fc:	dce5                	beqz	s1,2f4 <tjoin+0x20>
 2fe:	0004c703          	lbu	a4,0(s1)
 302:	fea719e3          	bne	a4,a0,2f4 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 306:	5cb8                	lw	a4,120(s1)
 308:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 30a:	00001997          	auipc	s3,0x1
 30e:	a0e98993          	addi	s3,s3,-1522 # d18 <malloc+0x1c0>
    while (target_thread->state != EXITED) {
 312:	4919                	li	s2,6
 314:	02f70a63          	beq	a4,a5,348 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 318:	0004c583          	lbu	a1,0(s1)
 31c:	854e                	mv	a0,s3
 31e:	00000097          	auipc	ra,0x0
 322:	782080e7          	jalr	1922(ra) # aa0 <printf>
        tsched();
 326:	00000097          	auipc	ra,0x0
 32a:	e5e080e7          	jalr	-418(ra) # 184 <tsched>
    while (target_thread->state != EXITED) {
 32e:	5cbc                	lw	a5,120(s1)
 330:	ff2794e3          	bne	a5,s2,318 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 334:	4501                	li	a0,0
}
 336:	70a2                	ld	ra,40(sp)
 338:	7402                	ld	s0,32(sp)
 33a:	64e2                	ld	s1,24(sp)
 33c:	6942                	ld	s2,16(sp)
 33e:	69a2                	ld	s3,8(sp)
 340:	6145                	addi	sp,sp,48
 342:	8082                	ret
        return -1;
 344:	557d                	li	a0,-1
 346:	bfc5                	j	336 <tjoin+0x62>
    return 0;
 348:	4501                	li	a0,0
 34a:	b7f5                	j	336 <tjoin+0x62>

000000000000034c <tyield>:


void tyield()
{
 34c:	1141                	addi	sp,sp,-16
 34e:	e406                	sd	ra,8(sp)
 350:	e022                	sd	s0,0(sp)
 352:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 354:	00001797          	auipc	a5,0x1
 358:	cbc7b783          	ld	a5,-836(a5) # 1010 <current_thread>
 35c:	470d                	li	a4,3
 35e:	dfb8                	sw	a4,120(a5)
    tsched();
 360:	00000097          	auipc	ra,0x0
 364:	e24080e7          	jalr	-476(ra) # 184 <tsched>
}
 368:	60a2                	ld	ra,8(sp)
 36a:	6402                	ld	s0,0(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret

0000000000000370 <twhoami>:

uint8 twhoami()
{
 370:	1141                	addi	sp,sp,-16
 372:	e422                	sd	s0,8(sp)
 374:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 376:	00001797          	auipc	a5,0x1
 37a:	c9a7b783          	ld	a5,-870(a5) # 1010 <current_thread>
 37e:	0007c503          	lbu	a0,0(a5)
 382:	6422                	ld	s0,8(sp)
 384:	0141                	addi	sp,sp,16
 386:	8082                	ret

0000000000000388 <tswtch>:
 388:	00153023          	sd	ra,0(a0)
 38c:	00253423          	sd	sp,8(a0)
 390:	e900                	sd	s0,16(a0)
 392:	ed04                	sd	s1,24(a0)
 394:	03253023          	sd	s2,32(a0)
 398:	03353423          	sd	s3,40(a0)
 39c:	03453823          	sd	s4,48(a0)
 3a0:	03553c23          	sd	s5,56(a0)
 3a4:	05653023          	sd	s6,64(a0)
 3a8:	05753423          	sd	s7,72(a0)
 3ac:	05853823          	sd	s8,80(a0)
 3b0:	05953c23          	sd	s9,88(a0)
 3b4:	07a53023          	sd	s10,96(a0)
 3b8:	07b53423          	sd	s11,104(a0)
 3bc:	0005b083          	ld	ra,0(a1)
 3c0:	0085b103          	ld	sp,8(a1)
 3c4:	6980                	ld	s0,16(a1)
 3c6:	6d84                	ld	s1,24(a1)
 3c8:	0205b903          	ld	s2,32(a1)
 3cc:	0285b983          	ld	s3,40(a1)
 3d0:	0305ba03          	ld	s4,48(a1)
 3d4:	0385ba83          	ld	s5,56(a1)
 3d8:	0405bb03          	ld	s6,64(a1)
 3dc:	0485bb83          	ld	s7,72(a1)
 3e0:	0505bc03          	ld	s8,80(a1)
 3e4:	0585bc83          	ld	s9,88(a1)
 3e8:	0605bd03          	ld	s10,96(a1)
 3ec:	0685bd83          	ld	s11,104(a1)
 3f0:	8082                	ret

00000000000003f2 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3f2:	715d                	addi	sp,sp,-80
 3f4:	e486                	sd	ra,72(sp)
 3f6:	e0a2                	sd	s0,64(sp)
 3f8:	fc26                	sd	s1,56(sp)
 3fa:	f84a                	sd	s2,48(sp)
 3fc:	f44e                	sd	s3,40(sp)
 3fe:	f052                	sd	s4,32(sp)
 400:	ec56                	sd	s5,24(sp)
 402:	e85a                	sd	s6,16(sp)
 404:	e45e                	sd	s7,8(sp)
 406:	0880                	addi	s0,sp,80
 408:	892a                	mv	s2,a0
 40a:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 40c:	00001517          	auipc	a0,0x1
 410:	92c50513          	addi	a0,a0,-1748 # d38 <malloc+0x1e0>
 414:	00000097          	auipc	ra,0x0
 418:	68c080e7          	jalr	1676(ra) # aa0 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 41c:	09000513          	li	a0,144
 420:	00000097          	auipc	ra,0x0
 424:	738080e7          	jalr	1848(ra) # b58 <malloc>

    main_thread->tid = 0;
 428:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 42c:	4791                	li	a5,4
 42e:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 430:	00001797          	auipc	a5,0x1
 434:	bea7b023          	sd	a0,-1056(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 438:	00001a17          	auipc	s4,0x1
 43c:	be8a0a13          	addi	s4,s4,-1048 # 1020 <threads>
 440:	00001497          	auipc	s1,0x1
 444:	c6048493          	addi	s1,s1,-928 # 10a0 <base>
    current_thread = main_thread;
 448:	87d2                	mv	a5,s4
        threads[i] = NULL;
 44a:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 44e:	07a1                	addi	a5,a5,8
 450:	fe979de3          	bne	a5,s1,44a <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 454:	00001797          	auipc	a5,0x1
 458:	bca7b623          	sd	a0,-1076(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 45c:	85ce                	mv	a1,s3
 45e:	854a                	mv	a0,s2
 460:	00000097          	auipc	ra,0x0
 464:	ba0080e7          	jalr	-1120(ra) # 0 <main>
 468:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 46a:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 46c:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 46e:	00001a97          	auipc	s5,0x1
 472:	8eaa8a93          	addi	s5,s5,-1814 # d58 <malloc+0x200>
 476:	a03d                	j	4a4 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 478:	07a1                	addi	a5,a5,8
 47a:	00978963          	beq	a5,s1,48c <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 47e:	6398                	ld	a4,0(a5)
 480:	df65                	beqz	a4,478 <_main+0x86>
 482:	5f38                	lw	a4,120(a4)
 484:	ff370ae3          	beq	a4,s3,478 <_main+0x86>
                running_threads++;
 488:	2905                	addiw	s2,s2,1
 48a:	b7fd                	j	478 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 48c:	85ca                	mv	a1,s2
 48e:	8556                	mv	a0,s5
 490:	00000097          	auipc	ra,0x0
 494:	610080e7          	jalr	1552(ra) # aa0 <printf>
        if (running_threads > 0) {
 498:	01205963          	blez	s2,4aa <_main+0xb8>
            tsched(); // Schedule another thread to run
 49c:	00000097          	auipc	ra,0x0
 4a0:	ce8080e7          	jalr	-792(ra) # 184 <tsched>
    current_thread = main_thread;
 4a4:	87d2                	mv	a5,s4
        running_threads = 0;
 4a6:	895a                	mv	s2,s6
 4a8:	bfd9                	j	47e <_main+0x8c>
        }
    }

    exit(res);
 4aa:	855e                	mv	a0,s7
 4ac:	00000097          	auipc	ra,0x0
 4b0:	274080e7          	jalr	628(ra) # 720 <exit>

00000000000004b4 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e422                	sd	s0,8(sp)
 4b8:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4ba:	87aa                	mv	a5,a0
 4bc:	0585                	addi	a1,a1,1
 4be:	0785                	addi	a5,a5,1
 4c0:	fff5c703          	lbu	a4,-1(a1)
 4c4:	fee78fa3          	sb	a4,-1(a5)
 4c8:	fb75                	bnez	a4,4bc <strcpy+0x8>
        ;
    return os;
}
 4ca:	6422                	ld	s0,8(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret

00000000000004d0 <strcmp>:

int strcmp(const char *p, const char *q)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4d6:	00054783          	lbu	a5,0(a0)
 4da:	cb91                	beqz	a5,4ee <strcmp+0x1e>
 4dc:	0005c703          	lbu	a4,0(a1)
 4e0:	00f71763          	bne	a4,a5,4ee <strcmp+0x1e>
        p++, q++;
 4e4:	0505                	addi	a0,a0,1
 4e6:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4e8:	00054783          	lbu	a5,0(a0)
 4ec:	fbe5                	bnez	a5,4dc <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4ee:	0005c503          	lbu	a0,0(a1)
}
 4f2:	40a7853b          	subw	a0,a5,a0
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret

00000000000004fc <strlen>:

uint strlen(const char *s)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 502:	00054783          	lbu	a5,0(a0)
 506:	cf91                	beqz	a5,522 <strlen+0x26>
 508:	0505                	addi	a0,a0,1
 50a:	87aa                	mv	a5,a0
 50c:	86be                	mv	a3,a5
 50e:	0785                	addi	a5,a5,1
 510:	fff7c703          	lbu	a4,-1(a5)
 514:	ff65                	bnez	a4,50c <strlen+0x10>
 516:	40a6853b          	subw	a0,a3,a0
 51a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 51c:	6422                	ld	s0,8(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret
    for (n = 0; s[n]; n++)
 522:	4501                	li	a0,0
 524:	bfe5                	j	51c <strlen+0x20>

0000000000000526 <memset>:

void *
memset(void *dst, int c, uint n)
{
 526:	1141                	addi	sp,sp,-16
 528:	e422                	sd	s0,8(sp)
 52a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 52c:	ca19                	beqz	a2,542 <memset+0x1c>
 52e:	87aa                	mv	a5,a0
 530:	1602                	slli	a2,a2,0x20
 532:	9201                	srli	a2,a2,0x20
 534:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 538:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 53c:	0785                	addi	a5,a5,1
 53e:	fee79de3          	bne	a5,a4,538 <memset+0x12>
    }
    return dst;
}
 542:	6422                	ld	s0,8(sp)
 544:	0141                	addi	sp,sp,16
 546:	8082                	ret

0000000000000548 <strchr>:

char *
strchr(const char *s, char c)
{
 548:	1141                	addi	sp,sp,-16
 54a:	e422                	sd	s0,8(sp)
 54c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 54e:	00054783          	lbu	a5,0(a0)
 552:	cb99                	beqz	a5,568 <strchr+0x20>
        if (*s == c)
 554:	00f58763          	beq	a1,a5,562 <strchr+0x1a>
    for (; *s; s++)
 558:	0505                	addi	a0,a0,1
 55a:	00054783          	lbu	a5,0(a0)
 55e:	fbfd                	bnez	a5,554 <strchr+0xc>
            return (char *)s;
    return 0;
 560:	4501                	li	a0,0
}
 562:	6422                	ld	s0,8(sp)
 564:	0141                	addi	sp,sp,16
 566:	8082                	ret
    return 0;
 568:	4501                	li	a0,0
 56a:	bfe5                	j	562 <strchr+0x1a>

000000000000056c <gets>:

char *
gets(char *buf, int max)
{
 56c:	711d                	addi	sp,sp,-96
 56e:	ec86                	sd	ra,88(sp)
 570:	e8a2                	sd	s0,80(sp)
 572:	e4a6                	sd	s1,72(sp)
 574:	e0ca                	sd	s2,64(sp)
 576:	fc4e                	sd	s3,56(sp)
 578:	f852                	sd	s4,48(sp)
 57a:	f456                	sd	s5,40(sp)
 57c:	f05a                	sd	s6,32(sp)
 57e:	ec5e                	sd	s7,24(sp)
 580:	1080                	addi	s0,sp,96
 582:	8baa                	mv	s7,a0
 584:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 586:	892a                	mv	s2,a0
 588:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 58a:	4aa9                	li	s5,10
 58c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 58e:	89a6                	mv	s3,s1
 590:	2485                	addiw	s1,s1,1
 592:	0344d863          	bge	s1,s4,5c2 <gets+0x56>
        cc = read(0, &c, 1);
 596:	4605                	li	a2,1
 598:	faf40593          	addi	a1,s0,-81
 59c:	4501                	li	a0,0
 59e:	00000097          	auipc	ra,0x0
 5a2:	19a080e7          	jalr	410(ra) # 738 <read>
        if (cc < 1)
 5a6:	00a05e63          	blez	a0,5c2 <gets+0x56>
        buf[i++] = c;
 5aa:	faf44783          	lbu	a5,-81(s0)
 5ae:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5b2:	01578763          	beq	a5,s5,5c0 <gets+0x54>
 5b6:	0905                	addi	s2,s2,1
 5b8:	fd679be3          	bne	a5,s6,58e <gets+0x22>
    for (i = 0; i + 1 < max;)
 5bc:	89a6                	mv	s3,s1
 5be:	a011                	j	5c2 <gets+0x56>
 5c0:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5c2:	99de                	add	s3,s3,s7
 5c4:	00098023          	sb	zero,0(s3)
    return buf;
}
 5c8:	855e                	mv	a0,s7
 5ca:	60e6                	ld	ra,88(sp)
 5cc:	6446                	ld	s0,80(sp)
 5ce:	64a6                	ld	s1,72(sp)
 5d0:	6906                	ld	s2,64(sp)
 5d2:	79e2                	ld	s3,56(sp)
 5d4:	7a42                	ld	s4,48(sp)
 5d6:	7aa2                	ld	s5,40(sp)
 5d8:	7b02                	ld	s6,32(sp)
 5da:	6be2                	ld	s7,24(sp)
 5dc:	6125                	addi	sp,sp,96
 5de:	8082                	ret

00000000000005e0 <stat>:

int stat(const char *n, struct stat *st)
{
 5e0:	1101                	addi	sp,sp,-32
 5e2:	ec06                	sd	ra,24(sp)
 5e4:	e822                	sd	s0,16(sp)
 5e6:	e426                	sd	s1,8(sp)
 5e8:	e04a                	sd	s2,0(sp)
 5ea:	1000                	addi	s0,sp,32
 5ec:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5ee:	4581                	li	a1,0
 5f0:	00000097          	auipc	ra,0x0
 5f4:	170080e7          	jalr	368(ra) # 760 <open>
    if (fd < 0)
 5f8:	02054563          	bltz	a0,622 <stat+0x42>
 5fc:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5fe:	85ca                	mv	a1,s2
 600:	00000097          	auipc	ra,0x0
 604:	178080e7          	jalr	376(ra) # 778 <fstat>
 608:	892a                	mv	s2,a0
    close(fd);
 60a:	8526                	mv	a0,s1
 60c:	00000097          	auipc	ra,0x0
 610:	13c080e7          	jalr	316(ra) # 748 <close>
    return r;
}
 614:	854a                	mv	a0,s2
 616:	60e2                	ld	ra,24(sp)
 618:	6442                	ld	s0,16(sp)
 61a:	64a2                	ld	s1,8(sp)
 61c:	6902                	ld	s2,0(sp)
 61e:	6105                	addi	sp,sp,32
 620:	8082                	ret
        return -1;
 622:	597d                	li	s2,-1
 624:	bfc5                	j	614 <stat+0x34>

0000000000000626 <atoi>:

int atoi(const char *s)
{
 626:	1141                	addi	sp,sp,-16
 628:	e422                	sd	s0,8(sp)
 62a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 62c:	00054683          	lbu	a3,0(a0)
 630:	fd06879b          	addiw	a5,a3,-48
 634:	0ff7f793          	zext.b	a5,a5
 638:	4625                	li	a2,9
 63a:	02f66863          	bltu	a2,a5,66a <atoi+0x44>
 63e:	872a                	mv	a4,a0
    n = 0;
 640:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 642:	0705                	addi	a4,a4,1
 644:	0025179b          	slliw	a5,a0,0x2
 648:	9fa9                	addw	a5,a5,a0
 64a:	0017979b          	slliw	a5,a5,0x1
 64e:	9fb5                	addw	a5,a5,a3
 650:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 654:	00074683          	lbu	a3,0(a4)
 658:	fd06879b          	addiw	a5,a3,-48
 65c:	0ff7f793          	zext.b	a5,a5
 660:	fef671e3          	bgeu	a2,a5,642 <atoi+0x1c>
    return n;
}
 664:	6422                	ld	s0,8(sp)
 666:	0141                	addi	sp,sp,16
 668:	8082                	ret
    n = 0;
 66a:	4501                	li	a0,0
 66c:	bfe5                	j	664 <atoi+0x3e>

000000000000066e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 66e:	1141                	addi	sp,sp,-16
 670:	e422                	sd	s0,8(sp)
 672:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 674:	02b57463          	bgeu	a0,a1,69c <memmove+0x2e>
    {
        while (n-- > 0)
 678:	00c05f63          	blez	a2,696 <memmove+0x28>
 67c:	1602                	slli	a2,a2,0x20
 67e:	9201                	srli	a2,a2,0x20
 680:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 684:	872a                	mv	a4,a0
            *dst++ = *src++;
 686:	0585                	addi	a1,a1,1
 688:	0705                	addi	a4,a4,1
 68a:	fff5c683          	lbu	a3,-1(a1)
 68e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 692:	fee79ae3          	bne	a5,a4,686 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 696:	6422                	ld	s0,8(sp)
 698:	0141                	addi	sp,sp,16
 69a:	8082                	ret
        dst += n;
 69c:	00c50733          	add	a4,a0,a2
        src += n;
 6a0:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6a2:	fec05ae3          	blez	a2,696 <memmove+0x28>
 6a6:	fff6079b          	addiw	a5,a2,-1
 6aa:	1782                	slli	a5,a5,0x20
 6ac:	9381                	srli	a5,a5,0x20
 6ae:	fff7c793          	not	a5,a5
 6b2:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6b4:	15fd                	addi	a1,a1,-1
 6b6:	177d                	addi	a4,a4,-1
 6b8:	0005c683          	lbu	a3,0(a1)
 6bc:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6c0:	fee79ae3          	bne	a5,a4,6b4 <memmove+0x46>
 6c4:	bfc9                	j	696 <memmove+0x28>

00000000000006c6 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6c6:	1141                	addi	sp,sp,-16
 6c8:	e422                	sd	s0,8(sp)
 6ca:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6cc:	ca05                	beqz	a2,6fc <memcmp+0x36>
 6ce:	fff6069b          	addiw	a3,a2,-1
 6d2:	1682                	slli	a3,a3,0x20
 6d4:	9281                	srli	a3,a3,0x20
 6d6:	0685                	addi	a3,a3,1
 6d8:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6da:	00054783          	lbu	a5,0(a0)
 6de:	0005c703          	lbu	a4,0(a1)
 6e2:	00e79863          	bne	a5,a4,6f2 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6e6:	0505                	addi	a0,a0,1
        p2++;
 6e8:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6ea:	fed518e3          	bne	a0,a3,6da <memcmp+0x14>
    }
    return 0;
 6ee:	4501                	li	a0,0
 6f0:	a019                	j	6f6 <memcmp+0x30>
            return *p1 - *p2;
 6f2:	40e7853b          	subw	a0,a5,a4
}
 6f6:	6422                	ld	s0,8(sp)
 6f8:	0141                	addi	sp,sp,16
 6fa:	8082                	ret
    return 0;
 6fc:	4501                	li	a0,0
 6fe:	bfe5                	j	6f6 <memcmp+0x30>

0000000000000700 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 700:	1141                	addi	sp,sp,-16
 702:	e406                	sd	ra,8(sp)
 704:	e022                	sd	s0,0(sp)
 706:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 708:	00000097          	auipc	ra,0x0
 70c:	f66080e7          	jalr	-154(ra) # 66e <memmove>
}
 710:	60a2                	ld	ra,8(sp)
 712:	6402                	ld	s0,0(sp)
 714:	0141                	addi	sp,sp,16
 716:	8082                	ret

0000000000000718 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 718:	4885                	li	a7,1
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <exit>:
.global exit
exit:
 li a7, SYS_exit
 720:	4889                	li	a7,2
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <wait>:
.global wait
wait:
 li a7, SYS_wait
 728:	488d                	li	a7,3
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 730:	4891                	li	a7,4
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <read>:
.global read
read:
 li a7, SYS_read
 738:	4895                	li	a7,5
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <write>:
.global write
write:
 li a7, SYS_write
 740:	48c1                	li	a7,16
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <close>:
.global close
close:
 li a7, SYS_close
 748:	48d5                	li	a7,21
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <kill>:
.global kill
kill:
 li a7, SYS_kill
 750:	4899                	li	a7,6
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <exec>:
.global exec
exec:
 li a7, SYS_exec
 758:	489d                	li	a7,7
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <open>:
.global open
open:
 li a7, SYS_open
 760:	48bd                	li	a7,15
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 768:	48c5                	li	a7,17
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 770:	48c9                	li	a7,18
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 778:	48a1                	li	a7,8
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <link>:
.global link
link:
 li a7, SYS_link
 780:	48cd                	li	a7,19
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 788:	48d1                	li	a7,20
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 790:	48a5                	li	a7,9
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <dup>:
.global dup
dup:
 li a7, SYS_dup
 798:	48a9                	li	a7,10
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7a0:	48ad                	li	a7,11
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7a8:	48b1                	li	a7,12
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7b0:	48b5                	li	a7,13
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7b8:	48b9                	li	a7,14
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7c0:	48d9                	li	a7,22
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7c8:	48dd                	li	a7,23
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7d0:	48e1                	li	a7,24
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7d8:	1101                	addi	sp,sp,-32
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	1000                	addi	s0,sp,32
 7e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7e4:	4605                	li	a2,1
 7e6:	fef40593          	addi	a1,s0,-17
 7ea:	00000097          	auipc	ra,0x0
 7ee:	f56080e7          	jalr	-170(ra) # 740 <write>
}
 7f2:	60e2                	ld	ra,24(sp)
 7f4:	6442                	ld	s0,16(sp)
 7f6:	6105                	addi	sp,sp,32
 7f8:	8082                	ret

00000000000007fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7fa:	7139                	addi	sp,sp,-64
 7fc:	fc06                	sd	ra,56(sp)
 7fe:	f822                	sd	s0,48(sp)
 800:	f426                	sd	s1,40(sp)
 802:	f04a                	sd	s2,32(sp)
 804:	ec4e                	sd	s3,24(sp)
 806:	0080                	addi	s0,sp,64
 808:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 80a:	c299                	beqz	a3,810 <printint+0x16>
 80c:	0805c963          	bltz	a1,89e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 810:	2581                	sext.w	a1,a1
  neg = 0;
 812:	4881                	li	a7,0
 814:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 818:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 81a:	2601                	sext.w	a2,a2
 81c:	00000517          	auipc	a0,0x0
 820:	5bc50513          	addi	a0,a0,1468 # dd8 <digits>
 824:	883a                	mv	a6,a4
 826:	2705                	addiw	a4,a4,1
 828:	02c5f7bb          	remuw	a5,a1,a2
 82c:	1782                	slli	a5,a5,0x20
 82e:	9381                	srli	a5,a5,0x20
 830:	97aa                	add	a5,a5,a0
 832:	0007c783          	lbu	a5,0(a5)
 836:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 83a:	0005879b          	sext.w	a5,a1
 83e:	02c5d5bb          	divuw	a1,a1,a2
 842:	0685                	addi	a3,a3,1
 844:	fec7f0e3          	bgeu	a5,a2,824 <printint+0x2a>
  if(neg)
 848:	00088c63          	beqz	a7,860 <printint+0x66>
    buf[i++] = '-';
 84c:	fd070793          	addi	a5,a4,-48
 850:	00878733          	add	a4,a5,s0
 854:	02d00793          	li	a5,45
 858:	fef70823          	sb	a5,-16(a4)
 85c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 860:	02e05863          	blez	a4,890 <printint+0x96>
 864:	fc040793          	addi	a5,s0,-64
 868:	00e78933          	add	s2,a5,a4
 86c:	fff78993          	addi	s3,a5,-1
 870:	99ba                	add	s3,s3,a4
 872:	377d                	addiw	a4,a4,-1
 874:	1702                	slli	a4,a4,0x20
 876:	9301                	srli	a4,a4,0x20
 878:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 87c:	fff94583          	lbu	a1,-1(s2)
 880:	8526                	mv	a0,s1
 882:	00000097          	auipc	ra,0x0
 886:	f56080e7          	jalr	-170(ra) # 7d8 <putc>
  while(--i >= 0)
 88a:	197d                	addi	s2,s2,-1
 88c:	ff3918e3          	bne	s2,s3,87c <printint+0x82>
}
 890:	70e2                	ld	ra,56(sp)
 892:	7442                	ld	s0,48(sp)
 894:	74a2                	ld	s1,40(sp)
 896:	7902                	ld	s2,32(sp)
 898:	69e2                	ld	s3,24(sp)
 89a:	6121                	addi	sp,sp,64
 89c:	8082                	ret
    x = -xx;
 89e:	40b005bb          	negw	a1,a1
    neg = 1;
 8a2:	4885                	li	a7,1
    x = -xx;
 8a4:	bf85                	j	814 <printint+0x1a>

00000000000008a6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8a6:	715d                	addi	sp,sp,-80
 8a8:	e486                	sd	ra,72(sp)
 8aa:	e0a2                	sd	s0,64(sp)
 8ac:	fc26                	sd	s1,56(sp)
 8ae:	f84a                	sd	s2,48(sp)
 8b0:	f44e                	sd	s3,40(sp)
 8b2:	f052                	sd	s4,32(sp)
 8b4:	ec56                	sd	s5,24(sp)
 8b6:	e85a                	sd	s6,16(sp)
 8b8:	e45e                	sd	s7,8(sp)
 8ba:	e062                	sd	s8,0(sp)
 8bc:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8be:	0005c903          	lbu	s2,0(a1)
 8c2:	18090c63          	beqz	s2,a5a <vprintf+0x1b4>
 8c6:	8aaa                	mv	s5,a0
 8c8:	8bb2                	mv	s7,a2
 8ca:	00158493          	addi	s1,a1,1
  state = 0;
 8ce:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8d0:	02500a13          	li	s4,37
 8d4:	4b55                	li	s6,21
 8d6:	a839                	j	8f4 <vprintf+0x4e>
        putc(fd, c);
 8d8:	85ca                	mv	a1,s2
 8da:	8556                	mv	a0,s5
 8dc:	00000097          	auipc	ra,0x0
 8e0:	efc080e7          	jalr	-260(ra) # 7d8 <putc>
 8e4:	a019                	j	8ea <vprintf+0x44>
    } else if(state == '%'){
 8e6:	01498d63          	beq	s3,s4,900 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8ea:	0485                	addi	s1,s1,1
 8ec:	fff4c903          	lbu	s2,-1(s1)
 8f0:	16090563          	beqz	s2,a5a <vprintf+0x1b4>
    if(state == 0){
 8f4:	fe0999e3          	bnez	s3,8e6 <vprintf+0x40>
      if(c == '%'){
 8f8:	ff4910e3          	bne	s2,s4,8d8 <vprintf+0x32>
        state = '%';
 8fc:	89d2                	mv	s3,s4
 8fe:	b7f5                	j	8ea <vprintf+0x44>
      if(c == 'd'){
 900:	13490263          	beq	s2,s4,a24 <vprintf+0x17e>
 904:	f9d9079b          	addiw	a5,s2,-99
 908:	0ff7f793          	zext.b	a5,a5
 90c:	12fb6563          	bltu	s6,a5,a36 <vprintf+0x190>
 910:	f9d9079b          	addiw	a5,s2,-99
 914:	0ff7f713          	zext.b	a4,a5
 918:	10eb6f63          	bltu	s6,a4,a36 <vprintf+0x190>
 91c:	00271793          	slli	a5,a4,0x2
 920:	00000717          	auipc	a4,0x0
 924:	46070713          	addi	a4,a4,1120 # d80 <malloc+0x228>
 928:	97ba                	add	a5,a5,a4
 92a:	439c                	lw	a5,0(a5)
 92c:	97ba                	add	a5,a5,a4
 92e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 930:	008b8913          	addi	s2,s7,8
 934:	4685                	li	a3,1
 936:	4629                	li	a2,10
 938:	000ba583          	lw	a1,0(s7)
 93c:	8556                	mv	a0,s5
 93e:	00000097          	auipc	ra,0x0
 942:	ebc080e7          	jalr	-324(ra) # 7fa <printint>
 946:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 948:	4981                	li	s3,0
 94a:	b745                	j	8ea <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 94c:	008b8913          	addi	s2,s7,8
 950:	4681                	li	a3,0
 952:	4629                	li	a2,10
 954:	000ba583          	lw	a1,0(s7)
 958:	8556                	mv	a0,s5
 95a:	00000097          	auipc	ra,0x0
 95e:	ea0080e7          	jalr	-352(ra) # 7fa <printint>
 962:	8bca                	mv	s7,s2
      state = 0;
 964:	4981                	li	s3,0
 966:	b751                	j	8ea <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 968:	008b8913          	addi	s2,s7,8
 96c:	4681                	li	a3,0
 96e:	4641                	li	a2,16
 970:	000ba583          	lw	a1,0(s7)
 974:	8556                	mv	a0,s5
 976:	00000097          	auipc	ra,0x0
 97a:	e84080e7          	jalr	-380(ra) # 7fa <printint>
 97e:	8bca                	mv	s7,s2
      state = 0;
 980:	4981                	li	s3,0
 982:	b7a5                	j	8ea <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 984:	008b8c13          	addi	s8,s7,8
 988:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 98c:	03000593          	li	a1,48
 990:	8556                	mv	a0,s5
 992:	00000097          	auipc	ra,0x0
 996:	e46080e7          	jalr	-442(ra) # 7d8 <putc>
  putc(fd, 'x');
 99a:	07800593          	li	a1,120
 99e:	8556                	mv	a0,s5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	e38080e7          	jalr	-456(ra) # 7d8 <putc>
 9a8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9aa:	00000b97          	auipc	s7,0x0
 9ae:	42eb8b93          	addi	s7,s7,1070 # dd8 <digits>
 9b2:	03c9d793          	srli	a5,s3,0x3c
 9b6:	97de                	add	a5,a5,s7
 9b8:	0007c583          	lbu	a1,0(a5)
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	e1a080e7          	jalr	-486(ra) # 7d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9c6:	0992                	slli	s3,s3,0x4
 9c8:	397d                	addiw	s2,s2,-1
 9ca:	fe0914e3          	bnez	s2,9b2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9ce:	8be2                	mv	s7,s8
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bf21                	j	8ea <vprintf+0x44>
        s = va_arg(ap, char*);
 9d4:	008b8993          	addi	s3,s7,8
 9d8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9dc:	02090163          	beqz	s2,9fe <vprintf+0x158>
        while(*s != 0){
 9e0:	00094583          	lbu	a1,0(s2)
 9e4:	c9a5                	beqz	a1,a54 <vprintf+0x1ae>
          putc(fd, *s);
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	df0080e7          	jalr	-528(ra) # 7d8 <putc>
          s++;
 9f0:	0905                	addi	s2,s2,1
        while(*s != 0){
 9f2:	00094583          	lbu	a1,0(s2)
 9f6:	f9e5                	bnez	a1,9e6 <vprintf+0x140>
        s = va_arg(ap, char*);
 9f8:	8bce                	mv	s7,s3
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	b5fd                	j	8ea <vprintf+0x44>
          s = "(null)";
 9fe:	00000917          	auipc	s2,0x0
 a02:	37a90913          	addi	s2,s2,890 # d78 <malloc+0x220>
        while(*s != 0){
 a06:	02800593          	li	a1,40
 a0a:	bff1                	j	9e6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a0c:	008b8913          	addi	s2,s7,8
 a10:	000bc583          	lbu	a1,0(s7)
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	dc2080e7          	jalr	-574(ra) # 7d8 <putc>
 a1e:	8bca                	mv	s7,s2
      state = 0;
 a20:	4981                	li	s3,0
 a22:	b5e1                	j	8ea <vprintf+0x44>
        putc(fd, c);
 a24:	02500593          	li	a1,37
 a28:	8556                	mv	a0,s5
 a2a:	00000097          	auipc	ra,0x0
 a2e:	dae080e7          	jalr	-594(ra) # 7d8 <putc>
      state = 0;
 a32:	4981                	li	s3,0
 a34:	bd5d                	j	8ea <vprintf+0x44>
        putc(fd, '%');
 a36:	02500593          	li	a1,37
 a3a:	8556                	mv	a0,s5
 a3c:	00000097          	auipc	ra,0x0
 a40:	d9c080e7          	jalr	-612(ra) # 7d8 <putc>
        putc(fd, c);
 a44:	85ca                	mv	a1,s2
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	d90080e7          	jalr	-624(ra) # 7d8 <putc>
      state = 0;
 a50:	4981                	li	s3,0
 a52:	bd61                	j	8ea <vprintf+0x44>
        s = va_arg(ap, char*);
 a54:	8bce                	mv	s7,s3
      state = 0;
 a56:	4981                	li	s3,0
 a58:	bd49                	j	8ea <vprintf+0x44>
    }
  }
}
 a5a:	60a6                	ld	ra,72(sp)
 a5c:	6406                	ld	s0,64(sp)
 a5e:	74e2                	ld	s1,56(sp)
 a60:	7942                	ld	s2,48(sp)
 a62:	79a2                	ld	s3,40(sp)
 a64:	7a02                	ld	s4,32(sp)
 a66:	6ae2                	ld	s5,24(sp)
 a68:	6b42                	ld	s6,16(sp)
 a6a:	6ba2                	ld	s7,8(sp)
 a6c:	6c02                	ld	s8,0(sp)
 a6e:	6161                	addi	sp,sp,80
 a70:	8082                	ret

0000000000000a72 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a72:	715d                	addi	sp,sp,-80
 a74:	ec06                	sd	ra,24(sp)
 a76:	e822                	sd	s0,16(sp)
 a78:	1000                	addi	s0,sp,32
 a7a:	e010                	sd	a2,0(s0)
 a7c:	e414                	sd	a3,8(s0)
 a7e:	e818                	sd	a4,16(s0)
 a80:	ec1c                	sd	a5,24(s0)
 a82:	03043023          	sd	a6,32(s0)
 a86:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a8a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a8e:	8622                	mv	a2,s0
 a90:	00000097          	auipc	ra,0x0
 a94:	e16080e7          	jalr	-490(ra) # 8a6 <vprintf>
}
 a98:	60e2                	ld	ra,24(sp)
 a9a:	6442                	ld	s0,16(sp)
 a9c:	6161                	addi	sp,sp,80
 a9e:	8082                	ret

0000000000000aa0 <printf>:

void
printf(const char *fmt, ...)
{
 aa0:	711d                	addi	sp,sp,-96
 aa2:	ec06                	sd	ra,24(sp)
 aa4:	e822                	sd	s0,16(sp)
 aa6:	1000                	addi	s0,sp,32
 aa8:	e40c                	sd	a1,8(s0)
 aaa:	e810                	sd	a2,16(s0)
 aac:	ec14                	sd	a3,24(s0)
 aae:	f018                	sd	a4,32(s0)
 ab0:	f41c                	sd	a5,40(s0)
 ab2:	03043823          	sd	a6,48(s0)
 ab6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aba:	00840613          	addi	a2,s0,8
 abe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ac2:	85aa                	mv	a1,a0
 ac4:	4505                	li	a0,1
 ac6:	00000097          	auipc	ra,0x0
 aca:	de0080e7          	jalr	-544(ra) # 8a6 <vprintf>
}
 ace:	60e2                	ld	ra,24(sp)
 ad0:	6442                	ld	s0,16(sp)
 ad2:	6125                	addi	sp,sp,96
 ad4:	8082                	ret

0000000000000ad6 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ad6:	1141                	addi	sp,sp,-16
 ad8:	e422                	sd	s0,8(sp)
 ada:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 adc:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae0:	00000797          	auipc	a5,0x0
 ae4:	5387b783          	ld	a5,1336(a5) # 1018 <freep>
 ae8:	a02d                	j	b12 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 aea:	4618                	lw	a4,8(a2)
 aec:	9f2d                	addw	a4,a4,a1
 aee:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 af2:	6398                	ld	a4,0(a5)
 af4:	6310                	ld	a2,0(a4)
 af6:	a83d                	j	b34 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 af8:	ff852703          	lw	a4,-8(a0)
 afc:	9f31                	addw	a4,a4,a2
 afe:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b00:	ff053683          	ld	a3,-16(a0)
 b04:	a091                	j	b48 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b06:	6398                	ld	a4,0(a5)
 b08:	00e7e463          	bltu	a5,a4,b10 <free+0x3a>
 b0c:	00e6ea63          	bltu	a3,a4,b20 <free+0x4a>
{
 b10:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b12:	fed7fae3          	bgeu	a5,a3,b06 <free+0x30>
 b16:	6398                	ld	a4,0(a5)
 b18:	00e6e463          	bltu	a3,a4,b20 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b1c:	fee7eae3          	bltu	a5,a4,b10 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b20:	ff852583          	lw	a1,-8(a0)
 b24:	6390                	ld	a2,0(a5)
 b26:	02059813          	slli	a6,a1,0x20
 b2a:	01c85713          	srli	a4,a6,0x1c
 b2e:	9736                	add	a4,a4,a3
 b30:	fae60de3          	beq	a2,a4,aea <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b34:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b38:	4790                	lw	a2,8(a5)
 b3a:	02061593          	slli	a1,a2,0x20
 b3e:	01c5d713          	srli	a4,a1,0x1c
 b42:	973e                	add	a4,a4,a5
 b44:	fae68ae3          	beq	a3,a4,af8 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b48:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b4a:	00000717          	auipc	a4,0x0
 b4e:	4cf73723          	sd	a5,1230(a4) # 1018 <freep>
}
 b52:	6422                	ld	s0,8(sp)
 b54:	0141                	addi	sp,sp,16
 b56:	8082                	ret

0000000000000b58 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b58:	7139                	addi	sp,sp,-64
 b5a:	fc06                	sd	ra,56(sp)
 b5c:	f822                	sd	s0,48(sp)
 b5e:	f426                	sd	s1,40(sp)
 b60:	f04a                	sd	s2,32(sp)
 b62:	ec4e                	sd	s3,24(sp)
 b64:	e852                	sd	s4,16(sp)
 b66:	e456                	sd	s5,8(sp)
 b68:	e05a                	sd	s6,0(sp)
 b6a:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b6c:	02051493          	slli	s1,a0,0x20
 b70:	9081                	srli	s1,s1,0x20
 b72:	04bd                	addi	s1,s1,15
 b74:	8091                	srli	s1,s1,0x4
 b76:	0014899b          	addiw	s3,s1,1
 b7a:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b7c:	00000517          	auipc	a0,0x0
 b80:	49c53503          	ld	a0,1180(a0) # 1018 <freep>
 b84:	c515                	beqz	a0,bb0 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b86:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b88:	4798                	lw	a4,8(a5)
 b8a:	02977f63          	bgeu	a4,s1,bc8 <malloc+0x70>
    if (nu < 4096)
 b8e:	8a4e                	mv	s4,s3
 b90:	0009871b          	sext.w	a4,s3
 b94:	6685                	lui	a3,0x1
 b96:	00d77363          	bgeu	a4,a3,b9c <malloc+0x44>
 b9a:	6a05                	lui	s4,0x1
 b9c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 ba0:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 ba4:	00000917          	auipc	s2,0x0
 ba8:	47490913          	addi	s2,s2,1140 # 1018 <freep>
    if (p == (char *)-1)
 bac:	5afd                	li	s5,-1
 bae:	a895                	j	c22 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bb0:	00000797          	auipc	a5,0x0
 bb4:	4f078793          	addi	a5,a5,1264 # 10a0 <base>
 bb8:	00000717          	auipc	a4,0x0
 bbc:	46f73023          	sd	a5,1120(a4) # 1018 <freep>
 bc0:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bc2:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bc6:	b7e1                	j	b8e <malloc+0x36>
            if (p->s.size == nunits)
 bc8:	02e48c63          	beq	s1,a4,c00 <malloc+0xa8>
                p->s.size -= nunits;
 bcc:	4137073b          	subw	a4,a4,s3
 bd0:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bd2:	02071693          	slli	a3,a4,0x20
 bd6:	01c6d713          	srli	a4,a3,0x1c
 bda:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bdc:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 be0:	00000717          	auipc	a4,0x0
 be4:	42a73c23          	sd	a0,1080(a4) # 1018 <freep>
            return (void *)(p + 1);
 be8:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bec:	70e2                	ld	ra,56(sp)
 bee:	7442                	ld	s0,48(sp)
 bf0:	74a2                	ld	s1,40(sp)
 bf2:	7902                	ld	s2,32(sp)
 bf4:	69e2                	ld	s3,24(sp)
 bf6:	6a42                	ld	s4,16(sp)
 bf8:	6aa2                	ld	s5,8(sp)
 bfa:	6b02                	ld	s6,0(sp)
 bfc:	6121                	addi	sp,sp,64
 bfe:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c00:	6398                	ld	a4,0(a5)
 c02:	e118                	sd	a4,0(a0)
 c04:	bff1                	j	be0 <malloc+0x88>
    hp->s.size = nu;
 c06:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c0a:	0541                	addi	a0,a0,16
 c0c:	00000097          	auipc	ra,0x0
 c10:	eca080e7          	jalr	-310(ra) # ad6 <free>
    return freep;
 c14:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c18:	d971                	beqz	a0,bec <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c1a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c1c:	4798                	lw	a4,8(a5)
 c1e:	fa9775e3          	bgeu	a4,s1,bc8 <malloc+0x70>
        if (p == freep)
 c22:	00093703          	ld	a4,0(s2)
 c26:	853e                	mv	a0,a5
 c28:	fef719e3          	bne	a4,a5,c1a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c2c:	8552                	mv	a0,s4
 c2e:	00000097          	auipc	ra,0x0
 c32:	b7a080e7          	jalr	-1158(ra) # 7a8 <sbrk>
    if (p == (char *)-1)
 c36:	fd5518e3          	bne	a0,s5,c06 <malloc+0xae>
                return 0;
 c3a:	4501                	li	a0,0
 c3c:	bf45                	j	bec <malloc+0x94>
