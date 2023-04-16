
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	5aa080e7          	jalr	1450(ra) # 5b6 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	7de080e7          	jalr	2014(ra) # 7fa <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00001517          	auipc	a0,0x1
  3e:	cbe50513          	addi	a0,a0,-834 # cf8 <malloc+0xe6>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	782080e7          	jalr	1922(ra) # 7d2 <fork>
    if(pid < 0)
  58:	02054763          	bltz	a0,86 <forktest+0x58>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00001517          	auipc	a0,0x1
  68:	ca450513          	addi	a0,a0,-860 # d08 <malloc+0xf6>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	764080e7          	jalr	1892(ra) # 7da <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	75c080e7          	jalr	1884(ra) # 7da <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	74e080e7          	jalr	1870(ra) # 7e2 <wait>
  9c:	02054a63          	bltz	a0,d0 <forktest+0xa2>
  for(; n > 0; n--){
  a0:	34fd                	addiw	s1,s1,-1
  a2:	f8e5                	bnez	s1,92 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	73c080e7          	jalr	1852(ra) # 7e2 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	ca450513          	addi	a0,a0,-860 # d58 <malloc+0x146>
  bc:	00000097          	auipc	ra,0x0
  c0:	f44080e7          	jalr	-188(ra) # 0 <print>
}
  c4:	60e2                	ld	ra,24(sp)
  c6:	6442                	ld	s0,16(sp)
  c8:	64a2                	ld	s1,8(sp)
  ca:	6902                	ld	s2,0(sp)
  cc:	6105                	addi	sp,sp,32
  ce:	8082                	ret
      print("wait stopped early\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	c5850513          	addi	a0,a0,-936 # d28 <malloc+0x116>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	6f8080e7          	jalr	1784(ra) # 7da <exit>
    print("wait got too many\n");
  ea:	00001517          	auipc	a0,0x1
  ee:	c5650513          	addi	a0,a0,-938 # d40 <malloc+0x12e>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	6de080e7          	jalr	1758(ra) # 7da <exit>

0000000000000104 <main>:

int
main(void)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  forktest();
 10c:	00000097          	auipc	ra,0x0
 110:	f22080e7          	jalr	-222(ra) # 2e <forktest>
  exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	6c4080e7          	jalr	1732(ra) # 7da <exit>

000000000000011e <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
    lk->name = name;
 124:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 126:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 12a:	57fd                	li	a5,-1
 12c:	00f50823          	sb	a5,16(a0)
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 136:	00054783          	lbu	a5,0(a0)
 13a:	e399                	bnez	a5,140 <holding+0xa>
 13c:	4501                	li	a0,0
}
 13e:	8082                	ret
{
 140:	1101                	addi	sp,sp,-32
 142:	ec06                	sd	ra,24(sp)
 144:	e822                	sd	s0,16(sp)
 146:	e426                	sd	s1,8(sp)
 148:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 14a:	01054483          	lbu	s1,16(a0)
 14e:	00000097          	auipc	ra,0x0
 152:	2dc080e7          	jalr	732(ra) # 42a <twhoami>
 156:	2501                	sext.w	a0,a0
 158:	40a48533          	sub	a0,s1,a0
 15c:	00153513          	seqz	a0,a0
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret

000000000000016a <acquire>:

void acquire(struct lock *lk)
{
 16a:	7179                	addi	sp,sp,-48
 16c:	f406                	sd	ra,40(sp)
 16e:	f022                	sd	s0,32(sp)
 170:	ec26                	sd	s1,24(sp)
 172:	e84a                	sd	s2,16(sp)
 174:	e44e                	sd	s3,8(sp)
 176:	e052                	sd	s4,0(sp)
 178:	1800                	addi	s0,sp,48
 17a:	8a2a                	mv	s4,a0
    if (holding(lk))
 17c:	00000097          	auipc	ra,0x0
 180:	fba080e7          	jalr	-70(ra) # 136 <holding>
 184:	e919                	bnez	a0,19a <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 186:	ffca7493          	andi	s1,s4,-4
 18a:	003a7913          	andi	s2,s4,3
 18e:	0039191b          	slliw	s2,s2,0x3
 192:	4985                	li	s3,1
 194:	012999bb          	sllw	s3,s3,s2
 198:	a015                	j	1bc <acquire+0x52>
        printf("re-acquiring lock we already hold");
 19a:	00001517          	auipc	a0,0x1
 19e:	bce50513          	addi	a0,a0,-1074 # d68 <malloc+0x156>
 1a2:	00001097          	auipc	ra,0x1
 1a6:	9b8080e7          	jalr	-1608(ra) # b5a <printf>
        exit(-1);
 1aa:	557d                	li	a0,-1
 1ac:	00000097          	auipc	ra,0x0
 1b0:	62e080e7          	jalr	1582(ra) # 7da <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b4:	00000097          	auipc	ra,0x0
 1b8:	252080e7          	jalr	594(ra) # 406 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1bc:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1c0:	0127d7bb          	srlw	a5,a5,s2
 1c4:	0ff7f793          	zext.b	a5,a5
 1c8:	f7f5                	bnez	a5,1b4 <acquire+0x4a>
    }

    __sync_synchronize();
 1ca:	0ff0000f          	fence

    lk->tid = twhoami();
 1ce:	00000097          	auipc	ra,0x0
 1d2:	25c080e7          	jalr	604(ra) # 42a <twhoami>
 1d6:	00aa0823          	sb	a0,16(s4)
}
 1da:	70a2                	ld	ra,40(sp)
 1dc:	7402                	ld	s0,32(sp)
 1de:	64e2                	ld	s1,24(sp)
 1e0:	6942                	ld	s2,16(sp)
 1e2:	69a2                	ld	s3,8(sp)
 1e4:	6a02                	ld	s4,0(sp)
 1e6:	6145                	addi	sp,sp,48
 1e8:	8082                	ret

00000000000001ea <release>:

