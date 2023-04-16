
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
  2c:	75a080e7          	jalr	1882(ra) # 782 <unlink>
  30:	02054463          	bltz	a0,58 <main+0x58>
  for(i = 1; i < argc; i++){
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a80d                	j	6c <main+0x6c>
    fprintf(2, "Usage: rm files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	c1458593          	addi	a1,a1,-1004 # c50 <malloc+0xe6>
  44:	4509                	li	a0,2
  46:	00001097          	auipc	ra,0x1
  4a:	a3e080e7          	jalr	-1474(ra) # a84 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	6e2080e7          	jalr	1762(ra) # 732 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  58:	6090                	ld	a2,0(s1)
  5a:	00001597          	auipc	a1,0x1
  5e:	c0e58593          	addi	a1,a1,-1010 # c68 <malloc+0xfe>
  62:	4509                	li	a0,2
  64:	00001097          	auipc	ra,0x1
  68:	a20080e7          	jalr	-1504(ra) # a84 <fprintf>
      break;
    }
  }

  exit(0);
  6c:	4501                	li	a0,0
  6e:	00000097          	auipc	ra,0x0
  72:	6c4080e7          	jalr	1732(ra) # 732 <exit>

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
  aa:	2dc080e7          	jalr	732(ra) # 382 <twhoami>
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
  f6:	b9650513          	addi	a0,a0,-1130 # c88 <malloc+0x11e>
  fa:	00001097          	auipc	ra,0x1
  fe:	9b8080e7          	jalr	-1608(ra) # ab2 <printf>
        exit(-1);
 102:	557d                	li	a0,-1
 104:	00000097          	auipc	ra,0x0
 108:	62e080e7          	jalr	1582(ra) # 732 <exit>
    {
        // give up the cpu for other threads
        tyield();
 10c:	00000097          	auipc	ra,0x0
 110:	252080e7          	jalr	594(ra) # 35e <tyield>
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
 12a:	25c080e7          	jalr	604(ra) # 382 <twhoami>
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
 16e:	1f4080e7          	jalr	500(ra) # 35e <tyield>
}
 172:	60e2                	ld	ra,24(sp)
 174:	6442                	ld	s0,16(sp)
 176:	64a2                	ld	s1,8(sp)
 178:	6105                	addi	sp,sp,32
 17a:	8082                	ret
        printf("releasing lock we are not holding");
 17c:	00001517          	auipc	a0,0x1
 180:	b3450513          	addi	a0,a0,-1228 # cb0 <malloc+0x146>
 184:	00001097          	auipc	ra,0x1
 188:	92e080e7          	jalr	-1746(ra) # ab2 <printf>
        exit(-1);
 18c:	557d                	li	a0,-1
 18e:	00000097          	auipc	ra,0x0
 192:	5a4080e7          	jalr	1444(ra) # 732 <exit>

0000000000000196 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 196:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 198:	00001617          	auipc	a2,0x1
 19c:	e8860613          	addi	a2,a2,-376 # 1020 <threads>
 1a0:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 1a2:	45c1                	li	a1,16
 1a4:	a021                	j	1ac <tsched+0x16>
 1a6:	2685                	addiw	a3,a3,1
 1a8:	08b68c63          	beq	a3,a1,240 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 1ac:	41f6d71b          	sraiw	a4,a3,0x1f
 1b0:	01c7571b          	srliw	a4,a4,0x1c
 1b4:	00d707bb          	addw	a5,a4,a3
 1b8:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1ba:	9f99                	subw	a5,a5,a4
 1bc:	078e                	slli	a5,a5,0x3
 1be:	97b2                	add	a5,a5,a2
 1c0:	639c                	ld	a5,0(a5)
 1c2:	d3f5                	beqz	a5,1a6 <tsched+0x10>
 1c4:	5fb8                	lw	a4,120(a5)
 1c6:	fea710e3          	bne	a4,a0,1a6 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1ca:	00001717          	auipc	a4,0x1
 1ce:	e5673703          	ld	a4,-426(a4) # 1020 <threads>
 1d2:	5f30                	lw	a2,120(a4)
 1d4:	468d                	li	a3,3
 1d6:	06d60363          	beq	a2,a3,23c <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1da:	c3a5                	beqz	a5,23a <tsched+0xa4>
{
 1dc:	1101                	addi	sp,sp,-32
 1de:	ec06                	sd	ra,24(sp)
 1e0:	e822                	sd	s0,16(sp)
 1e2:	e426                	sd	s1,8(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1e8:	00001497          	auipc	s1,0x1
 1ec:	e2848493          	addi	s1,s1,-472 # 1010 <current_thread>
 1f0:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1f4:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1f6:	0007c603          	lbu	a2,0(a5)
 1fa:	00094583          	lbu	a1,0(s2)
 1fe:	00001517          	auipc	a0,0x1
 202:	ada50513          	addi	a0,a0,-1318 # cd8 <malloc+0x16e>
 206:	00001097          	auipc	ra,0x1
 20a:	8ac080e7          	jalr	-1876(ra) # ab2 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 20e:	608c                	ld	a1,0(s1)
 210:	05a1                	addi	a1,a1,8
 212:	00890513          	addi	a0,s2,8
 216:	00000097          	auipc	ra,0x0
 21a:	184080e7          	jalr	388(ra) # 39a <tswtch>
        printf("Thread switch complete\n");
 21e:	00001517          	auipc	a0,0x1
 222:	ae250513          	addi	a0,a0,-1310 # d00 <malloc+0x196>
 226:	00001097          	auipc	ra,0x1
 22a:	88c080e7          	jalr	-1908(ra) # ab2 <printf>
    }
}
 22e:	60e2                	ld	ra,24(sp)
 230:	6442                	ld	s0,16(sp)
 232:	64a2                	ld	s1,8(sp)
 234:	6902                	ld	s2,0(sp)
 236:	6105                	addi	sp,sp,32
 238:	8082                	ret
 23a:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 23c:	87ba                	mv	a5,a4
 23e:	bf79                	j	1dc <tsched+0x46>
 240:	00001797          	auipc	a5,0x1
 244:	de07b783          	ld	a5,-544(a5) # 1020 <threads>
 248:	5fb4                	lw	a3,120(a5)
 24a:	470d                	li	a4,3
 24c:	f8e688e3          	beq	a3,a4,1dc <tsched+0x46>
 250:	8082                	ret