void release(struct lock *lk)
{
 1ea:	1101                	addi	sp,sp,-32
 1ec:	ec06                	sd	ra,24(sp)
 1ee:	e822                	sd	s0,16(sp)
 1f0:	e426                	sd	s1,8(sp)
 1f2:	1000                	addi	s0,sp,32
 1f4:	84aa                	mv	s1,a0
    if (!holding(lk))
 1f6:	00000097          	auipc	ra,0x0
 1fa:	f40080e7          	jalr	-192(ra) # 136 <holding>
 1fe:	c11d                	beqz	a0,224 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 200:	57fd                	li	a5,-1
 202:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 206:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 20a:	0ff0000f          	fence
 20e:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 212:	00000097          	auipc	ra,0x0
 216:	1f4080e7          	jalr	500(ra) # 406 <tyield>
}
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	64a2                	ld	s1,8(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret
        printf("releasing lock we are not holding");
 224:	00001517          	auipc	a0,0x1
 228:	b6c50513          	addi	a0,a0,-1172 # d90 <malloc+0x17e>
 22c:	00001097          	auipc	ra,0x1
 230:	92e080e7          	jalr	-1746(ra) # b5a <printf>
        exit(-1);
 234:	557d                	li	a0,-1
 236:	00000097          	auipc	ra,0x0
 23a:	5a4080e7          	jalr	1444(ra) # 7da <exit>

000000000000023e <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 23e:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 240:	00001617          	auipc	a2,0x1
 244:	cd060613          	addi	a2,a2,-816 # f10 <threads>
 248:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 24a:	45c1                	li	a1,16
 24c:	a021                	j	254 <tsched+0x16>
 24e:	2685                	addiw	a3,a3,1
 250:	08b68c63          	beq	a3,a1,2e8 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 254:	41f6d71b          	sraiw	a4,a3,0x1f
 258:	01c7571b          	srliw	a4,a4,0x1c
 25c:	00d707bb          	addw	a5,a4,a3
 260:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 262:	9f99                	subw	a5,a5,a4
 264:	078e                	slli	a5,a5,0x3
 266:	97b2                	add	a5,a5,a2
 268:	639c                	ld	a5,0(a5)
 26a:	d3f5                	beqz	a5,24e <tsched+0x10>
 26c:	5fb8                	lw	a4,120(a5)
 26e:	fea710e3          	bne	a4,a0,24e <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 272:	00001717          	auipc	a4,0x1
 276:	c9e73703          	ld	a4,-866(a4) # f10 <threads>
 27a:	5f30                	lw	a2,120(a4)
 27c:	468d                	li	a3,3
 27e:	06d60363          	beq	a2,a3,2e4 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 282:	c3a5                	beqz	a5,2e2 <tsched+0xa4>
{
 284:	1101                	addi	sp,sp,-32
 286:	ec06                	sd	ra,24(sp)
 288:	e822                	sd	s0,16(sp)
 28a:	e426                	sd	s1,8(sp)
 28c:	e04a                	sd	s2,0(sp)
 28e:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 290:	00001497          	auipc	s1,0x1
 294:	c7048493          	addi	s1,s1,-912 # f00 <current_thread>
 298:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 29c:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 29e:	0007c603          	lbu	a2,0(a5)
 2a2:	00094583          	lbu	a1,0(s2)
 2a6:	00001517          	auipc	a0,0x1
 2aa:	b1250513          	addi	a0,a0,-1262 # db8 <malloc+0x1a6>
 2ae:	00001097          	auipc	ra,0x1
 2b2:	8ac080e7          	jalr	-1876(ra) # b5a <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2b6:	608c                	ld	a1,0(s1)
 2b8:	05a1                	addi	a1,a1,8
 2ba:	00890513          	addi	a0,s2,8
 2be:	00000097          	auipc	ra,0x0
 2c2:	184080e7          	jalr	388(ra) # 442 <tswtch>
        printf("Thread switch complete\n");
 2c6:	00001517          	auipc	a0,0x1
 2ca:	b1a50513          	addi	a0,a0,-1254 # de0 <malloc+0x1ce>
 2ce:	00001097          	auipc	ra,0x1
 2d2:	88c080e7          	jalr	-1908(ra) # b5a <printf>
    }
}
 2d6:	60e2                	ld	ra,24(sp)
 2d8:	6442                	ld	s0,16(sp)
 2da:	64a2                	ld	s1,8(sp)
 2dc:	6902                	ld	s2,0(sp)
 2de:	6105                	addi	sp,sp,32
 2e0:	8082                	ret
 2e2:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 2e4:	87ba                	mv	a5,a4
 2e6:	bf79                	j	284 <tsched+0x46>
 2e8:	00001797          	auipc	a5,0x1
 2ec:	c287b783          	ld	a5,-984(a5) # f10 <threads>
 2f0:	5fb4                	lw	a3,120(a5)
 2f2:	470d                	li	a4,3
 2f4:	f8e688e3          	beq	a3,a4,284 <tsched+0x46>
 2f8:	8082                	ret