0000000000000252 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 252:	7179                	addi	sp,sp,-48
 254:	f406                	sd	ra,40(sp)
 256:	f022                	sd	s0,32(sp)
 258:	ec26                	sd	s1,24(sp)
 25a:	e84a                	sd	s2,16(sp)
 25c:	e44e                	sd	s3,8(sp)
 25e:	1800                	addi	s0,sp,48
 260:	84aa                	mv	s1,a0
 262:	89b2                	mv	s3,a2
 264:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 266:	09000513          	li	a0,144
 26a:	00001097          	auipc	ra,0x1
 26e:	900080e7          	jalr	-1792(ra) # b6a <malloc>
 272:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 274:	478d                	li	a5,3
 276:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 278:	609c                	ld	a5,0(s1)
 27a:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 27e:	609c                	ld	a5,0(s1)
 280:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 284:	00001717          	auipc	a4,0x1
 288:	d7c70713          	addi	a4,a4,-644 # 1000 <next_tid>
 28c:	431c                	lw	a5,0(a4)
 28e:	0017869b          	addiw	a3,a5,1
 292:	c314                	sw	a3,0(a4)
 294:	6098                	ld	a4,0(s1)
 296:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 29a:	00001717          	auipc	a4,0x1
 29e:	d8670713          	addi	a4,a4,-634 # 1020 <threads>
 2a2:	4781                	li	a5,0
 2a4:	4641                	li	a2,16
    if (threads[i] == NULL) {
 2a6:	6314                	ld	a3,0(a4)
 2a8:	ce81                	beqz	a3,2c0 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 2aa:	2785                	addiw	a5,a5,1
 2ac:	0721                	addi	a4,a4,8
 2ae:	fec79ce3          	bne	a5,a2,2a6 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 2b2:	70a2                	ld	ra,40(sp)
 2b4:	7402                	ld	s0,32(sp)
 2b6:	64e2                	ld	s1,24(sp)
 2b8:	6942                	ld	s2,16(sp)
 2ba:	69a2                	ld	s3,8(sp)
 2bc:	6145                	addi	sp,sp,48
 2be:	8082                	ret
        threads[i] = *thread;
 2c0:	6094                	ld	a3,0(s1)
 2c2:	078e                	slli	a5,a5,0x3
 2c4:	00001717          	auipc	a4,0x1
 2c8:	d5c70713          	addi	a4,a4,-676 # 1020 <threads>
 2cc:	97ba                	add	a5,a5,a4
 2ce:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2d0:	0006c583          	lbu	a1,0(a3)
 2d4:	00001517          	auipc	a0,0x1
 2d8:	a4450513          	addi	a0,a0,-1468 # d18 <malloc+0x1ae>
 2dc:	00000097          	auipc	ra,0x0
 2e0:	7d6080e7          	jalr	2006(ra) # ab2 <printf>
        break;
 2e4:	b7f9                	j	2b2 <tcreate+0x60>

00000000000002e6 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2e6:	7179                	addi	sp,sp,-48
 2e8:	f406                	sd	ra,40(sp)
 2ea:	f022                	sd	s0,32(sp)
 2ec:	ec26                	sd	s1,24(sp)
 2ee:	e84a                	sd	s2,16(sp)
 2f0:	e44e                	sd	s3,8(sp)
 2f2:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2f4:	00001797          	auipc	a5,0x1
 2f8:	d2c78793          	addi	a5,a5,-724 # 1020 <threads>
 2fc:	00001697          	auipc	a3,0x1
 300:	da468693          	addi	a3,a3,-604 # 10a0 <base>
 304:	a021                	j	30c <tjoin+0x26>
 306:	07a1                	addi	a5,a5,8
 308:	04d78763          	beq	a5,a3,356 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 30c:	6384                	ld	s1,0(a5)
 30e:	dce5                	beqz	s1,306 <tjoin+0x20>
 310:	0004c703          	lbu	a4,0(s1)
 314:	fea719e3          	bne	a4,a0,306 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 318:	5cb8                	lw	a4,120(s1)
 31a:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 31c:	00001997          	auipc	s3,0x1
 320:	a2c98993          	addi	s3,s3,-1492 # d48 <malloc+0x1de>
    while (target_thread->state != EXITED) {
 324:	4919                	li	s2,6
 326:	02f70a63          	beq	a4,a5,35a <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 32a:	0004c583          	lbu	a1,0(s1)
 32e:	854e                	mv	a0,s3
 330:	00000097          	auipc	ra,0x0
 334:	782080e7          	jalr	1922(ra) # ab2 <printf>
        tsched();
 338:	00000097          	auipc	ra,0x0
 33c:	e5e080e7          	jalr	-418(ra) # 196 <tsched>
    while (target_thread->state != EXITED) {
 340:	5cbc                	lw	a5,120(s1)
 342:	ff2794e3          	bne	a5,s2,32a <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 346:	4501                	li	a0,0
}
 348:	70a2                	ld	ra,40(sp)
 34a:	7402                	ld	s0,32(sp)
 34c:	64e2                	ld	s1,24(sp)
 34e:	6942                	ld	s2,16(sp)
 350:	69a2                	ld	s3,8(sp)
 352:	6145                	addi	sp,sp,48
 354:	8082                	ret
        return -1;
 356:	557d                	li	a0,-1
 358:	bfc5                	j	348 <tjoin+0x62>
    return 0;
 35a:	4501                	li	a0,0
 35c:	b7f5                	j	348 <tjoin+0x62>

000000000000035e <tyield>:


void tyield()
{
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 366:	00001797          	auipc	a5,0x1
 36a:	caa7b783          	ld	a5,-854(a5) # 1010 <current_thread>
 36e:	470d                	li	a4,3
 370:	dfb8                	sw	a4,120(a5)
    tsched();
 372:	00000097          	auipc	ra,0x0
 376:	e24080e7          	jalr	-476(ra) # 196 <tsched>
}
 37a:	60a2                	ld	ra,8(sp)
 37c:	6402                	ld	s0,0(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

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
 39a:	00153023          	sd	ra,0(a0)
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
 404:	715d                	addi	sp,sp,-80
 406:	e486                	sd	ra,72(sp)
 408:	e0a2                	sd	s0,64(sp)
 40a:	fc26                	sd	s1,56(sp)
 40c:	f84a                	sd	s2,48(sp)
 40e:	f44e                	sd	s3,40(sp)
 410:	f052                	sd	s4,32(sp)
 412:	ec56                	sd	s5,24(sp)
 414:	e85a                	sd	s6,16(sp)
 416:	e45e                	sd	s7,8(sp)
 418:	0880                	addi	s0,sp,80
 41a:	892a                	mv	s2,a0
 41c:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 41e:	00001517          	auipc	a0,0x1
 422:	94a50513          	addi	a0,a0,-1718 # d68 <malloc+0x1fe>
 426:	00000097          	auipc	ra,0x0
 42a:	68c080e7          	jalr	1676(ra) # ab2 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 42e:	09000513          	li	a0,144
 432:	00000097          	auipc	ra,0x0
 436:	738080e7          	jalr	1848(ra) # b6a <malloc>

    main_thread->tid = 0;
 43a:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 43e:	4791                	li	a5,4
 440:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 442:	00001797          	auipc	a5,0x1
 446:	bca7b723          	sd	a0,-1074(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 44a:	00001a17          	auipc	s4,0x1
 44e:	bd6a0a13          	addi	s4,s4,-1066 # 1020 <threads>
 452:	00001497          	auipc	s1,0x1
 456:	c4e48493          	addi	s1,s1,-946 # 10a0 <base>
    current_thread = main_thread;
 45a:	87d2                	mv	a5,s4
        threads[i] = NULL;
 45c:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 460:	07a1                	addi	a5,a5,8
 462:	fe979de3          	bne	a5,s1,45c <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 466:	00001797          	auipc	a5,0x1
 46a:	baa7bd23          	sd	a0,-1094(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 46e:	85ce                	mv	a1,s3
 470:	854a                	mv	a0,s2
 472:	00000097          	auipc	ra,0x0
 476:	b8e080e7          	jalr	-1138(ra) # 0 <main>
 47a:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 47c:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 47e:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 480:	00001a97          	auipc	s5,0x1
 484:	908a8a93          	addi	s5,s5,-1784 # d88 <malloc+0x21e>
 488:	a03d                	j	4b6 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 48a:	07a1                	addi	a5,a5,8
 48c:	00978963          	beq	a5,s1,49e <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 490:	6398                	ld	a4,0(a5)
 492:	df65                	beqz	a4,48a <_main+0x86>
 494:	5f38                	lw	a4,120(a4)
 496:	ff370ae3          	beq	a4,s3,48a <_main+0x86>
                running_threads++;
 49a:	2905                	addiw	s2,s2,1
 49c:	b7fd                	j	48a <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 49e:	85ca                	mv	a1,s2
 4a0:	8556                	mv	a0,s5
 4a2:	00000097          	auipc	ra,0x0
 4a6:	610080e7          	jalr	1552(ra) # ab2 <printf>
        if (running_threads > 0) {
 4aa:	01205963          	blez	s2,4bc <_main+0xb8>
            tsched(); // Schedule another thread to run
 4ae:	00000097          	auipc	ra,0x0
 4b2:	ce8080e7          	jalr	-792(ra) # 196 <tsched>
    current_thread = main_thread;
 4b6:	87d2                	mv	a5,s4
        running_threads = 0;
 4b8:	895a                	mv	s2,s6
 4ba:	bfd9                	j	490 <_main+0x8c>
        }
    }

    exit(res);
 4bc:	855e                	mv	a0,s7
 4be:	00000097          	auipc	ra,0x0
 4c2:	274080e7          	jalr	628(ra) # 732 <exit>

00000000000004c6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4cc:	87aa                	mv	a5,a0
 4ce:	0585                	addi	a1,a1,1
 4d0:	0785                	addi	a5,a5,1
 4d2:	fff5c703          	lbu	a4,-1(a1)
 4d6:	fee78fa3          	sb	a4,-1(a5)
 4da:	fb75                	bnez	a4,4ce <strcpy+0x8>
        ;
    return os;
}
 4dc:	6422                	ld	s0,8(sp)
 4de:	0141                	addi	sp,sp,16
 4e0:	8082                	ret

00000000000004e2 <strcmp>:

int strcmp(const char *p, const char *q)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e422                	sd	s0,8(sp)
 4e6:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4e8:	00054783          	lbu	a5,0(a0)
 4ec:	cb91                	beqz	a5,500 <strcmp+0x1e>
 4ee:	0005c703          	lbu	a4,0(a1)
 4f2:	00f71763          	bne	a4,a5,500 <strcmp+0x1e>
        p++, q++;
 4f6:	0505                	addi	a0,a0,1
 4f8:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4fa:	00054783          	lbu	a5,0(a0)
 4fe:	fbe5                	bnez	a5,4ee <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 500:	0005c503          	lbu	a0,0(a1)
}
 504:	40a7853b          	subw	a0,a5,a0
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret

000000000000050e <strlen>:

uint strlen(const char *s)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 514:	00054783          	lbu	a5,0(a0)
 518:	cf91                	beqz	a5,534 <strlen+0x26>
 51a:	0505                	addi	a0,a0,1
 51c:	87aa                	mv	a5,a0
 51e:	86be                	mv	a3,a5
 520:	0785                	addi	a5,a5,1
 522:	fff7c703          	lbu	a4,-1(a5)
 526:	ff65                	bnez	a4,51e <strlen+0x10>
 528:	40a6853b          	subw	a0,a3,a0
 52c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 52e:	6422                	ld	s0,8(sp)
 530:	0141                	addi	sp,sp,16
 532:	8082                	ret
    for (n = 0; s[n]; n++)
 534:	4501                	li	a0,0
 536:	bfe5                	j	52e <strlen+0x20>

0000000000000538 <memset>:

void *
memset(void *dst, int c, uint n)
{
 538:	1141                	addi	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 53e:	ca19                	beqz	a2,554 <memset+0x1c>
 540:	87aa                	mv	a5,a0
 542:	1602                	slli	a2,a2,0x20
 544:	9201                	srli	a2,a2,0x20
 546:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 54a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 54e:	0785                	addi	a5,a5,1
 550:	fee79de3          	bne	a5,a4,54a <memset+0x12>
    }
    return dst;
}
 554:	6422                	ld	s0,8(sp)
 556:	0141                	addi	sp,sp,16
 558:	8082                	ret

000000000000055a <strchr>:

char *
strchr(const char *s, char c)
{
 55a:	1141                	addi	sp,sp,-16
 55c:	e422                	sd	s0,8(sp)
 55e:	0800                	addi	s0,sp,16
    for (; *s; s++)
 560:	00054783          	lbu	a5,0(a0)
 564:	cb99                	beqz	a5,57a <strchr+0x20>
        if (*s == c)
 566:	00f58763          	beq	a1,a5,574 <strchr+0x1a>
    for (; *s; s++)
 56a:	0505                	addi	a0,a0,1
 56c:	00054783          	lbu	a5,0(a0)
 570:	fbfd                	bnez	a5,566 <strchr+0xc>
            return (char *)s;
    return 0;
 572:	4501                	li	a0,0
}
 574:	6422                	ld	s0,8(sp)
 576:	0141                	addi	sp,sp,16
 578:	8082                	ret
    return 0;
 57a:	4501                	li	a0,0
 57c:	bfe5                	j	574 <strchr+0x1a>

000000000000057e <gets>:

char *
gets(char *buf, int max)
{
 57e:	711d                	addi	sp,sp,-96
 580:	ec86                	sd	ra,88(sp)
 582:	e8a2                	sd	s0,80(sp)
 584:	e4a6                	sd	s1,72(sp)
 586:	e0ca                	sd	s2,64(sp)
 588:	fc4e                	sd	s3,56(sp)
 58a:	f852                	sd	s4,48(sp)
 58c:	f456                	sd	s5,40(sp)
 58e:	f05a                	sd	s6,32(sp)
 590:	ec5e                	sd	s7,24(sp)
 592:	1080                	addi	s0,sp,96
 594:	8baa                	mv	s7,a0
 596:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 598:	892a                	mv	s2,a0
 59a:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 59c:	4aa9                	li	s5,10
 59e:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5a0:	89a6                	mv	s3,s1
 5a2:	2485                	addiw	s1,s1,1
 5a4:	0344d863          	bge	s1,s4,5d4 <gets+0x56>
        cc = read(0, &c, 1);
 5a8:	4605                	li	a2,1
 5aa:	faf40593          	addi	a1,s0,-81
 5ae:	4501                	li	a0,0
 5b0:	00000097          	auipc	ra,0x0
 5b4:	19a080e7          	jalr	410(ra) # 74a <read>
        if (cc < 1)
 5b8:	00a05e63          	blez	a0,5d4 <gets+0x56>
        buf[i++] = c;
 5bc:	faf44783          	lbu	a5,-81(s0)
 5c0:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5c4:	01578763          	beq	a5,s5,5d2 <gets+0x54>
 5c8:	0905                	addi	s2,s2,1
 5ca:	fd679be3          	bne	a5,s6,5a0 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5ce:	89a6                	mv	s3,s1
 5d0:	a011                	j	5d4 <gets+0x56>
 5d2:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5d4:	99de                	add	s3,s3,s7
 5d6:	00098023          	sb	zero,0(s3)
    return buf;
}
 5da:	855e                	mv	a0,s7
 5dc:	60e6                	ld	ra,88(sp)
 5de:	6446                	ld	s0,80(sp)
 5e0:	64a6                	ld	s1,72(sp)
 5e2:	6906                	ld	s2,64(sp)
 5e4:	79e2                	ld	s3,56(sp)
 5e6:	7a42                	ld	s4,48(sp)
 5e8:	7aa2                	ld	s5,40(sp)
 5ea:	7b02                	ld	s6,32(sp)
 5ec:	6be2                	ld	s7,24(sp)
 5ee:	6125                	addi	sp,sp,96
 5f0:	8082                	ret

00000000000005f2 <stat>:

int stat(const char *n, struct stat *st)
{
 5f2:	1101                	addi	sp,sp,-32
 5f4:	ec06                	sd	ra,24(sp)
 5f6:	e822                	sd	s0,16(sp)
 5f8:	e426                	sd	s1,8(sp)
 5fa:	e04a                	sd	s2,0(sp)
 5fc:	1000                	addi	s0,sp,32
 5fe:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 600:	4581                	li	a1,0
 602:	00000097          	auipc	ra,0x0
 606:	170080e7          	jalr	368(ra) # 772 <open>
    if (fd < 0)
 60a:	02054563          	bltz	a0,634 <stat+0x42>
 60e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 610:	85ca                	mv	a1,s2
 612:	00000097          	auipc	ra,0x0
 616:	178080e7          	jalr	376(ra) # 78a <fstat>
 61a:	892a                	mv	s2,a0
    close(fd);
 61c:	8526                	mv	a0,s1
 61e:	00000097          	auipc	ra,0x0
 622:	13c080e7          	jalr	316(ra) # 75a <close>
    return r;
}
 626:	854a                	mv	a0,s2
 628:	60e2                	ld	ra,24(sp)
 62a:	6442                	ld	s0,16(sp)
 62c:	64a2                	ld	s1,8(sp)
 62e:	6902                	ld	s2,0(sp)
 630:	6105                	addi	sp,sp,32
 632:	8082                	ret
        return -1;
 634:	597d                	li	s2,-1
 636:	bfc5                	j	626 <stat+0x34>

0000000000000638 <atoi>:

int atoi(const char *s)
{
 638:	1141                	addi	sp,sp,-16
 63a:	e422                	sd	s0,8(sp)
 63c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 63e:	00054683          	lbu	a3,0(a0)
 642:	fd06879b          	addiw	a5,a3,-48
 646:	0ff7f793          	zext.b	a5,a5
 64a:	4625                	li	a2,9
 64c:	02f66863          	bltu	a2,a5,67c <atoi+0x44>
 650:	872a                	mv	a4,a0
    n = 0;
 652:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 654:	0705                	addi	a4,a4,1
 656:	0025179b          	slliw	a5,a0,0x2
 65a:	9fa9                	addw	a5,a5,a0
 65c:	0017979b          	slliw	a5,a5,0x1
 660:	9fb5                	addw	a5,a5,a3
 662:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 666:	00074683          	lbu	a3,0(a4)
 66a:	fd06879b          	addiw	a5,a3,-48
 66e:	0ff7f793          	zext.b	a5,a5
 672:	fef671e3          	bgeu	a2,a5,654 <atoi+0x1c>
    return n;
}
 676:	6422                	ld	s0,8(sp)
 678:	0141                	addi	sp,sp,16
 67a:	8082                	ret
    n = 0;
 67c:	4501                	li	a0,0
 67e:	bfe5                	j	676 <atoi+0x3e>

0000000000000680 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 680:	1141                	addi	sp,sp,-16
 682:	e422                	sd	s0,8(sp)
 684:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 686:	02b57463          	bgeu	a0,a1,6ae <memmove+0x2e>
    {
        while (n-- > 0)
 68a:	00c05f63          	blez	a2,6a8 <memmove+0x28>
 68e:	1602                	slli	a2,a2,0x20
 690:	9201                	srli	a2,a2,0x20
 692:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 696:	872a                	mv	a4,a0
            *dst++ = *src++;
 698:	0585                	addi	a1,a1,1
 69a:	0705                	addi	a4,a4,1
 69c:	fff5c683          	lbu	a3,-1(a1)
 6a0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6a4:	fee79ae3          	bne	a5,a4,698 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6a8:	6422                	ld	s0,8(sp)
 6aa:	0141                	addi	sp,sp,16
 6ac:	8082                	ret
        dst += n;
 6ae:	00c50733          	add	a4,a0,a2
        src += n;
 6b2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6b4:	fec05ae3          	blez	a2,6a8 <memmove+0x28>
 6b8:	fff6079b          	addiw	a5,a2,-1
 6bc:	1782                	slli	a5,a5,0x20
 6be:	9381                	srli	a5,a5,0x20
 6c0:	fff7c793          	not	a5,a5
 6c4:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6c6:	15fd                	addi	a1,a1,-1
 6c8:	177d                	addi	a4,a4,-1
 6ca:	0005c683          	lbu	a3,0(a1)
 6ce:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6d2:	fee79ae3          	bne	a5,a4,6c6 <memmove+0x46>
 6d6:	bfc9                	j	6a8 <memmove+0x28>

00000000000006d8 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6d8:	1141                	addi	sp,sp,-16
 6da:	e422                	sd	s0,8(sp)
 6dc:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6de:	ca05                	beqz	a2,70e <memcmp+0x36>
 6e0:	fff6069b          	addiw	a3,a2,-1
 6e4:	1682                	slli	a3,a3,0x20
 6e6:	9281                	srli	a3,a3,0x20
 6e8:	0685                	addi	a3,a3,1
 6ea:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6ec:	00054783          	lbu	a5,0(a0)
 6f0:	0005c703          	lbu	a4,0(a1)
 6f4:	00e79863          	bne	a5,a4,704 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6f8:	0505                	addi	a0,a0,1
        p2++;
 6fa:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6fc:	fed518e3          	bne	a0,a3,6ec <memcmp+0x14>
    }
    return 0;
 700:	4501                	li	a0,0
 702:	a019                	j	708 <memcmp+0x30>
            return *p1 - *p2;
 704:	40e7853b          	subw	a0,a5,a4
}
 708:	6422                	ld	s0,8(sp)
 70a:	0141                	addi	sp,sp,16
 70c:	8082                	ret
    return 0;
 70e:	4501                	li	a0,0
 710:	bfe5                	j	708 <memcmp+0x30>

0000000000000712 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 712:	1141                	addi	sp,sp,-16
 714:	e406                	sd	ra,8(sp)
 716:	e022                	sd	s0,0(sp)
 718:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 71a:	00000097          	auipc	ra,0x0
 71e:	f66080e7          	jalr	-154(ra) # 680 <memmove>
}
 722:	60a2                	ld	ra,8(sp)
 724:	6402                	ld	s0,0(sp)
 726:	0141                	addi	sp,sp,16
 728:	8082                	ret

000000000000072a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 72a:	4885                	li	a7,1
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <exit>:
.global exit
exit:
 li a7, SYS_exit
 732:	4889                	li	a7,2
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <wait>:
.global wait
wait:
 li a7, SYS_wait
 73a:	488d                	li	a7,3
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 742:	4891                	li	a7,4
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <read>:
.global read
read:
 li a7, SYS_read
 74a:	4895                	li	a7,5
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <write>:
.global write
write:
 li a7, SYS_write
 752:	48c1                	li	a7,16
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <close>:
.global close
close:
 li a7, SYS_close
 75a:	48d5                	li	a7,21
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <kill>:
.global kill
kill:
 li a7, SYS_kill
 762:	4899                	li	a7,6
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <exec>:
.global exec
exec:
 li a7, SYS_exec
 76a:	489d                	li	a7,7
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <open>:
.global open
open:
 li a7, SYS_open
 772:	48bd                	li	a7,15
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 77a:	48c5                	li	a7,17
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 782:	48c9                	li	a7,18
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 78a:	48a1                	li	a7,8
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <link>:
.global link
link:
 li a7, SYS_link
 792:	48cd                	li	a7,19
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 79a:	48d1                	li	a7,20
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7a2:	48a5                	li	a7,9
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <dup>:
.global dup
dup:
 li a7, SYS_dup
 7aa:	48a9                	li	a7,10
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7b2:	48ad                	li	a7,11
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7ba:	48b1                	li	a7,12
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7c2:	48b5                	li	a7,13
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7ca:	48b9                	li	a7,14
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7d2:	48d9                	li	a7,22
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7da:	48dd                	li	a7,23
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7e2:	48e1                	li	a7,24
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7ea:	1101                	addi	sp,sp,-32
 7ec:	ec06                	sd	ra,24(sp)
 7ee:	e822                	sd	s0,16(sp)
 7f0:	1000                	addi	s0,sp,32
 7f2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7f6:	4605                	li	a2,1
 7f8:	fef40593          	addi	a1,s0,-17
 7fc:	00000097          	auipc	ra,0x0
 800:	f56080e7          	jalr	-170(ra) # 752 <write>
}
 804:	60e2                	ld	ra,24(sp)
 806:	6442                	ld	s0,16(sp)
 808:	6105                	addi	sp,sp,32
 80a:	8082                	ret