00000000000002fa <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2fa:	7179                	addi	sp,sp,-48
 2fc:	f406                	sd	ra,40(sp)
 2fe:	f022                	sd	s0,32(sp)
 300:	ec26                	sd	s1,24(sp)
 302:	e84a                	sd	s2,16(sp)
 304:	e44e                	sd	s3,8(sp)
 306:	1800                	addi	s0,sp,48
 308:	84aa                	mv	s1,a0
 30a:	89b2                	mv	s3,a2
 30c:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 30e:	09000513          	li	a0,144
 312:	00001097          	auipc	ra,0x1
 316:	900080e7          	jalr	-1792(ra) # c12 <malloc>
 31a:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 31c:	478d                	li	a5,3
 31e:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 320:	609c                	ld	a5,0(s1)
 322:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 326:	609c                	ld	a5,0(s1)
 328:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 32c:	00001717          	auipc	a4,0x1
 330:	bd070713          	addi	a4,a4,-1072 # efc <next_tid>
 334:	431c                	lw	a5,0(a4)
 336:	0017869b          	addiw	a3,a5,1
 33a:	c314                	sw	a3,0(a4)
 33c:	6098                	ld	a4,0(s1)
 33e:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 342:	00001717          	auipc	a4,0x1
 346:	bce70713          	addi	a4,a4,-1074 # f10 <threads>
 34a:	4781                	li	a5,0
 34c:	4641                	li	a2,16
    if (threads[i] == NULL) {
 34e:	6314                	ld	a3,0(a4)
 350:	ce81                	beqz	a3,368 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 352:	2785                	addiw	a5,a5,1
 354:	0721                	addi	a4,a4,8
 356:	fec79ce3          	bne	a5,a2,34e <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 35a:	70a2                	ld	ra,40(sp)
 35c:	7402                	ld	s0,32(sp)
 35e:	64e2                	ld	s1,24(sp)
 360:	6942                	ld	s2,16(sp)
 362:	69a2                	ld	s3,8(sp)
 364:	6145                	addi	sp,sp,48
 366:	8082                	ret
        threads[i] = *thread;
 368:	6094                	ld	a3,0(s1)
 36a:	078e                	slli	a5,a5,0x3
 36c:	00001717          	auipc	a4,0x1
 370:	ba470713          	addi	a4,a4,-1116 # f10 <threads>
 374:	97ba                	add	a5,a5,a4
 376:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 378:	0006c583          	lbu	a1,0(a3)
 37c:	00001517          	auipc	a0,0x1
 380:	a7c50513          	addi	a0,a0,-1412 # df8 <malloc+0x1e6>
 384:	00000097          	auipc	ra,0x0
 388:	7d6080e7          	jalr	2006(ra) # b5a <printf>
        break;
 38c:	b7f9                	j	35a <tcreate+0x60>

000000000000038e <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 38e:	7179                	addi	sp,sp,-48
 390:	f406                	sd	ra,40(sp)
 392:	f022                	sd	s0,32(sp)
 394:	ec26                	sd	s1,24(sp)
 396:	e84a                	sd	s2,16(sp)
 398:	e44e                	sd	s3,8(sp)
 39a:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 39c:	00001797          	auipc	a5,0x1
 3a0:	b7478793          	addi	a5,a5,-1164 # f10 <threads>
 3a4:	00001697          	auipc	a3,0x1
 3a8:	bec68693          	addi	a3,a3,-1044 # f90 <base>
 3ac:	a021                	j	3b4 <tjoin+0x26>
 3ae:	07a1                	addi	a5,a5,8
 3b0:	04d78763          	beq	a5,a3,3fe <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 3b4:	6384                	ld	s1,0(a5)
 3b6:	dce5                	beqz	s1,3ae <tjoin+0x20>
 3b8:	0004c703          	lbu	a4,0(s1)
 3bc:	fea719e3          	bne	a4,a0,3ae <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 3c0:	5cb8                	lw	a4,120(s1)
 3c2:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3c4:	00001997          	auipc	s3,0x1
 3c8:	a6498993          	addi	s3,s3,-1436 # e28 <malloc+0x216>
    while (target_thread->state != EXITED) {
 3cc:	4919                	li	s2,6
 3ce:	02f70a63          	beq	a4,a5,402 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3d2:	0004c583          	lbu	a1,0(s1)
 3d6:	854e                	mv	a0,s3
 3d8:	00000097          	auipc	ra,0x0
 3dc:	782080e7          	jalr	1922(ra) # b5a <printf>
        tsched();
 3e0:	00000097          	auipc	ra,0x0
 3e4:	e5e080e7          	jalr	-418(ra) # 23e <tsched>
    while (target_thread->state != EXITED) {
 3e8:	5cbc                	lw	a5,120(s1)
 3ea:	ff2794e3          	bne	a5,s2,3d2 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 3ee:	4501                	li	a0,0
}
 3f0:	70a2                	ld	ra,40(sp)
 3f2:	7402                	ld	s0,32(sp)
 3f4:	64e2                	ld	s1,24(sp)
 3f6:	6942                	ld	s2,16(sp)
 3f8:	69a2                	ld	s3,8(sp)
 3fa:	6145                	addi	sp,sp,48
 3fc:	8082                	ret
        return -1;
 3fe:	557d                	li	a0,-1
 400:	bfc5                	j	3f0 <tjoin+0x62>
    return 0;
 402:	4501                	li	a0,0
 404:	b7f5                	j	3f0 <tjoin+0x62>

0000000000000406 <tyield>:


void tyield()
{
 406:	1141                	addi	sp,sp,-16
 408:	e406                	sd	ra,8(sp)
 40a:	e022                	sd	s0,0(sp)
 40c:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 40e:	00001797          	auipc	a5,0x1
 412:	af27b783          	ld	a5,-1294(a5) # f00 <current_thread>
 416:	470d                	li	a4,3
 418:	dfb8                	sw	a4,120(a5)
    tsched();
 41a:	00000097          	auipc	ra,0x0
 41e:	e24080e7          	jalr	-476(ra) # 23e <tsched>
}
 422:	60a2                	ld	ra,8(sp)
 424:	6402                	ld	s0,0(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret

000000000000042a <twhoami>:

uint8 twhoami()
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 430:	00001797          	auipc	a5,0x1
 434:	ad07b783          	ld	a5,-1328(a5) # f00 <current_thread>
 438:	0007c503          	lbu	a0,0(a5)
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret

0000000000000442 <tswtch>:
 442:	00153023          	sd	ra,0(a0)
 446:	00253423          	sd	sp,8(a0)
 44a:	e900                	sd	s0,16(a0)
 44c:	ed04                	sd	s1,24(a0)
 44e:	03253023          	sd	s2,32(a0)
 452:	03353423          	sd	s3,40(a0)
 456:	03453823          	sd	s4,48(a0)
 45a:	03553c23          	sd	s5,56(a0)
 45e:	05653023          	sd	s6,64(a0)
 462:	05753423          	sd	s7,72(a0)
 466:	05853823          	sd	s8,80(a0)
 46a:	05953c23          	sd	s9,88(a0)
 46e:	07a53023          	sd	s10,96(a0)
 472:	07b53423          	sd	s11,104(a0)
 476:	0005b083          	ld	ra,0(a1)
 47a:	0085b103          	ld	sp,8(a1)
 47e:	6980                	ld	s0,16(a1)
 480:	6d84                	ld	s1,24(a1)
 482:	0205b903          	ld	s2,32(a1)
 486:	0285b983          	ld	s3,40(a1)
 48a:	0305ba03          	ld	s4,48(a1)
 48e:	0385ba83          	ld	s5,56(a1)
 492:	0405bb03          	ld	s6,64(a1)
 496:	0485bb83          	ld	s7,72(a1)
 49a:	0505bc03          	ld	s8,80(a1)
 49e:	0585bc83          	ld	s9,88(a1)
 4a2:	0605bd03          	ld	s10,96(a1)
 4a6:	0685bd83          	ld	s11,104(a1)
 4aa:	8082                	ret

00000000000004ac <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4ac:	715d                	addi	sp,sp,-80
 4ae:	e486                	sd	ra,72(sp)
 4b0:	e0a2                	sd	s0,64(sp)
 4b2:	fc26                	sd	s1,56(sp)
 4b4:	f84a                	sd	s2,48(sp)
 4b6:	f44e                	sd	s3,40(sp)
 4b8:	f052                	sd	s4,32(sp)
 4ba:	ec56                	sd	s5,24(sp)
 4bc:	e85a                	sd	s6,16(sp)
 4be:	e45e                	sd	s7,8(sp)
 4c0:	0880                	addi	s0,sp,80
 4c2:	892a                	mv	s2,a0
 4c4:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 4c6:	00001517          	auipc	a0,0x1
 4ca:	98250513          	addi	a0,a0,-1662 # e48 <malloc+0x236>
 4ce:	00000097          	auipc	ra,0x0
 4d2:	68c080e7          	jalr	1676(ra) # b5a <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4d6:	09000513          	li	a0,144
 4da:	00000097          	auipc	ra,0x0
 4de:	738080e7          	jalr	1848(ra) # c12 <malloc>

    main_thread->tid = 0;
 4e2:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 4e6:	4791                	li	a5,4
 4e8:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4ea:	00001797          	auipc	a5,0x1
 4ee:	a0a7bb23          	sd	a0,-1514(a5) # f00 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4f2:	00001a17          	auipc	s4,0x1
 4f6:	a1ea0a13          	addi	s4,s4,-1506 # f10 <threads>
 4fa:	00001497          	auipc	s1,0x1
 4fe:	a9648493          	addi	s1,s1,-1386 # f90 <base>
    current_thread = main_thread;
 502:	87d2                	mv	a5,s4
        threads[i] = NULL;
 504:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 508:	07a1                	addi	a5,a5,8
 50a:	fe979de3          	bne	a5,s1,504 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 50e:	00001797          	auipc	a5,0x1
 512:	a0a7b123          	sd	a0,-1534(a5) # f10 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 516:	85ce                	mv	a1,s3
 518:	854a                	mv	a0,s2
 51a:	00000097          	auipc	ra,0x0
 51e:	bea080e7          	jalr	-1046(ra) # 104 <main>
 522:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 524:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 526:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 528:	00001a97          	auipc	s5,0x1
 52c:	940a8a93          	addi	s5,s5,-1728 # e68 <malloc+0x256>
 530:	a03d                	j	55e <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 532:	07a1                	addi	a5,a5,8
 534:	00978963          	beq	a5,s1,546 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 538:	6398                	ld	a4,0(a5)
 53a:	df65                	beqz	a4,532 <_main+0x86>
 53c:	5f38                	lw	a4,120(a4)
 53e:	ff370ae3          	beq	a4,s3,532 <_main+0x86>
                running_threads++;
 542:	2905                	addiw	s2,s2,1
 544:	b7fd                	j	532 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 546:	85ca                	mv	a1,s2
 548:	8556                	mv	a0,s5
 54a:	00000097          	auipc	ra,0x0
 54e:	610080e7          	jalr	1552(ra) # b5a <printf>
        if (running_threads > 0) {
 552:	01205963          	blez	s2,564 <_main+0xb8>
            tsched(); // Schedule another thread to run
 556:	00000097          	auipc	ra,0x0
 55a:	ce8080e7          	jalr	-792(ra) # 23e <tsched>
    current_thread = main_thread;
 55e:	87d2                	mv	a5,s4
        running_threads = 0;
 560:	895a                	mv	s2,s6
 562:	bfd9                	j	538 <_main+0x8c>
        }
    }

    exit(res);
 564:	855e                	mv	a0,s7
 566:	00000097          	auipc	ra,0x0
 56a:	274080e7          	jalr	628(ra) # 7da <exit>

000000000000056e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 56e:	1141                	addi	sp,sp,-16
 570:	e422                	sd	s0,8(sp)
 572:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 574:	87aa                	mv	a5,a0
 576:	0585                	addi	a1,a1,1
 578:	0785                	addi	a5,a5,1
 57a:	fff5c703          	lbu	a4,-1(a1)
 57e:	fee78fa3          	sb	a4,-1(a5)
 582:	fb75                	bnez	a4,576 <strcpy+0x8>
        ;
    return os;
}
 584:	6422                	ld	s0,8(sp)
 586:	0141                	addi	sp,sp,16
 588:	8082                	ret

000000000000058a <strcmp>:

int strcmp(const char *p, const char *q)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e422                	sd	s0,8(sp)
 58e:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 590:	00054783          	lbu	a5,0(a0)
 594:	cb91                	beqz	a5,5a8 <strcmp+0x1e>
 596:	0005c703          	lbu	a4,0(a1)
 59a:	00f71763          	bne	a4,a5,5a8 <strcmp+0x1e>
        p++, q++;
 59e:	0505                	addi	a0,a0,1
 5a0:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 5a2:	00054783          	lbu	a5,0(a0)
 5a6:	fbe5                	bnez	a5,596 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 5a8:	0005c503          	lbu	a0,0(a1)
}
 5ac:	40a7853b          	subw	a0,a5,a0
 5b0:	6422                	ld	s0,8(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret

00000000000005b6 <strlen>:

uint strlen(const char *s)
{
 5b6:	1141                	addi	sp,sp,-16
 5b8:	e422                	sd	s0,8(sp)
 5ba:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 5bc:	00054783          	lbu	a5,0(a0)
 5c0:	cf91                	beqz	a5,5dc <strlen+0x26>
 5c2:	0505                	addi	a0,a0,1
 5c4:	87aa                	mv	a5,a0
 5c6:	86be                	mv	a3,a5
 5c8:	0785                	addi	a5,a5,1
 5ca:	fff7c703          	lbu	a4,-1(a5)
 5ce:	ff65                	bnez	a4,5c6 <strlen+0x10>
 5d0:	40a6853b          	subw	a0,a3,a0
 5d4:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret
    for (n = 0; s[n]; n++)
 5dc:	4501                	li	a0,0
 5de:	bfe5                	j	5d6 <strlen+0x20>

00000000000005e0 <memset>:

void *
memset(void *dst, int c, uint n)
{
 5e0:	1141                	addi	sp,sp,-16
 5e2:	e422                	sd	s0,8(sp)
 5e4:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5e6:	ca19                	beqz	a2,5fc <memset+0x1c>
 5e8:	87aa                	mv	a5,a0
 5ea:	1602                	slli	a2,a2,0x20
 5ec:	9201                	srli	a2,a2,0x20
 5ee:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5f2:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5f6:	0785                	addi	a5,a5,1
 5f8:	fee79de3          	bne	a5,a4,5f2 <memset+0x12>
    }
    return dst;
}
 5fc:	6422                	ld	s0,8(sp)
 5fe:	0141                	addi	sp,sp,16
 600:	8082                	ret

0000000000000602 <strchr>:

char *
strchr(const char *s, char c)
{
 602:	1141                	addi	sp,sp,-16
 604:	e422                	sd	s0,8(sp)
 606:	0800                	addi	s0,sp,16
    for (; *s; s++)
 608:	00054783          	lbu	a5,0(a0)
 60c:	cb99                	beqz	a5,622 <strchr+0x20>
        if (*s == c)
 60e:	00f58763          	beq	a1,a5,61c <strchr+0x1a>
    for (; *s; s++)
 612:	0505                	addi	a0,a0,1
 614:	00054783          	lbu	a5,0(a0)
 618:	fbfd                	bnez	a5,60e <strchr+0xc>
            return (char *)s;
    return 0;
 61a:	4501                	li	a0,0
}
 61c:	6422                	ld	s0,8(sp)
 61e:	0141                	addi	sp,sp,16
 620:	8082                	ret
    return 0;
 622:	4501                	li	a0,0
 624:	bfe5                	j	61c <strchr+0x1a>

0000000000000626 <gets>:

char *
gets(char *buf, int max)
{
 626:	711d                	addi	sp,sp,-96
 628:	ec86                	sd	ra,88(sp)
 62a:	e8a2                	sd	s0,80(sp)
 62c:	e4a6                	sd	s1,72(sp)
 62e:	e0ca                	sd	s2,64(sp)
 630:	fc4e                	sd	s3,56(sp)
 632:	f852                	sd	s4,48(sp)
 634:	f456                	sd	s5,40(sp)
 636:	f05a                	sd	s6,32(sp)
 638:	ec5e                	sd	s7,24(sp)
 63a:	1080                	addi	s0,sp,96
 63c:	8baa                	mv	s7,a0
 63e:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 640:	892a                	mv	s2,a0
 642:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 644:	4aa9                	li	s5,10
 646:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 648:	89a6                	mv	s3,s1
 64a:	2485                	addiw	s1,s1,1
 64c:	0344d863          	bge	s1,s4,67c <gets+0x56>
        cc = read(0, &c, 1);
 650:	4605                	li	a2,1
 652:	faf40593          	addi	a1,s0,-81
 656:	4501                	li	a0,0
 658:	00000097          	auipc	ra,0x0
 65c:	19a080e7          	jalr	410(ra) # 7f2 <read>
        if (cc < 1)
 660:	00a05e63          	blez	a0,67c <gets+0x56>
        buf[i++] = c;
 664:	faf44783          	lbu	a5,-81(s0)
 668:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 66c:	01578763          	beq	a5,s5,67a <gets+0x54>
 670:	0905                	addi	s2,s2,1
 672:	fd679be3          	bne	a5,s6,648 <gets+0x22>
    for (i = 0; i + 1 < max;)
 676:	89a6                	mv	s3,s1
 678:	a011                	j	67c <gets+0x56>
 67a:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 67c:	99de                	add	s3,s3,s7
 67e:	00098023          	sb	zero,0(s3)
    return buf;
}
 682:	855e                	mv	a0,s7
 684:	60e6                	ld	ra,88(sp)
 686:	6446                	ld	s0,80(sp)
 688:	64a6                	ld	s1,72(sp)
 68a:	6906                	ld	s2,64(sp)
 68c:	79e2                	ld	s3,56(sp)
 68e:	7a42                	ld	s4,48(sp)
 690:	7aa2                	ld	s5,40(sp)
 692:	7b02                	ld	s6,32(sp)
 694:	6be2                	ld	s7,24(sp)
 696:	6125                	addi	sp,sp,96
 698:	8082                	ret

000000000000069a <stat>:

int stat(const char *n, struct stat *st)
{
 69a:	1101                	addi	sp,sp,-32
 69c:	ec06                	sd	ra,24(sp)
 69e:	e822                	sd	s0,16(sp)
 6a0:	e426                	sd	s1,8(sp)
 6a2:	e04a                	sd	s2,0(sp)
 6a4:	1000                	addi	s0,sp,32
 6a6:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 6a8:	4581                	li	a1,0
 6aa:	00000097          	auipc	ra,0x0
 6ae:	170080e7          	jalr	368(ra) # 81a <open>
    if (fd < 0)
 6b2:	02054563          	bltz	a0,6dc <stat+0x42>
 6b6:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 6b8:	85ca                	mv	a1,s2
 6ba:	00000097          	auipc	ra,0x0
 6be:	178080e7          	jalr	376(ra) # 832 <fstat>
 6c2:	892a                	mv	s2,a0
    close(fd);
 6c4:	8526                	mv	a0,s1
 6c6:	00000097          	auipc	ra,0x0
 6ca:	13c080e7          	jalr	316(ra) # 802 <close>
    return r;
}
 6ce:	854a                	mv	a0,s2
 6d0:	60e2                	ld	ra,24(sp)
 6d2:	6442                	ld	s0,16(sp)
 6d4:	64a2                	ld	s1,8(sp)
 6d6:	6902                	ld	s2,0(sp)
 6d8:	6105                	addi	sp,sp,32
 6da:	8082                	ret
        return -1;
 6dc:	597d                	li	s2,-1
 6de:	bfc5                	j	6ce <stat+0x34>

00000000000006e0 <atoi>:

int atoi(const char *s)
{
 6e0:	1141                	addi	sp,sp,-16
 6e2:	e422                	sd	s0,8(sp)
 6e4:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6e6:	00054683          	lbu	a3,0(a0)
 6ea:	fd06879b          	addiw	a5,a3,-48
 6ee:	0ff7f793          	zext.b	a5,a5
 6f2:	4625                	li	a2,9
 6f4:	02f66863          	bltu	a2,a5,724 <atoi+0x44>
 6f8:	872a                	mv	a4,a0
    n = 0;
 6fa:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6fc:	0705                	addi	a4,a4,1
 6fe:	0025179b          	slliw	a5,a0,0x2
 702:	9fa9                	addw	a5,a5,a0
 704:	0017979b          	slliw	a5,a5,0x1
 708:	9fb5                	addw	a5,a5,a3
 70a:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 70e:	00074683          	lbu	a3,0(a4)
 712:	fd06879b          	addiw	a5,a3,-48
 716:	0ff7f793          	zext.b	a5,a5
 71a:	fef671e3          	bgeu	a2,a5,6fc <atoi+0x1c>
    return n;
}
 71e:	6422                	ld	s0,8(sp)
 720:	0141                	addi	sp,sp,16
 722:	8082                	ret
    n = 0;
 724:	4501                	li	a0,0
 726:	bfe5                	j	71e <atoi+0x3e>

0000000000000728 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 728:	1141                	addi	sp,sp,-16
 72a:	e422                	sd	s0,8(sp)
 72c:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 72e:	02b57463          	bgeu	a0,a1,756 <memmove+0x2e>
    {
        while (n-- > 0)
 732:	00c05f63          	blez	a2,750 <memmove+0x28>
 736:	1602                	slli	a2,a2,0x20
 738:	9201                	srli	a2,a2,0x20
 73a:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 73e:	872a                	mv	a4,a0
            *dst++ = *src++;
 740:	0585                	addi	a1,a1,1
 742:	0705                	addi	a4,a4,1
 744:	fff5c683          	lbu	a3,-1(a1)
 748:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 74c:	fee79ae3          	bne	a5,a4,740 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 750:	6422                	ld	s0,8(sp)
 752:	0141                	addi	sp,sp,16
 754:	8082                	ret
        dst += n;
 756:	00c50733          	add	a4,a0,a2
        src += n;
 75a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 75c:	fec05ae3          	blez	a2,750 <memmove+0x28>
 760:	fff6079b          	addiw	a5,a2,-1
 764:	1782                	slli	a5,a5,0x20
 766:	9381                	srli	a5,a5,0x20
 768:	fff7c793          	not	a5,a5
 76c:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 76e:	15fd                	addi	a1,a1,-1
 770:	177d                	addi	a4,a4,-1
 772:	0005c683          	lbu	a3,0(a1)
 776:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 77a:	fee79ae3          	bne	a5,a4,76e <memmove+0x46>
 77e:	bfc9                	j	750 <memmove+0x28>

0000000000000780 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 780:	1141                	addi	sp,sp,-16
 782:	e422                	sd	s0,8(sp)
 784:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 786:	ca05                	beqz	a2,7b6 <memcmp+0x36>
 788:	fff6069b          	addiw	a3,a2,-1
 78c:	1682                	slli	a3,a3,0x20
 78e:	9281                	srli	a3,a3,0x20
 790:	0685                	addi	a3,a3,1
 792:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 794:	00054783          	lbu	a5,0(a0)
 798:	0005c703          	lbu	a4,0(a1)
 79c:	00e79863          	bne	a5,a4,7ac <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 7a0:	0505                	addi	a0,a0,1
        p2++;
 7a2:	0585                	addi	a1,a1,1
    while (n-- > 0)
 7a4:	fed518e3          	bne	a0,a3,794 <memcmp+0x14>
    }
    return 0;
 7a8:	4501                	li	a0,0
 7aa:	a019                	j	7b0 <memcmp+0x30>
            return *p1 - *p2;
 7ac:	40e7853b          	subw	a0,a5,a4
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret
    return 0;
 7b6:	4501                	li	a0,0
 7b8:	bfe5                	j	7b0 <memcmp+0x30>

00000000000007ba <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7ba:	1141                	addi	sp,sp,-16
 7bc:	e406                	sd	ra,8(sp)
 7be:	e022                	sd	s0,0(sp)
 7c0:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 7c2:	00000097          	auipc	ra,0x0
 7c6:	f66080e7          	jalr	-154(ra) # 728 <memmove>
}
 7ca:	60a2                	ld	ra,8(sp)
 7cc:	6402                	ld	s0,0(sp)
 7ce:	0141                	addi	sp,sp,16
 7d0:	8082                	ret