000000000000080c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 80c:	7139                	addi	sp,sp,-64
 80e:	fc06                	sd	ra,56(sp)
 810:	f822                	sd	s0,48(sp)
 812:	f426                	sd	s1,40(sp)
 814:	f04a                	sd	s2,32(sp)
 816:	ec4e                	sd	s3,24(sp)
 818:	0080                	addi	s0,sp,64
 81a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 81c:	c299                	beqz	a3,822 <printint+0x16>
 81e:	0805c963          	bltz	a1,8b0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 822:	2581                	sext.w	a1,a1
  neg = 0;
 824:	4881                	li	a7,0
 826:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 82a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 82c:	2601                	sext.w	a2,a2
 82e:	00000517          	auipc	a0,0x0
 832:	5da50513          	addi	a0,a0,1498 # e08 <digits>
 836:	883a                	mv	a6,a4
 838:	2705                	addiw	a4,a4,1
 83a:	02c5f7bb          	remuw	a5,a1,a2
 83e:	1782                	slli	a5,a5,0x20
 840:	9381                	srli	a5,a5,0x20
 842:	97aa                	add	a5,a5,a0
 844:	0007c783          	lbu	a5,0(a5)
 848:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 84c:	0005879b          	sext.w	a5,a1
 850:	02c5d5bb          	divuw	a1,a1,a2
 854:	0685                	addi	a3,a3,1
 856:	fec7f0e3          	bgeu	a5,a2,836 <printint+0x2a>
  if(neg)
 85a:	00088c63          	beqz	a7,872 <printint+0x66>
    buf[i++] = '-';
 85e:	fd070793          	addi	a5,a4,-48
 862:	00878733          	add	a4,a5,s0
 866:	02d00793          	li	a5,45
 86a:	fef70823          	sb	a5,-16(a4)
 86e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 872:	02e05863          	blez	a4,8a2 <printint+0x96>
 876:	fc040793          	addi	a5,s0,-64
 87a:	00e78933          	add	s2,a5,a4
 87e:	fff78993          	addi	s3,a5,-1
 882:	99ba                	add	s3,s3,a4
 884:	377d                	addiw	a4,a4,-1
 886:	1702                	slli	a4,a4,0x20
 888:	9301                	srli	a4,a4,0x20
 88a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 88e:	fff94583          	lbu	a1,-1(s2)
 892:	8526                	mv	a0,s1
 894:	00000097          	auipc	ra,0x0
 898:	f56080e7          	jalr	-170(ra) # 7ea <putc>
  while(--i >= 0)
 89c:	197d                	addi	s2,s2,-1
 89e:	ff3918e3          	bne	s2,s3,88e <printint+0x82>
}
 8a2:	70e2                	ld	ra,56(sp)
 8a4:	7442                	ld	s0,48(sp)
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	7902                	ld	s2,32(sp)
 8aa:	69e2                	ld	s3,24(sp)
 8ac:	6121                	addi	sp,sp,64
 8ae:	8082                	ret
    x = -xx;
 8b0:	40b005bb          	negw	a1,a1
    neg = 1;
 8b4:	4885                	li	a7,1
    x = -xx;
 8b6:	bf85                	j	826 <printint+0x1a>