00000000000007d2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7d2:	4885                	li	a7,1
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <exit>:
.global exit
exit:
 li a7, SYS_exit
 7da:	4889                	li	a7,2
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7e2:	488d                	li	a7,3
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7ea:	4891                	li	a7,4
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <read>:
.global read
read:
 li a7, SYS_read
 7f2:	4895                	li	a7,5
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <write>:
.global write
write:
 li a7, SYS_write
 7fa:	48c1                	li	a7,16
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <close>:
.global close
close:
 li a7, SYS_close
 802:	48d5                	li	a7,21
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <kill>:
.global kill
kill:
 li a7, SYS_kill
 80a:	4899                	li	a7,6
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <exec>:
.global exec
exec:
 li a7, SYS_exec
 812:	489d                	li	a7,7
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <open>:
.global open
open:
 li a7, SYS_open
 81a:	48bd                	li	a7,15
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 822:	48c5                	li	a7,17
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 82a:	48c9                	li	a7,18
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 832:	48a1                	li	a7,8
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <link>:
.global link
link:
 li a7, SYS_link
 83a:	48cd                	li	a7,19
 ecall
 83c:	00000073          	ecall
 ret
 840:	8082                	ret

0000000000000842 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 842:	48d1                	li	a7,20
 ecall
 844:	00000073          	ecall
 ret
 848:	8082                	ret

000000000000084a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 84a:	48a5                	li	a7,9
 ecall
 84c:	00000073          	ecall
 ret
 850:	8082                	ret

0000000000000852 <dup>:
.global dup
dup:
 li a7, SYS_dup
 852:	48a9                	li	a7,10
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 85a:	48ad                	li	a7,11
 ecall
 85c:	00000073          	ecall
 ret
 860:	8082                	ret

0000000000000862 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 862:	48b1                	li	a7,12
 ecall
 864:	00000073          	ecall
 ret
 868:	8082                	ret

000000000000086a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 86a:	48b5                	li	a7,13
 ecall
 86c:	00000073          	ecall
 ret
 870:	8082                	ret

0000000000000872 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 872:	48b9                	li	a7,14
 ecall
 874:	00000073          	ecall
 ret
 878:	8082                	ret

000000000000087a <ps>:
.global ps
ps:
 li a7, SYS_ps
 87a:	48d9                	li	a7,22
 ecall
 87c:	00000073          	ecall
 ret
 880:	8082                	ret

0000000000000882 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 882:	48dd                	li	a7,23
 ecall
 884:	00000073          	ecall
 ret
 888:	8082                	ret

000000000000088a <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 88a:	48e1                	li	a7,24
 ecall
 88c:	00000073          	ecall
 ret
 890:	8082                	ret