00000000000008b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8b8:	715d                	addi	sp,sp,-80
 8ba:	e486                	sd	ra,72(sp)
 8bc:	e0a2                	sd	s0,64(sp)
 8be:	fc26                	sd	s1,56(sp)
 8c0:	f84a                	sd	s2,48(sp)
 8c2:	f44e                	sd	s3,40(sp)
 8c4:	f052                	sd	s4,32(sp)
 8c6:	ec56                	sd	s5,24(sp)
 8c8:	e85a                	sd	s6,16(sp)
 8ca:	e45e                	sd	s7,8(sp)
 8cc:	e062                	sd	s8,0(sp)
 8ce:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8d0:	0005c903          	lbu	s2,0(a1)
 8d4:	18090c63          	beqz	s2,a6c <vprintf+0x1b4>
 8d8:	8aaa                	mv	s5,a0
 8da:	8bb2                	mv	s7,a2
 8dc:	00158493          	addi	s1,a1,1
  state = 0;
 8e0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8e2:	02500a13          	li	s4,37
 8e6:	4b55                	li	s6,21
 8e8:	a839                	j	906 <vprintf+0x4e>
        putc(fd, c);
 8ea:	85ca                	mv	a1,s2
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	efc080e7          	jalr	-260(ra) # 7ea <putc>
 8f6:	a019                	j	8fc <vprintf+0x44>
    } else if(state == '%'){
 8f8:	01498d63          	beq	s3,s4,912 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8fc:	0485                	addi	s1,s1,1
 8fe:	fff4c903          	lbu	s2,-1(s1)
 902:	16090563          	beqz	s2,a6c <vprintf+0x1b4>
    if(state == 0){
 906:	fe0999e3          	bnez	s3,8f8 <vprintf+0x40>
      if(c == '%'){
 90a:	ff4910e3          	bne	s2,s4,8ea <vprintf+0x32>
        state = '%';
 90e:	89d2                	mv	s3,s4
 910:	b7f5                	j	8fc <vprintf+0x44>
      if(c == 'd'){
 912:	13490263          	beq	s2,s4,a36 <vprintf+0x17e>
 916:	f9d9079b          	addiw	a5,s2,-99
 91a:	0ff7f793          	zext.b	a5,a5
 91e:	12fb6563          	bltu	s6,a5,a48 <vprintf+0x190>
 922:	f9d9079b          	addiw	a5,s2,-99
 926:	0ff7f713          	zext.b	a4,a5
 92a:	10eb6f63          	bltu	s6,a4,a48 <vprintf+0x190>
 92e:	00271793          	slli	a5,a4,0x2
 932:	00000717          	auipc	a4,0x0
 936:	47e70713          	addi	a4,a4,1150 # db0 <malloc+0x246>
 93a:	97ba                	add	a5,a5,a4
 93c:	439c                	lw	a5,0(a5)
 93e:	97ba                	add	a5,a5,a4
 940:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 942:	008b8913          	addi	s2,s7,8
 946:	4685                	li	a3,1
 948:	4629                	li	a2,10
 94a:	000ba583          	lw	a1,0(s7)
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	ebc080e7          	jalr	-324(ra) # 80c <printint>
 958:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b745                	j	8fc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 95e:	008b8913          	addi	s2,s7,8
 962:	4681                	li	a3,0
 964:	4629                	li	a2,10
 966:	000ba583          	lw	a1,0(s7)
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	ea0080e7          	jalr	-352(ra) # 80c <printint>
 974:	8bca                	mv	s7,s2
      state = 0;
 976:	4981                	li	s3,0
 978:	b751                	j	8fc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 97a:	008b8913          	addi	s2,s7,8
 97e:	4681                	li	a3,0
 980:	4641                	li	a2,16
 982:	000ba583          	lw	a1,0(s7)
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	e84080e7          	jalr	-380(ra) # 80c <printint>
 990:	8bca                	mv	s7,s2
      state = 0;
 992:	4981                	li	s3,0
 994:	b7a5                	j	8fc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 996:	008b8c13          	addi	s8,s7,8
 99a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 99e:	03000593          	li	a1,48
 9a2:	8556                	mv	a0,s5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	e46080e7          	jalr	-442(ra) # 7ea <putc>
  putc(fd, 'x');
 9ac:	07800593          	li	a1,120
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	e38080e7          	jalr	-456(ra) # 7ea <putc>
 9ba:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9bc:	00000b97          	auipc	s7,0x0
 9c0:	44cb8b93          	addi	s7,s7,1100 # e08 <digits>
 9c4:	03c9d793          	srli	a5,s3,0x3c
 9c8:	97de                	add	a5,a5,s7
 9ca:	0007c583          	lbu	a1,0(a5)
 9ce:	8556                	mv	a0,s5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	e1a080e7          	jalr	-486(ra) # 7ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9d8:	0992                	slli	s3,s3,0x4
 9da:	397d                	addiw	s2,s2,-1
 9dc:	fe0914e3          	bnez	s2,9c4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9e0:	8be2                	mv	s7,s8
      state = 0;
 9e2:	4981                	li	s3,0
 9e4:	bf21                	j	8fc <vprintf+0x44>
        s = va_arg(ap, char*);
 9e6:	008b8993          	addi	s3,s7,8
 9ea:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9ee:	02090163          	beqz	s2,a10 <vprintf+0x158>
        while(*s != 0){
 9f2:	00094583          	lbu	a1,0(s2)
 9f6:	c9a5                	beqz	a1,a66 <vprintf+0x1ae>
          putc(fd, *s);
 9f8:	8556                	mv	a0,s5
 9fa:	00000097          	auipc	ra,0x0
 9fe:	df0080e7          	jalr	-528(ra) # 7ea <putc>
          s++;
 a02:	0905                	addi	s2,s2,1
        while(*s != 0){
 a04:	00094583          	lbu	a1,0(s2)
 a08:	f9e5                	bnez	a1,9f8 <vprintf+0x140>
        s = va_arg(ap, char*);
 a0a:	8bce                	mv	s7,s3
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	b5fd                	j	8fc <vprintf+0x44>
          s = "(null)";
 a10:	00000917          	auipc	s2,0x0
 a14:	39890913          	addi	s2,s2,920 # da8 <malloc+0x23e>
        while(*s != 0){
 a18:	02800593          	li	a1,40
 a1c:	bff1                	j	9f8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a1e:	008b8913          	addi	s2,s7,8
 a22:	000bc583          	lbu	a1,0(s7)
 a26:	8556                	mv	a0,s5
 a28:	00000097          	auipc	ra,0x0
 a2c:	dc2080e7          	jalr	-574(ra) # 7ea <putc>
 a30:	8bca                	mv	s7,s2
      state = 0;
 a32:	4981                	li	s3,0
 a34:	b5e1                	j	8fc <vprintf+0x44>
        putc(fd, c);
 a36:	02500593          	li	a1,37
 a3a:	8556                	mv	a0,s5
 a3c:	00000097          	auipc	ra,0x0
 a40:	dae080e7          	jalr	-594(ra) # 7ea <putc>
      state = 0;
 a44:	4981                	li	s3,0
 a46:	bd5d                	j	8fc <vprintf+0x44>
        putc(fd, '%');
 a48:	02500593          	li	a1,37
 a4c:	8556                	mv	a0,s5
 a4e:	00000097          	auipc	ra,0x0
 a52:	d9c080e7          	jalr	-612(ra) # 7ea <putc>
        putc(fd, c);
 a56:	85ca                	mv	a1,s2
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	d90080e7          	jalr	-624(ra) # 7ea <putc>
      state = 0;
 a62:	4981                	li	s3,0
 a64:	bd61                	j	8fc <vprintf+0x44>
        s = va_arg(ap, char*);
 a66:	8bce                	mv	s7,s3
      state = 0;
 a68:	4981                	li	s3,0
 a6a:	bd49                	j	8fc <vprintf+0x44>
    }
  }
}
 a6c:	60a6                	ld	ra,72(sp)
 a6e:	6406                	ld	s0,64(sp)
 a70:	74e2                	ld	s1,56(sp)
 a72:	7942                	ld	s2,48(sp)
 a74:	79a2                	ld	s3,40(sp)
 a76:	7a02                	ld	s4,32(sp)
 a78:	6ae2                	ld	s5,24(sp)
 a7a:	6b42                	ld	s6,16(sp)
 a7c:	6ba2                	ld	s7,8(sp)
 a7e:	6c02                	ld	s8,0(sp)
 a80:	6161                	addi	sp,sp,80
 a82:	8082                	ret

0000000000000a84 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a84:	715d                	addi	sp,sp,-80
 a86:	ec06                	sd	ra,24(sp)
 a88:	e822                	sd	s0,16(sp)
 a8a:	1000                	addi	s0,sp,32
 a8c:	e010                	sd	a2,0(s0)
 a8e:	e414                	sd	a3,8(s0)
 a90:	e818                	sd	a4,16(s0)
 a92:	ec1c                	sd	a5,24(s0)
 a94:	03043023          	sd	a6,32(s0)
 a98:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a9c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aa0:	8622                	mv	a2,s0
 aa2:	00000097          	auipc	ra,0x0
 aa6:	e16080e7          	jalr	-490(ra) # 8b8 <vprintf>
}
 aaa:	60e2                	ld	ra,24(sp)
 aac:	6442                	ld	s0,16(sp)
 aae:	6161                	addi	sp,sp,80
 ab0:	8082                	ret

0000000000000ab2 <printf>:

void
printf(const char *fmt, ...)
{
 ab2:	711d                	addi	sp,sp,-96
 ab4:	ec06                	sd	ra,24(sp)
 ab6:	e822                	sd	s0,16(sp)
 ab8:	1000                	addi	s0,sp,32
 aba:	e40c                	sd	a1,8(s0)
 abc:	e810                	sd	a2,16(s0)
 abe:	ec14                	sd	a3,24(s0)
 ac0:	f018                	sd	a4,32(s0)
 ac2:	f41c                	sd	a5,40(s0)
 ac4:	03043823          	sd	a6,48(s0)
 ac8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 acc:	00840613          	addi	a2,s0,8
 ad0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ad4:	85aa                	mv	a1,a0
 ad6:	4505                	li	a0,1
 ad8:	00000097          	auipc	ra,0x0
 adc:	de0080e7          	jalr	-544(ra) # 8b8 <vprintf>
}
 ae0:	60e2                	ld	ra,24(sp)
 ae2:	6442                	ld	s0,16(sp)
 ae4:	6125                	addi	sp,sp,96
 ae6:	8082                	ret

0000000000000ae8 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ae8:	1141                	addi	sp,sp,-16
 aea:	e422                	sd	s0,8(sp)
 aec:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aee:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af2:	00000797          	auipc	a5,0x0
 af6:	5267b783          	ld	a5,1318(a5) # 1018 <freep>
 afa:	a02d                	j	b24 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 afc:	4618                	lw	a4,8(a2)
 afe:	9f2d                	addw	a4,a4,a1
 b00:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b04:	6398                	ld	a4,0(a5)
 b06:	6310                	ld	a2,0(a4)
 b08:	a83d                	j	b46 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b0a:	ff852703          	lw	a4,-8(a0)
 b0e:	9f31                	addw	a4,a4,a2
 b10:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b12:	ff053683          	ld	a3,-16(a0)
 b16:	a091                	j	b5a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	6398                	ld	a4,0(a5)
 b1a:	00e7e463          	bltu	a5,a4,b22 <free+0x3a>
 b1e:	00e6ea63          	bltu	a3,a4,b32 <free+0x4a>
{
 b22:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b24:	fed7fae3          	bgeu	a5,a3,b18 <free+0x30>
 b28:	6398                	ld	a4,0(a5)
 b2a:	00e6e463          	bltu	a3,a4,b32 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2e:	fee7eae3          	bltu	a5,a4,b22 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b32:	ff852583          	lw	a1,-8(a0)
 b36:	6390                	ld	a2,0(a5)
 b38:	02059813          	slli	a6,a1,0x20
 b3c:	01c85713          	srli	a4,a6,0x1c
 b40:	9736                	add	a4,a4,a3
 b42:	fae60de3          	beq	a2,a4,afc <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b46:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b4a:	4790                	lw	a2,8(a5)
 b4c:	02061593          	slli	a1,a2,0x20
 b50:	01c5d713          	srli	a4,a1,0x1c
 b54:	973e                	add	a4,a4,a5
 b56:	fae68ae3          	beq	a3,a4,b0a <free+0x22>
        p->s.ptr = bp->s.ptr;
 b5a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b5c:	00000717          	auipc	a4,0x0
 b60:	4af73e23          	sd	a5,1212(a4) # 1018 <freep>
}
 b64:	6422                	ld	s0,8(sp)
 b66:	0141                	addi	sp,sp,16
 b68:	8082                	ret

0000000000000b6a <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b6a:	7139                	addi	sp,sp,-64
 b6c:	fc06                	sd	ra,56(sp)
 b6e:	f822                	sd	s0,48(sp)
 b70:	f426                	sd	s1,40(sp)
 b72:	f04a                	sd	s2,32(sp)
 b74:	ec4e                	sd	s3,24(sp)
 b76:	e852                	sd	s4,16(sp)
 b78:	e456                	sd	s5,8(sp)
 b7a:	e05a                	sd	s6,0(sp)
 b7c:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b7e:	02051493          	slli	s1,a0,0x20
 b82:	9081                	srli	s1,s1,0x20
 b84:	04bd                	addi	s1,s1,15
 b86:	8091                	srli	s1,s1,0x4
 b88:	0014899b          	addiw	s3,s1,1
 b8c:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b8e:	00000517          	auipc	a0,0x0
 b92:	48a53503          	ld	a0,1162(a0) # 1018 <freep>
 b96:	c515                	beqz	a0,bc2 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b98:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b9a:	4798                	lw	a4,8(a5)
 b9c:	02977f63          	bgeu	a4,s1,bda <malloc+0x70>
    if (nu < 4096)
 ba0:	8a4e                	mv	s4,s3
 ba2:	0009871b          	sext.w	a4,s3
 ba6:	6685                	lui	a3,0x1
 ba8:	00d77363          	bgeu	a4,a3,bae <malloc+0x44>
 bac:	6a05                	lui	s4,0x1
 bae:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bb2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bb6:	00000917          	auipc	s2,0x0
 bba:	46290913          	addi	s2,s2,1122 # 1018 <freep>
    if (p == (char *)-1)
 bbe:	5afd                	li	s5,-1
 bc0:	a895                	j	c34 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bc2:	00000797          	auipc	a5,0x0
 bc6:	4de78793          	addi	a5,a5,1246 # 10a0 <base>
 bca:	00000717          	auipc	a4,0x0
 bce:	44f73723          	sd	a5,1102(a4) # 1018 <freep>
 bd2:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bd4:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bd8:	b7e1                	j	ba0 <malloc+0x36>
            if (p->s.size == nunits)
 bda:	02e48c63          	beq	s1,a4,c12 <malloc+0xa8>
                p->s.size -= nunits;
 bde:	4137073b          	subw	a4,a4,s3
 be2:	c798                	sw	a4,8(a5)
                p += p->s.size;
 be4:	02071693          	slli	a3,a4,0x20
 be8:	01c6d713          	srli	a4,a3,0x1c
 bec:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bee:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bf2:	00000717          	auipc	a4,0x0
 bf6:	42a73323          	sd	a0,1062(a4) # 1018 <freep>
            return (void *)(p + 1);
 bfa:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bfe:	70e2                	ld	ra,56(sp)
 c00:	7442                	ld	s0,48(sp)
 c02:	74a2                	ld	s1,40(sp)
 c04:	7902                	ld	s2,32(sp)
 c06:	69e2                	ld	s3,24(sp)
 c08:	6a42                	ld	s4,16(sp)
 c0a:	6aa2                	ld	s5,8(sp)
 c0c:	6b02                	ld	s6,0(sp)
 c0e:	6121                	addi	sp,sp,64
 c10:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c12:	6398                	ld	a4,0(a5)
 c14:	e118                	sd	a4,0(a0)
 c16:	bff1                	j	bf2 <malloc+0x88>
    hp->s.size = nu;
 c18:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c1c:	0541                	addi	a0,a0,16
 c1e:	00000097          	auipc	ra,0x0
 c22:	eca080e7          	jalr	-310(ra) # ae8 <free>
    return freep;
 c26:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c2a:	d971                	beqz	a0,bfe <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c2c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c2e:	4798                	lw	a4,8(a5)
 c30:	fa9775e3          	bgeu	a4,s1,bda <malloc+0x70>
        if (p == freep)
 c34:	00093703          	ld	a4,0(s2)
 c38:	853e                	mv	a0,a5
 c3a:	fef719e3          	bne	a4,a5,c2c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c3e:	8552                	mv	a0,s4
 c40:	00000097          	auipc	ra,0x0
 c44:	b7a080e7          	jalr	-1158(ra) # 7ba <sbrk>
    if (p == (char *)-1)
 c48:	fd5518e3          	bne	a0,s5,c18 <malloc+0xae>
                return 0;
 c4c:	4501                	li	a0,0
 c4e:	bf45                	j	bfe <malloc+0x94>