0000000000000892 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 892:	1101                	addi	sp,sp,-32
 894:	ec06                	sd	ra,24(sp)
 896:	e822                	sd	s0,16(sp)
 898:	1000                	addi	s0,sp,32
 89a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 89e:	4605                	li	a2,1
 8a0:	fef40593          	addi	a1,s0,-17
 8a4:	00000097          	auipc	ra,0x0
 8a8:	f56080e7          	jalr	-170(ra) # 7fa <write>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6105                	addi	sp,sp,32
 8b2:	8082                	ret

00000000000008b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8b4:	7139                	addi	sp,sp,-64
 8b6:	fc06                	sd	ra,56(sp)
 8b8:	f822                	sd	s0,48(sp)
 8ba:	f426                	sd	s1,40(sp)
 8bc:	f04a                	sd	s2,32(sp)
 8be:	ec4e                	sd	s3,24(sp)
 8c0:	0080                	addi	s0,sp,64
 8c2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8c4:	c299                	beqz	a3,8ca <printint+0x16>
 8c6:	0805c963          	bltz	a1,958 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8ca:	2581                	sext.w	a1,a1
  neg = 0;
 8cc:	4881                	li	a7,0
 8ce:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8d2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8d4:	2601                	sext.w	a2,a2
 8d6:	00000517          	auipc	a0,0x0
 8da:	61250513          	addi	a0,a0,1554 # ee8 <digits>
 8de:	883a                	mv	a6,a4
 8e0:	2705                	addiw	a4,a4,1
 8e2:	02c5f7bb          	remuw	a5,a1,a2
 8e6:	1782                	slli	a5,a5,0x20
 8e8:	9381                	srli	a5,a5,0x20
 8ea:	97aa                	add	a5,a5,a0
 8ec:	0007c783          	lbu	a5,0(a5)
 8f0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8f4:	0005879b          	sext.w	a5,a1
 8f8:	02c5d5bb          	divuw	a1,a1,a2
 8fc:	0685                	addi	a3,a3,1
 8fe:	fec7f0e3          	bgeu	a5,a2,8de <printint+0x2a>
  if(neg)
 902:	00088c63          	beqz	a7,91a <printint+0x66>
    buf[i++] = '-';
 906:	fd070793          	addi	a5,a4,-48
 90a:	00878733          	add	a4,a5,s0
 90e:	02d00793          	li	a5,45
 912:	fef70823          	sb	a5,-16(a4)
 916:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 91a:	02e05863          	blez	a4,94a <printint+0x96>
 91e:	fc040793          	addi	a5,s0,-64
 922:	00e78933          	add	s2,a5,a4
 926:	fff78993          	addi	s3,a5,-1
 92a:	99ba                	add	s3,s3,a4
 92c:	377d                	addiw	a4,a4,-1
 92e:	1702                	slli	a4,a4,0x20
 930:	9301                	srli	a4,a4,0x20
 932:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 936:	fff94583          	lbu	a1,-1(s2)
 93a:	8526                	mv	a0,s1
 93c:	00000097          	auipc	ra,0x0
 940:	f56080e7          	jalr	-170(ra) # 892 <putc>
  while(--i >= 0)
 944:	197d                	addi	s2,s2,-1
 946:	ff3918e3          	bne	s2,s3,936 <printint+0x82>
}
 94a:	70e2                	ld	ra,56(sp)
 94c:	7442                	ld	s0,48(sp)
 94e:	74a2                	ld	s1,40(sp)
 950:	7902                	ld	s2,32(sp)
 952:	69e2                	ld	s3,24(sp)
 954:	6121                	addi	sp,sp,64
 956:	8082                	ret
    x = -xx;
 958:	40b005bb          	negw	a1,a1
    neg = 1;
 95c:	4885                	li	a7,1
    x = -xx;
 95e:	bf85                	j	8ce <printint+0x1a>

0000000000000960 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 960:	715d                	addi	sp,sp,-80
 962:	e486                	sd	ra,72(sp)
 964:	e0a2                	sd	s0,64(sp)
 966:	fc26                	sd	s1,56(sp)
 968:	f84a                	sd	s2,48(sp)
 96a:	f44e                	sd	s3,40(sp)
 96c:	f052                	sd	s4,32(sp)
 96e:	ec56                	sd	s5,24(sp)
 970:	e85a                	sd	s6,16(sp)
 972:	e45e                	sd	s7,8(sp)
 974:	e062                	sd	s8,0(sp)
 976:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 978:	0005c903          	lbu	s2,0(a1)
 97c:	18090c63          	beqz	s2,b14 <vprintf+0x1b4>
 980:	8aaa                	mv	s5,a0
 982:	8bb2                	mv	s7,a2
 984:	00158493          	addi	s1,a1,1
  state = 0;
 988:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 98a:	02500a13          	li	s4,37
 98e:	4b55                	li	s6,21
 990:	a839                	j	9ae <vprintf+0x4e>
        putc(fd, c);
 992:	85ca                	mv	a1,s2
 994:	8556                	mv	a0,s5
 996:	00000097          	auipc	ra,0x0
 99a:	efc080e7          	jalr	-260(ra) # 892 <putc>
 99e:	a019                	j	9a4 <vprintf+0x44>
    } else if(state == '%'){
 9a0:	01498d63          	beq	s3,s4,9ba <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 9a4:	0485                	addi	s1,s1,1
 9a6:	fff4c903          	lbu	s2,-1(s1)
 9aa:	16090563          	beqz	s2,b14 <vprintf+0x1b4>
    if(state == 0){
 9ae:	fe0999e3          	bnez	s3,9a0 <vprintf+0x40>
      if(c == '%'){
 9b2:	ff4910e3          	bne	s2,s4,992 <vprintf+0x32>
        state = '%';
 9b6:	89d2                	mv	s3,s4
 9b8:	b7f5                	j	9a4 <vprintf+0x44>
      if(c == 'd'){
 9ba:	13490263          	beq	s2,s4,ade <vprintf+0x17e>
 9be:	f9d9079b          	addiw	a5,s2,-99
 9c2:	0ff7f793          	zext.b	a5,a5
 9c6:	12fb6563          	bltu	s6,a5,af0 <vprintf+0x190>
 9ca:	f9d9079b          	addiw	a5,s2,-99
 9ce:	0ff7f713          	zext.b	a4,a5
 9d2:	10eb6f63          	bltu	s6,a4,af0 <vprintf+0x190>
 9d6:	00271793          	slli	a5,a4,0x2
 9da:	00000717          	auipc	a4,0x0
 9de:	4b670713          	addi	a4,a4,1206 # e90 <malloc+0x27e>
 9e2:	97ba                	add	a5,a5,a4
 9e4:	439c                	lw	a5,0(a5)
 9e6:	97ba                	add	a5,a5,a4
 9e8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9ea:	008b8913          	addi	s2,s7,8
 9ee:	4685                	li	a3,1
 9f0:	4629                	li	a2,10
 9f2:	000ba583          	lw	a1,0(s7)
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	ebc080e7          	jalr	-324(ra) # 8b4 <printint>
 a00:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a02:	4981                	li	s3,0
 a04:	b745                	j	9a4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a06:	008b8913          	addi	s2,s7,8
 a0a:	4681                	li	a3,0
 a0c:	4629                	li	a2,10
 a0e:	000ba583          	lw	a1,0(s7)
 a12:	8556                	mv	a0,s5
 a14:	00000097          	auipc	ra,0x0
 a18:	ea0080e7          	jalr	-352(ra) # 8b4 <printint>
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	b751                	j	9a4 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a22:	008b8913          	addi	s2,s7,8
 a26:	4681                	li	a3,0
 a28:	4641                	li	a2,16
 a2a:	000ba583          	lw	a1,0(s7)
 a2e:	8556                	mv	a0,s5
 a30:	00000097          	auipc	ra,0x0
 a34:	e84080e7          	jalr	-380(ra) # 8b4 <printint>
 a38:	8bca                	mv	s7,s2
      state = 0;
 a3a:	4981                	li	s3,0
 a3c:	b7a5                	j	9a4 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a3e:	008b8c13          	addi	s8,s7,8
 a42:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a46:	03000593          	li	a1,48
 a4a:	8556                	mv	a0,s5
 a4c:	00000097          	auipc	ra,0x0
 a50:	e46080e7          	jalr	-442(ra) # 892 <putc>
  putc(fd, 'x');
 a54:	07800593          	li	a1,120
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	e38080e7          	jalr	-456(ra) # 892 <putc>
 a62:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a64:	00000b97          	auipc	s7,0x0
 a68:	484b8b93          	addi	s7,s7,1156 # ee8 <digits>
 a6c:	03c9d793          	srli	a5,s3,0x3c
 a70:	97de                	add	a5,a5,s7
 a72:	0007c583          	lbu	a1,0(a5)
 a76:	8556                	mv	a0,s5
 a78:	00000097          	auipc	ra,0x0
 a7c:	e1a080e7          	jalr	-486(ra) # 892 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a80:	0992                	slli	s3,s3,0x4
 a82:	397d                	addiw	s2,s2,-1
 a84:	fe0914e3          	bnez	s2,a6c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a88:	8be2                	mv	s7,s8
      state = 0;
 a8a:	4981                	li	s3,0
 a8c:	bf21                	j	9a4 <vprintf+0x44>
        s = va_arg(ap, char*);
 a8e:	008b8993          	addi	s3,s7,8
 a92:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a96:	02090163          	beqz	s2,ab8 <vprintf+0x158>
        while(*s != 0){
 a9a:	00094583          	lbu	a1,0(s2)
 a9e:	c9a5                	beqz	a1,b0e <vprintf+0x1ae>
          putc(fd, *s);
 aa0:	8556                	mv	a0,s5
 aa2:	00000097          	auipc	ra,0x0
 aa6:	df0080e7          	jalr	-528(ra) # 892 <putc>
          s++;
 aaa:	0905                	addi	s2,s2,1
        while(*s != 0){
 aac:	00094583          	lbu	a1,0(s2)
 ab0:	f9e5                	bnez	a1,aa0 <vprintf+0x140>
        s = va_arg(ap, char*);
 ab2:	8bce                	mv	s7,s3
      state = 0;
 ab4:	4981                	li	s3,0
 ab6:	b5fd                	j	9a4 <vprintf+0x44>
          s = "(null)";
 ab8:	00000917          	auipc	s2,0x0
 abc:	3d090913          	addi	s2,s2,976 # e88 <malloc+0x276>
        while(*s != 0){
 ac0:	02800593          	li	a1,40
 ac4:	bff1                	j	aa0 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 ac6:	008b8913          	addi	s2,s7,8
 aca:	000bc583          	lbu	a1,0(s7)
 ace:	8556                	mv	a0,s5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	dc2080e7          	jalr	-574(ra) # 892 <putc>
 ad8:	8bca                	mv	s7,s2
      state = 0;
 ada:	4981                	li	s3,0
 adc:	b5e1                	j	9a4 <vprintf+0x44>
        putc(fd, c);
 ade:	02500593          	li	a1,37
 ae2:	8556                	mv	a0,s5
 ae4:	00000097          	auipc	ra,0x0
 ae8:	dae080e7          	jalr	-594(ra) # 892 <putc>
      state = 0;
 aec:	4981                	li	s3,0
 aee:	bd5d                	j	9a4 <vprintf+0x44>
        putc(fd, '%');
 af0:	02500593          	li	a1,37
 af4:	8556                	mv	a0,s5
 af6:	00000097          	auipc	ra,0x0
 afa:	d9c080e7          	jalr	-612(ra) # 892 <putc>
        putc(fd, c);
 afe:	85ca                	mv	a1,s2
 b00:	8556                	mv	a0,s5
 b02:	00000097          	auipc	ra,0x0
 b06:	d90080e7          	jalr	-624(ra) # 892 <putc>
      state = 0;
 b0a:	4981                	li	s3,0
 b0c:	bd61                	j	9a4 <vprintf+0x44>
        s = va_arg(ap, char*);
 b0e:	8bce                	mv	s7,s3
      state = 0;
 b10:	4981                	li	s3,0
 b12:	bd49                	j	9a4 <vprintf+0x44>
    }
  }
}
 b14:	60a6                	ld	ra,72(sp)
 b16:	6406                	ld	s0,64(sp)
 b18:	74e2                	ld	s1,56(sp)
 b1a:	7942                	ld	s2,48(sp)
 b1c:	79a2                	ld	s3,40(sp)
 b1e:	7a02                	ld	s4,32(sp)
 b20:	6ae2                	ld	s5,24(sp)
 b22:	6b42                	ld	s6,16(sp)
 b24:	6ba2                	ld	s7,8(sp)
 b26:	6c02                	ld	s8,0(sp)
 b28:	6161                	addi	sp,sp,80
 b2a:	8082                	ret

0000000000000b2c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b2c:	715d                	addi	sp,sp,-80
 b2e:	ec06                	sd	ra,24(sp)
 b30:	e822                	sd	s0,16(sp)
 b32:	1000                	addi	s0,sp,32
 b34:	e010                	sd	a2,0(s0)
 b36:	e414                	sd	a3,8(s0)
 b38:	e818                	sd	a4,16(s0)
 b3a:	ec1c                	sd	a5,24(s0)
 b3c:	03043023          	sd	a6,32(s0)
 b40:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b44:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b48:	8622                	mv	a2,s0
 b4a:	00000097          	auipc	ra,0x0
 b4e:	e16080e7          	jalr	-490(ra) # 960 <vprintf>
}
 b52:	60e2                	ld	ra,24(sp)
 b54:	6442                	ld	s0,16(sp)
 b56:	6161                	addi	sp,sp,80
 b58:	8082                	ret

0000000000000b5a <printf>:

void
printf(const char *fmt, ...)
{
 b5a:	711d                	addi	sp,sp,-96
 b5c:	ec06                	sd	ra,24(sp)
 b5e:	e822                	sd	s0,16(sp)
 b60:	1000                	addi	s0,sp,32
 b62:	e40c                	sd	a1,8(s0)
 b64:	e810                	sd	a2,16(s0)
 b66:	ec14                	sd	a3,24(s0)
 b68:	f018                	sd	a4,32(s0)
 b6a:	f41c                	sd	a5,40(s0)
 b6c:	03043823          	sd	a6,48(s0)
 b70:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b74:	00840613          	addi	a2,s0,8
 b78:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b7c:	85aa                	mv	a1,a0
 b7e:	4505                	li	a0,1
 b80:	00000097          	auipc	ra,0x0
 b84:	de0080e7          	jalr	-544(ra) # 960 <vprintf>
}
 b88:	60e2                	ld	ra,24(sp)
 b8a:	6442                	ld	s0,16(sp)
 b8c:	6125                	addi	sp,sp,96
 b8e:	8082                	ret

0000000000000b90 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b90:	1141                	addi	sp,sp,-16
 b92:	e422                	sd	s0,8(sp)
 b94:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b96:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9a:	00000797          	auipc	a5,0x0
 b9e:	36e7b783          	ld	a5,878(a5) # f08 <freep>
 ba2:	a02d                	j	bcc <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ba4:	4618                	lw	a4,8(a2)
 ba6:	9f2d                	addw	a4,a4,a1
 ba8:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 bac:	6398                	ld	a4,0(a5)
 bae:	6310                	ld	a2,0(a4)
 bb0:	a83d                	j	bee <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 bb2:	ff852703          	lw	a4,-8(a0)
 bb6:	9f31                	addw	a4,a4,a2
 bb8:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 bba:	ff053683          	ld	a3,-16(a0)
 bbe:	a091                	j	c02 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc0:	6398                	ld	a4,0(a5)
 bc2:	00e7e463          	bltu	a5,a4,bca <free+0x3a>
 bc6:	00e6ea63          	bltu	a3,a4,bda <free+0x4a>
{
 bca:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bcc:	fed7fae3          	bgeu	a5,a3,bc0 <free+0x30>
 bd0:	6398                	ld	a4,0(a5)
 bd2:	00e6e463          	bltu	a3,a4,bda <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd6:	fee7eae3          	bltu	a5,a4,bca <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 bda:	ff852583          	lw	a1,-8(a0)
 bde:	6390                	ld	a2,0(a5)
 be0:	02059813          	slli	a6,a1,0x20
 be4:	01c85713          	srli	a4,a6,0x1c
 be8:	9736                	add	a4,a4,a3
 bea:	fae60de3          	beq	a2,a4,ba4 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bee:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bf2:	4790                	lw	a2,8(a5)
 bf4:	02061593          	slli	a1,a2,0x20
 bf8:	01c5d713          	srli	a4,a1,0x1c
 bfc:	973e                	add	a4,a4,a5
 bfe:	fae68ae3          	beq	a3,a4,bb2 <free+0x22>
        p->s.ptr = bp->s.ptr;
 c02:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 c04:	00000717          	auipc	a4,0x0
 c08:	30f73223          	sd	a5,772(a4) # f08 <freep>
}
 c0c:	6422                	ld	s0,8(sp)
 c0e:	0141                	addi	sp,sp,16
 c10:	8082                	ret

0000000000000c12 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c12:	7139                	addi	sp,sp,-64
 c14:	fc06                	sd	ra,56(sp)
 c16:	f822                	sd	s0,48(sp)
 c18:	f426                	sd	s1,40(sp)
 c1a:	f04a                	sd	s2,32(sp)
 c1c:	ec4e                	sd	s3,24(sp)
 c1e:	e852                	sd	s4,16(sp)
 c20:	e456                	sd	s5,8(sp)
 c22:	e05a                	sd	s6,0(sp)
 c24:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c26:	02051493          	slli	s1,a0,0x20
 c2a:	9081                	srli	s1,s1,0x20
 c2c:	04bd                	addi	s1,s1,15
 c2e:	8091                	srli	s1,s1,0x4
 c30:	0014899b          	addiw	s3,s1,1
 c34:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c36:	00000517          	auipc	a0,0x0
 c3a:	2d253503          	ld	a0,722(a0) # f08 <freep>
 c3e:	c515                	beqz	a0,c6a <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c40:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c42:	4798                	lw	a4,8(a5)
 c44:	02977f63          	bgeu	a4,s1,c82 <malloc+0x70>
    if (nu < 4096)
 c48:	8a4e                	mv	s4,s3
 c4a:	0009871b          	sext.w	a4,s3
 c4e:	6685                	lui	a3,0x1
 c50:	00d77363          	bgeu	a4,a3,c56 <malloc+0x44>
 c54:	6a05                	lui	s4,0x1
 c56:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c5a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c5e:	00000917          	auipc	s2,0x0
 c62:	2aa90913          	addi	s2,s2,682 # f08 <freep>
    if (p == (char *)-1)
 c66:	5afd                	li	s5,-1
 c68:	a895                	j	cdc <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c6a:	00000797          	auipc	a5,0x0
 c6e:	32678793          	addi	a5,a5,806 # f90 <base>
 c72:	00000717          	auipc	a4,0x0
 c76:	28f73b23          	sd	a5,662(a4) # f08 <freep>
 c7a:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c7c:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c80:	b7e1                	j	c48 <malloc+0x36>
            if (p->s.size == nunits)
 c82:	02e48c63          	beq	s1,a4,cba <malloc+0xa8>
                p->s.size -= nunits;
 c86:	4137073b          	subw	a4,a4,s3
 c8a:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c8c:	02071693          	slli	a3,a4,0x20
 c90:	01c6d713          	srli	a4,a3,0x1c
 c94:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c96:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c9a:	00000717          	auipc	a4,0x0
 c9e:	26a73723          	sd	a0,622(a4) # f08 <freep>
            return (void *)(p + 1);
 ca2:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ca6:	70e2                	ld	ra,56(sp)
 ca8:	7442                	ld	s0,48(sp)
 caa:	74a2                	ld	s1,40(sp)
 cac:	7902                	ld	s2,32(sp)
 cae:	69e2                	ld	s3,24(sp)
 cb0:	6a42                	ld	s4,16(sp)
 cb2:	6aa2                	ld	s5,8(sp)
 cb4:	6b02                	ld	s6,0(sp)
 cb6:	6121                	addi	sp,sp,64
 cb8:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 cba:	6398                	ld	a4,0(a5)
 cbc:	e118                	sd	a4,0(a0)
 cbe:	bff1                	j	c9a <malloc+0x88>
    hp->s.size = nu;
 cc0:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 cc4:	0541                	addi	a0,a0,16
 cc6:	00000097          	auipc	ra,0x0
 cca:	eca080e7          	jalr	-310(ra) # b90 <free>
    return freep;
 cce:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 cd2:	d971                	beqz	a0,ca6 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cd4:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 cd6:	4798                	lw	a4,8(a5)
 cd8:	fa9775e3          	bgeu	a4,s1,c82 <malloc+0x70>
        if (p == freep)
 cdc:	00093703          	ld	a4,0(s2)
 ce0:	853e                	mv	a0,a5
 ce2:	fef719e3          	bne	a4,a5,cd4 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ce6:	8552                	mv	a0,s4
 ce8:	00000097          	auipc	ra,0x0
 cec:	b7a080e7          	jalr	-1158(ra) # 862 <sbrk>
    if (p == (char *)-1)
 cf0:	fd5518e3          	bne	a0,s5,cc0 <malloc+0xae>
                return 0;
 cf4:	4501                	li	a0,0
 cf6:	bf45                	j	ca6 <malloc+0x94>
