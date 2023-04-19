
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:
#include "user.h"

char buf[512];

void cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
    int n;

    while ((n = read(fd, buf, sizeof(buf))) > 0)
  10:	00001917          	auipc	s2,0x1
  14:	01090913          	addi	s2,s2,16 # 1020 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	75a080e7          	jalr	1882(ra) # 77a <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    {
        if (write(1, buf, n) != n)
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	74e080e7          	jalr	1870(ra) # 782 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
        {
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	c4058593          	addi	a1,a1,-960 # c80 <malloc+0xe6>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	a6a080e7          	jalr	-1430(ra) # ab4 <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	70e080e7          	jalr	1806(ra) # 762 <exit>
        }
    }
    if (n < 0)
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    {
        fprintf(2, "cat: read error\n");
        exit(1);
    }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
        fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	c2a58593          	addi	a1,a1,-982 # c98 <malloc+0xfe>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	a3c080e7          	jalr	-1476(ra) # ab4 <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	6e0080e7          	jalr	1760(ra) # 762 <exit>

000000000000008a <main>:

int main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	1800                	addi	s0,sp,48
    int fd, i;

    if (argc <= 1)
  98:	4785                	li	a5,1
  9a:	04a7d763          	bge	a5,a0,e8 <main+0x5e>
  9e:	00858913          	addi	s2,a1,8
  a2:	ffe5099b          	addiw	s3,a0,-2
  a6:	02099793          	slli	a5,s3,0x20
  aa:	01d7d993          	srli	s3,a5,0x1d
  ae:	05c1                	addi	a1,a1,16
  b0:	99ae                	add	s3,s3,a1
        exit(0);
    }

    for (i = 1; i < argc; i++)
    {
        if ((fd = open(argv[i], 0)) < 0)
  b2:	4581                	li	a1,0
  b4:	00093503          	ld	a0,0(s2)
  b8:	00000097          	auipc	ra,0x0
  bc:	6ea080e7          	jalr	1770(ra) # 7a2 <open>
  c0:	84aa                	mv	s1,a0
  c2:	02054d63          	bltz	a0,fc <main+0x72>
        {
            fprintf(2, "cat: cannot open %s\n", argv[i]);
            exit(1);
        }
        cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
        close(fd);
  ce:	8526                	mv	a0,s1
  d0:	00000097          	auipc	ra,0x0
  d4:	6ba080e7          	jalr	1722(ra) # 78a <close>
    for (i = 1; i < argc; i++)
  d8:	0921                	addi	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
    }
    exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	682080e7          	jalr	1666(ra) # 762 <exit>
        cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
        exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	66e080e7          	jalr	1646(ra) # 762 <exit>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	00093603          	ld	a2,0(s2)
 100:	00001597          	auipc	a1,0x1
 104:	bb058593          	addi	a1,a1,-1104 # cb0 <malloc+0x116>
 108:	4509                	li	a0,2
 10a:	00001097          	auipc	ra,0x1
 10e:	9aa080e7          	jalr	-1622(ra) # ab4 <fprintf>
            exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	64e080e7          	jalr	1614(ra) # 762 <exit>

000000000000011c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
    lk->name = name;
 122:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 124:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 128:	57fd                	li	a5,-1
 12a:	00f50823          	sb	a5,16(a0)
}
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 134:	00054783          	lbu	a5,0(a0)
 138:	e399                	bnez	a5,13e <holding+0xa>
 13a:	4501                	li	a0,0
}
 13c:	8082                	ret
{
 13e:	1101                	addi	sp,sp,-32
 140:	ec06                	sd	ra,24(sp)
 142:	e822                	sd	s0,16(sp)
 144:	e426                	sd	s1,8(sp)
 146:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 148:	01054483          	lbu	s1,16(a0)
 14c:	00000097          	auipc	ra,0x0
 150:	2c4080e7          	jalr	708(ra) # 410 <twhoami>
 154:	2501                	sext.w	a0,a0
 156:	40a48533          	sub	a0,s1,a0
 15a:	00153513          	seqz	a0,a0
}
 15e:	60e2                	ld	ra,24(sp)
 160:	6442                	ld	s0,16(sp)
 162:	64a2                	ld	s1,8(sp)
 164:	6105                	addi	sp,sp,32
 166:	8082                	ret

0000000000000168 <acquire>:

void acquire(struct lock *lk)
{
 168:	7179                	addi	sp,sp,-48
 16a:	f406                	sd	ra,40(sp)
 16c:	f022                	sd	s0,32(sp)
 16e:	ec26                	sd	s1,24(sp)
 170:	e84a                	sd	s2,16(sp)
 172:	e44e                	sd	s3,8(sp)
 174:	e052                	sd	s4,0(sp)
 176:	1800                	addi	s0,sp,48
 178:	8a2a                	mv	s4,a0
    if (holding(lk))
 17a:	00000097          	auipc	ra,0x0
 17e:	fba080e7          	jalr	-70(ra) # 134 <holding>
 182:	e919                	bnez	a0,198 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 184:	ffca7493          	andi	s1,s4,-4
 188:	003a7913          	andi	s2,s4,3
 18c:	0039191b          	slliw	s2,s2,0x3
 190:	4985                	li	s3,1
 192:	012999bb          	sllw	s3,s3,s2
 196:	a015                	j	1ba <acquire+0x52>
        printf("re-acquiring lock we already hold");
 198:	00001517          	auipc	a0,0x1
 19c:	b3050513          	addi	a0,a0,-1232 # cc8 <malloc+0x12e>
 1a0:	00001097          	auipc	ra,0x1
 1a4:	942080e7          	jalr	-1726(ra) # ae2 <printf>
        exit(-1);
 1a8:	557d                	li	a0,-1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	5b8080e7          	jalr	1464(ra) # 762 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b2:	00000097          	auipc	ra,0x0
 1b6:	1dc080e7          	jalr	476(ra) # 38e <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1ba:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1be:	0127d7bb          	srlw	a5,a5,s2
 1c2:	0ff7f793          	zext.b	a5,a5
 1c6:	f7f5                	bnez	a5,1b2 <acquire+0x4a>
    }

    __sync_synchronize();
 1c8:	0ff0000f          	fence

    lk->tid = twhoami();
 1cc:	00000097          	auipc	ra,0x0
 1d0:	244080e7          	jalr	580(ra) # 410 <twhoami>
 1d4:	00aa0823          	sb	a0,16(s4)
}
 1d8:	70a2                	ld	ra,40(sp)
 1da:	7402                	ld	s0,32(sp)
 1dc:	64e2                	ld	s1,24(sp)
 1de:	6942                	ld	s2,16(sp)
 1e0:	69a2                	ld	s3,8(sp)
 1e2:	6a02                	ld	s4,0(sp)
 1e4:	6145                	addi	sp,sp,48
 1e6:	8082                	ret

00000000000001e8 <release>:

void release(struct lock *lk)
{
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	84aa                	mv	s1,a0
    if (!holding(lk))
 1f4:	00000097          	auipc	ra,0x0
 1f8:	f40080e7          	jalr	-192(ra) # 134 <holding>
 1fc:	c11d                	beqz	a0,222 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1fe:	57fd                	li	a5,-1
 200:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 204:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 208:	0ff0000f          	fence
 20c:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 210:	00000097          	auipc	ra,0x0
 214:	17e080e7          	jalr	382(ra) # 38e <tyield>
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
        printf("releasing lock we are not holding");
 222:	00001517          	auipc	a0,0x1
 226:	ace50513          	addi	a0,a0,-1330 # cf0 <malloc+0x156>
 22a:	00001097          	auipc	ra,0x1
 22e:	8b8080e7          	jalr	-1864(ra) # ae2 <printf>
        exit(-1);
 232:	557d                	li	a0,-1
 234:	00000097          	auipc	ra,0x0
 238:	52e080e7          	jalr	1326(ra) # 762 <exit>

000000000000023c <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 23c:	00001517          	auipc	a0,0x1
 240:	dd453503          	ld	a0,-556(a0) # 1010 <current_thread>
 244:	00001717          	auipc	a4,0x1
 248:	fdc70713          	addi	a4,a4,-36 # 1220 <threads>
    for (int i = 0; i < 16; i++) {
 24c:	4781                	li	a5,0
 24e:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 250:	6314                	ld	a3,0(a4)
 252:	00a68763          	beq	a3,a0,260 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 256:	2785                	addiw	a5,a5,1
 258:	0721                	addi	a4,a4,8
 25a:	fec79be3          	bne	a5,a2,250 <tsched+0x14>
    int current_index = 0;
 25e:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 260:	0017869b          	addiw	a3,a5,1
 264:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 268:	00001817          	auipc	a6,0x1
 26c:	fb880813          	addi	a6,a6,-72 # 1220 <threads>
 270:	488d                	li	a7,3
 272:	a021                	j	27a <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 274:	2685                	addiw	a3,a3,1
 276:	04c68363          	beq	a3,a2,2bc <tsched+0x80>
        int next_index = (current_index + i) % 16;
 27a:	41f6d71b          	sraiw	a4,a3,0x1f
 27e:	01c7571b          	srliw	a4,a4,0x1c
 282:	00d707bb          	addw	a5,a4,a3
 286:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 288:	9f99                	subw	a5,a5,a4
 28a:	078e                	slli	a5,a5,0x3
 28c:	97c2                	add	a5,a5,a6
 28e:	638c                	ld	a1,0(a5)
 290:	d1f5                	beqz	a1,274 <tsched+0x38>
 292:	5dbc                	lw	a5,120(a1)
 294:	ff1790e3          	bne	a5,a7,274 <tsched+0x38>
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 2a0:	00001797          	auipc	a5,0x1
 2a4:	d6b7b823          	sd	a1,-656(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2a8:	05a1                	addi	a1,a1,8
 2aa:	0521                	addi	a0,a0,8
 2ac:	00000097          	auipc	ra,0x0
 2b0:	17c080e7          	jalr	380(ra) # 428 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 2b4:	60a2                	ld	ra,8(sp)
 2b6:	6402                	ld	s0,0(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret
 2bc:	8082                	ret

00000000000002be <thread_wrapper>:
{
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 2c8:	00001497          	auipc	s1,0x1
 2cc:	d4848493          	addi	s1,s1,-696 # 1010 <current_thread>
 2d0:	609c                	ld	a5,0(s1)
 2d2:	67d8                	ld	a4,136(a5)
 2d4:	63c8                	ld	a0,128(a5)
 2d6:	9702                	jalr	a4
    current_thread->state = EXITED;
 2d8:	609c                	ld	a5,0(s1)
 2da:	4719                	li	a4,6
 2dc:	dfb8                	sw	a4,120(a5)
    tsched();
 2de:	00000097          	auipc	ra,0x0
 2e2:	f5e080e7          	jalr	-162(ra) # 23c <tsched>
}
 2e6:	60e2                	ld	ra,24(sp)
 2e8:	6442                	ld	s0,16(sp)
 2ea:	64a2                	ld	s1,8(sp)
 2ec:	6105                	addi	sp,sp,32
 2ee:	8082                	ret

00000000000002f0 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2f0:	7179                	addi	sp,sp,-48
 2f2:	f406                	sd	ra,40(sp)
 2f4:	f022                	sd	s0,32(sp)
 2f6:	ec26                	sd	s1,24(sp)
 2f8:	e84a                	sd	s2,16(sp)
 2fa:	e44e                	sd	s3,8(sp)
 2fc:	1800                	addi	s0,sp,48
 2fe:	84aa                	mv	s1,a0
 300:	89b2                	mv	s3,a2
 302:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 304:	09800513          	li	a0,152
 308:	00001097          	auipc	ra,0x1
 30c:	892080e7          	jalr	-1902(ra) # b9a <malloc>
 310:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 312:	478d                	li	a5,3
 314:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 316:	609c                	ld	a5,0(s1)
 318:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 31c:	609c                	ld	a5,0(s1)
 31e:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 322:	6098                	ld	a4,0(s1)
 324:	00001797          	auipc	a5,0x1
 328:	cdc78793          	addi	a5,a5,-804 # 1000 <next_tid>
 32c:	4394                	lw	a3,0(a5)
 32e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 332:	4398                	lw	a4,0(a5)
 334:	2705                	addiw	a4,a4,1
 336:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 338:	6505                	lui	a0,0x1
 33a:	00001097          	auipc	ra,0x1
 33e:	860080e7          	jalr	-1952(ra) # b9a <malloc>
 342:	609c                	ld	a5,0(s1)
 344:	6705                	lui	a4,0x1
 346:	953a                	add	a0,a0,a4
 348:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 34a:	609c                	ld	a5,0(s1)
 34c:	00000717          	auipc	a4,0x0
 350:	f7270713          	addi	a4,a4,-142 # 2be <thread_wrapper>
 354:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 356:	00001717          	auipc	a4,0x1
 35a:	eca70713          	addi	a4,a4,-310 # 1220 <threads>
 35e:	4781                	li	a5,0
 360:	4641                	li	a2,16
        if (threads[i] == NULL) {
 362:	6314                	ld	a3,0(a4)
 364:	ce81                	beqz	a3,37c <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 366:	2785                	addiw	a5,a5,1
 368:	0721                	addi	a4,a4,8
 36a:	fec79ce3          	bne	a5,a2,362 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 36e:	70a2                	ld	ra,40(sp)
 370:	7402                	ld	s0,32(sp)
 372:	64e2                	ld	s1,24(sp)
 374:	6942                	ld	s2,16(sp)
 376:	69a2                	ld	s3,8(sp)
 378:	6145                	addi	sp,sp,48
 37a:	8082                	ret
            threads[i] = *thread;
 37c:	6094                	ld	a3,0(s1)
 37e:	078e                	slli	a5,a5,0x3
 380:	00001717          	auipc	a4,0x1
 384:	ea070713          	addi	a4,a4,-352 # 1220 <threads>
 388:	97ba                	add	a5,a5,a4
 38a:	e394                	sd	a3,0(a5)
            break;
 38c:	b7cd                	j	36e <tcreate+0x7e>

000000000000038e <tyield>:
    return 0;
}


void tyield()
{
 38e:	1141                	addi	sp,sp,-16
 390:	e406                	sd	ra,8(sp)
 392:	e022                	sd	s0,0(sp)
 394:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 396:	00001797          	auipc	a5,0x1
 39a:	c7a7b783          	ld	a5,-902(a5) # 1010 <current_thread>
 39e:	470d                	li	a4,3
 3a0:	dfb8                	sw	a4,120(a5)
    tsched();
 3a2:	00000097          	auipc	ra,0x0
 3a6:	e9a080e7          	jalr	-358(ra) # 23c <tsched>
}
 3aa:	60a2                	ld	ra,8(sp)
 3ac:	6402                	ld	s0,0(sp)
 3ae:	0141                	addi	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <tjoin>:
{
 3b2:	1101                	addi	sp,sp,-32
 3b4:	ec06                	sd	ra,24(sp)
 3b6:	e822                	sd	s0,16(sp)
 3b8:	e426                	sd	s1,8(sp)
 3ba:	e04a                	sd	s2,0(sp)
 3bc:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 3be:	00001797          	auipc	a5,0x1
 3c2:	e6278793          	addi	a5,a5,-414 # 1220 <threads>
 3c6:	00001697          	auipc	a3,0x1
 3ca:	eda68693          	addi	a3,a3,-294 # 12a0 <base>
 3ce:	a021                	j	3d6 <tjoin+0x24>
 3d0:	07a1                	addi	a5,a5,8
 3d2:	02d78b63          	beq	a5,a3,408 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3d6:	6384                	ld	s1,0(a5)
 3d8:	dce5                	beqz	s1,3d0 <tjoin+0x1e>
 3da:	0004c703          	lbu	a4,0(s1)
 3de:	fea719e3          	bne	a4,a0,3d0 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3e2:	5cb8                	lw	a4,120(s1)
 3e4:	4799                	li	a5,6
 3e6:	4919                	li	s2,6
 3e8:	02f70263          	beq	a4,a5,40c <tjoin+0x5a>
        tyield();
 3ec:	00000097          	auipc	ra,0x0
 3f0:	fa2080e7          	jalr	-94(ra) # 38e <tyield>
    while (target_thread->state != EXITED) {
 3f4:	5cbc                	lw	a5,120(s1)
 3f6:	ff279be3          	bne	a5,s2,3ec <tjoin+0x3a>
    return 0;
 3fa:	4501                	li	a0,0
}
 3fc:	60e2                	ld	ra,24(sp)
 3fe:	6442                	ld	s0,16(sp)
 400:	64a2                	ld	s1,8(sp)
 402:	6902                	ld	s2,0(sp)
 404:	6105                	addi	sp,sp,32
 406:	8082                	ret
        return -1;
 408:	557d                	li	a0,-1
 40a:	bfcd                	j	3fc <tjoin+0x4a>
    return 0;
 40c:	4501                	li	a0,0
 40e:	b7fd                	j	3fc <tjoin+0x4a>

0000000000000410 <twhoami>:

uint8 twhoami()
{
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 416:	00001797          	auipc	a5,0x1
 41a:	bfa7b783          	ld	a5,-1030(a5) # 1010 <current_thread>
 41e:	0007c503          	lbu	a0,0(a5)
 422:	6422                	ld	s0,8(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <tswtch>:
 428:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 42c:	00253423          	sd	sp,8(a0)
 430:	e900                	sd	s0,16(a0)
 432:	ed04                	sd	s1,24(a0)
 434:	03253023          	sd	s2,32(a0)
 438:	03353423          	sd	s3,40(a0)
 43c:	03453823          	sd	s4,48(a0)
 440:	03553c23          	sd	s5,56(a0)
 444:	05653023          	sd	s6,64(a0)
 448:	05753423          	sd	s7,72(a0)
 44c:	05853823          	sd	s8,80(a0)
 450:	05953c23          	sd	s9,88(a0)
 454:	07a53023          	sd	s10,96(a0)
 458:	07b53423          	sd	s11,104(a0)
 45c:	0005b083          	ld	ra,0(a1)
 460:	0085b103          	ld	sp,8(a1)
 464:	6980                	ld	s0,16(a1)
 466:	6d84                	ld	s1,24(a1)
 468:	0205b903          	ld	s2,32(a1)
 46c:	0285b983          	ld	s3,40(a1)
 470:	0305ba03          	ld	s4,48(a1)
 474:	0385ba83          	ld	s5,56(a1)
 478:	0405bb03          	ld	s6,64(a1)
 47c:	0485bb83          	ld	s7,72(a1)
 480:	0505bc03          	ld	s8,80(a1)
 484:	0585bc83          	ld	s9,88(a1)
 488:	0605bd03          	ld	s10,96(a1)
 48c:	0685bd83          	ld	s11,104(a1)
 490:	8082                	ret

0000000000000492 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 492:	1101                	addi	sp,sp,-32
 494:	ec06                	sd	ra,24(sp)
 496:	e822                	sd	s0,16(sp)
 498:	e426                	sd	s1,8(sp)
 49a:	e04a                	sd	s2,0(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	84aa                	mv	s1,a0
 4a0:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4a2:	09800513          	li	a0,152
 4a6:	00000097          	auipc	ra,0x0
 4aa:	6f4080e7          	jalr	1780(ra) # b9a <malloc>

    main_thread->tid = 1;
 4ae:	4785                	li	a5,1
 4b0:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 4b4:	4791                	li	a5,4
 4b6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4b8:	00001797          	auipc	a5,0x1
 4bc:	b4a7bc23          	sd	a0,-1192(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4c0:	00001797          	auipc	a5,0x1
 4c4:	d6078793          	addi	a5,a5,-672 # 1220 <threads>
 4c8:	00001717          	auipc	a4,0x1
 4cc:	dd870713          	addi	a4,a4,-552 # 12a0 <base>
        threads[i] = NULL;
 4d0:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4d4:	07a1                	addi	a5,a5,8
 4d6:	fee79de3          	bne	a5,a4,4d0 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4da:	00001797          	auipc	a5,0x1
 4de:	d4a7b323          	sd	a0,-698(a5) # 1220 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4e2:	85ca                	mv	a1,s2
 4e4:	8526                	mv	a0,s1
 4e6:	00000097          	auipc	ra,0x0
 4ea:	ba4080e7          	jalr	-1116(ra) # 8a <main>
    //tsched();

    exit(res);
 4ee:	00000097          	auipc	ra,0x0
 4f2:	274080e7          	jalr	628(ra) # 762 <exit>

00000000000004f6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4fc:	87aa                	mv	a5,a0
 4fe:	0585                	addi	a1,a1,1
 500:	0785                	addi	a5,a5,1
 502:	fff5c703          	lbu	a4,-1(a1)
 506:	fee78fa3          	sb	a4,-1(a5)
 50a:	fb75                	bnez	a4,4fe <strcpy+0x8>
        ;
    return os;
}
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret

0000000000000512 <strcmp>:

int strcmp(const char *p, const char *q)
{
 512:	1141                	addi	sp,sp,-16
 514:	e422                	sd	s0,8(sp)
 516:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 518:	00054783          	lbu	a5,0(a0)
 51c:	cb91                	beqz	a5,530 <strcmp+0x1e>
 51e:	0005c703          	lbu	a4,0(a1)
 522:	00f71763          	bne	a4,a5,530 <strcmp+0x1e>
        p++, q++;
 526:	0505                	addi	a0,a0,1
 528:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 52a:	00054783          	lbu	a5,0(a0)
 52e:	fbe5                	bnez	a5,51e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 530:	0005c503          	lbu	a0,0(a1)
}
 534:	40a7853b          	subw	a0,a5,a0
 538:	6422                	ld	s0,8(sp)
 53a:	0141                	addi	sp,sp,16
 53c:	8082                	ret

000000000000053e <strlen>:

uint strlen(const char *s)
{
 53e:	1141                	addi	sp,sp,-16
 540:	e422                	sd	s0,8(sp)
 542:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 544:	00054783          	lbu	a5,0(a0)
 548:	cf91                	beqz	a5,564 <strlen+0x26>
 54a:	0505                	addi	a0,a0,1
 54c:	87aa                	mv	a5,a0
 54e:	86be                	mv	a3,a5
 550:	0785                	addi	a5,a5,1
 552:	fff7c703          	lbu	a4,-1(a5)
 556:	ff65                	bnez	a4,54e <strlen+0x10>
 558:	40a6853b          	subw	a0,a3,a0
 55c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 55e:	6422                	ld	s0,8(sp)
 560:	0141                	addi	sp,sp,16
 562:	8082                	ret
    for (n = 0; s[n]; n++)
 564:	4501                	li	a0,0
 566:	bfe5                	j	55e <strlen+0x20>

0000000000000568 <memset>:

void *
memset(void *dst, int c, uint n)
{
 568:	1141                	addi	sp,sp,-16
 56a:	e422                	sd	s0,8(sp)
 56c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 56e:	ca19                	beqz	a2,584 <memset+0x1c>
 570:	87aa                	mv	a5,a0
 572:	1602                	slli	a2,a2,0x20
 574:	9201                	srli	a2,a2,0x20
 576:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 57a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 57e:	0785                	addi	a5,a5,1
 580:	fee79de3          	bne	a5,a4,57a <memset+0x12>
    }
    return dst;
}
 584:	6422                	ld	s0,8(sp)
 586:	0141                	addi	sp,sp,16
 588:	8082                	ret

000000000000058a <strchr>:

char *
strchr(const char *s, char c)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e422                	sd	s0,8(sp)
 58e:	0800                	addi	s0,sp,16
    for (; *s; s++)
 590:	00054783          	lbu	a5,0(a0)
 594:	cb99                	beqz	a5,5aa <strchr+0x20>
        if (*s == c)
 596:	00f58763          	beq	a1,a5,5a4 <strchr+0x1a>
    for (; *s; s++)
 59a:	0505                	addi	a0,a0,1
 59c:	00054783          	lbu	a5,0(a0)
 5a0:	fbfd                	bnez	a5,596 <strchr+0xc>
            return (char *)s;
    return 0;
 5a2:	4501                	li	a0,0
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
    return 0;
 5aa:	4501                	li	a0,0
 5ac:	bfe5                	j	5a4 <strchr+0x1a>

00000000000005ae <gets>:

char *
gets(char *buf, int max)
{
 5ae:	711d                	addi	sp,sp,-96
 5b0:	ec86                	sd	ra,88(sp)
 5b2:	e8a2                	sd	s0,80(sp)
 5b4:	e4a6                	sd	s1,72(sp)
 5b6:	e0ca                	sd	s2,64(sp)
 5b8:	fc4e                	sd	s3,56(sp)
 5ba:	f852                	sd	s4,48(sp)
 5bc:	f456                	sd	s5,40(sp)
 5be:	f05a                	sd	s6,32(sp)
 5c0:	ec5e                	sd	s7,24(sp)
 5c2:	1080                	addi	s0,sp,96
 5c4:	8baa                	mv	s7,a0
 5c6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5c8:	892a                	mv	s2,a0
 5ca:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5cc:	4aa9                	li	s5,10
 5ce:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5d0:	89a6                	mv	s3,s1
 5d2:	2485                	addiw	s1,s1,1
 5d4:	0344d863          	bge	s1,s4,604 <gets+0x56>
        cc = read(0, &c, 1);
 5d8:	4605                	li	a2,1
 5da:	faf40593          	addi	a1,s0,-81
 5de:	4501                	li	a0,0
 5e0:	00000097          	auipc	ra,0x0
 5e4:	19a080e7          	jalr	410(ra) # 77a <read>
        if (cc < 1)
 5e8:	00a05e63          	blez	a0,604 <gets+0x56>
        buf[i++] = c;
 5ec:	faf44783          	lbu	a5,-81(s0)
 5f0:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5f4:	01578763          	beq	a5,s5,602 <gets+0x54>
 5f8:	0905                	addi	s2,s2,1
 5fa:	fd679be3          	bne	a5,s6,5d0 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5fe:	89a6                	mv	s3,s1
 600:	a011                	j	604 <gets+0x56>
 602:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 604:	99de                	add	s3,s3,s7
 606:	00098023          	sb	zero,0(s3)
    return buf;
}
 60a:	855e                	mv	a0,s7
 60c:	60e6                	ld	ra,88(sp)
 60e:	6446                	ld	s0,80(sp)
 610:	64a6                	ld	s1,72(sp)
 612:	6906                	ld	s2,64(sp)
 614:	79e2                	ld	s3,56(sp)
 616:	7a42                	ld	s4,48(sp)
 618:	7aa2                	ld	s5,40(sp)
 61a:	7b02                	ld	s6,32(sp)
 61c:	6be2                	ld	s7,24(sp)
 61e:	6125                	addi	sp,sp,96
 620:	8082                	ret

0000000000000622 <stat>:

int stat(const char *n, struct stat *st)
{
 622:	1101                	addi	sp,sp,-32
 624:	ec06                	sd	ra,24(sp)
 626:	e822                	sd	s0,16(sp)
 628:	e426                	sd	s1,8(sp)
 62a:	e04a                	sd	s2,0(sp)
 62c:	1000                	addi	s0,sp,32
 62e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 630:	4581                	li	a1,0
 632:	00000097          	auipc	ra,0x0
 636:	170080e7          	jalr	368(ra) # 7a2 <open>
    if (fd < 0)
 63a:	02054563          	bltz	a0,664 <stat+0x42>
 63e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 640:	85ca                	mv	a1,s2
 642:	00000097          	auipc	ra,0x0
 646:	178080e7          	jalr	376(ra) # 7ba <fstat>
 64a:	892a                	mv	s2,a0
    close(fd);
 64c:	8526                	mv	a0,s1
 64e:	00000097          	auipc	ra,0x0
 652:	13c080e7          	jalr	316(ra) # 78a <close>
    return r;
}
 656:	854a                	mv	a0,s2
 658:	60e2                	ld	ra,24(sp)
 65a:	6442                	ld	s0,16(sp)
 65c:	64a2                	ld	s1,8(sp)
 65e:	6902                	ld	s2,0(sp)
 660:	6105                	addi	sp,sp,32
 662:	8082                	ret
        return -1;
 664:	597d                	li	s2,-1
 666:	bfc5                	j	656 <stat+0x34>

0000000000000668 <atoi>:

int atoi(const char *s)
{
 668:	1141                	addi	sp,sp,-16
 66a:	e422                	sd	s0,8(sp)
 66c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 66e:	00054683          	lbu	a3,0(a0)
 672:	fd06879b          	addiw	a5,a3,-48
 676:	0ff7f793          	zext.b	a5,a5
 67a:	4625                	li	a2,9
 67c:	02f66863          	bltu	a2,a5,6ac <atoi+0x44>
 680:	872a                	mv	a4,a0
    n = 0;
 682:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 684:	0705                	addi	a4,a4,1
 686:	0025179b          	slliw	a5,a0,0x2
 68a:	9fa9                	addw	a5,a5,a0
 68c:	0017979b          	slliw	a5,a5,0x1
 690:	9fb5                	addw	a5,a5,a3
 692:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 696:	00074683          	lbu	a3,0(a4)
 69a:	fd06879b          	addiw	a5,a3,-48
 69e:	0ff7f793          	zext.b	a5,a5
 6a2:	fef671e3          	bgeu	a2,a5,684 <atoi+0x1c>
    return n;
}
 6a6:	6422                	ld	s0,8(sp)
 6a8:	0141                	addi	sp,sp,16
 6aa:	8082                	ret
    n = 0;
 6ac:	4501                	li	a0,0
 6ae:	bfe5                	j	6a6 <atoi+0x3e>

00000000000006b0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6b0:	1141                	addi	sp,sp,-16
 6b2:	e422                	sd	s0,8(sp)
 6b4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6b6:	02b57463          	bgeu	a0,a1,6de <memmove+0x2e>
    {
        while (n-- > 0)
 6ba:	00c05f63          	blez	a2,6d8 <memmove+0x28>
 6be:	1602                	slli	a2,a2,0x20
 6c0:	9201                	srli	a2,a2,0x20
 6c2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6c6:	872a                	mv	a4,a0
            *dst++ = *src++;
 6c8:	0585                	addi	a1,a1,1
 6ca:	0705                	addi	a4,a4,1
 6cc:	fff5c683          	lbu	a3,-1(a1)
 6d0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6d4:	fee79ae3          	bne	a5,a4,6c8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6d8:	6422                	ld	s0,8(sp)
 6da:	0141                	addi	sp,sp,16
 6dc:	8082                	ret
        dst += n;
 6de:	00c50733          	add	a4,a0,a2
        src += n;
 6e2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6e4:	fec05ae3          	blez	a2,6d8 <memmove+0x28>
 6e8:	fff6079b          	addiw	a5,a2,-1
 6ec:	1782                	slli	a5,a5,0x20
 6ee:	9381                	srli	a5,a5,0x20
 6f0:	fff7c793          	not	a5,a5
 6f4:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6f6:	15fd                	addi	a1,a1,-1
 6f8:	177d                	addi	a4,a4,-1
 6fa:	0005c683          	lbu	a3,0(a1)
 6fe:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 702:	fee79ae3          	bne	a5,a4,6f6 <memmove+0x46>
 706:	bfc9                	j	6d8 <memmove+0x28>

0000000000000708 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 708:	1141                	addi	sp,sp,-16
 70a:	e422                	sd	s0,8(sp)
 70c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 70e:	ca05                	beqz	a2,73e <memcmp+0x36>
 710:	fff6069b          	addiw	a3,a2,-1
 714:	1682                	slli	a3,a3,0x20
 716:	9281                	srli	a3,a3,0x20
 718:	0685                	addi	a3,a3,1
 71a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 71c:	00054783          	lbu	a5,0(a0)
 720:	0005c703          	lbu	a4,0(a1)
 724:	00e79863          	bne	a5,a4,734 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 728:	0505                	addi	a0,a0,1
        p2++;
 72a:	0585                	addi	a1,a1,1
    while (n-- > 0)
 72c:	fed518e3          	bne	a0,a3,71c <memcmp+0x14>
    }
    return 0;
 730:	4501                	li	a0,0
 732:	a019                	j	738 <memcmp+0x30>
            return *p1 - *p2;
 734:	40e7853b          	subw	a0,a5,a4
}
 738:	6422                	ld	s0,8(sp)
 73a:	0141                	addi	sp,sp,16
 73c:	8082                	ret
    return 0;
 73e:	4501                	li	a0,0
 740:	bfe5                	j	738 <memcmp+0x30>

0000000000000742 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 742:	1141                	addi	sp,sp,-16
 744:	e406                	sd	ra,8(sp)
 746:	e022                	sd	s0,0(sp)
 748:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 74a:	00000097          	auipc	ra,0x0
 74e:	f66080e7          	jalr	-154(ra) # 6b0 <memmove>
}
 752:	60a2                	ld	ra,8(sp)
 754:	6402                	ld	s0,0(sp)
 756:	0141                	addi	sp,sp,16
 758:	8082                	ret

000000000000075a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 75a:	4885                	li	a7,1
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <exit>:
.global exit
exit:
 li a7, SYS_exit
 762:	4889                	li	a7,2
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <wait>:
.global wait
wait:
 li a7, SYS_wait
 76a:	488d                	li	a7,3
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 772:	4891                	li	a7,4
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <read>:
.global read
read:
 li a7, SYS_read
 77a:	4895                	li	a7,5
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <write>:
.global write
write:
 li a7, SYS_write
 782:	48c1                	li	a7,16
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <close>:
.global close
close:
 li a7, SYS_close
 78a:	48d5                	li	a7,21
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <kill>:
.global kill
kill:
 li a7, SYS_kill
 792:	4899                	li	a7,6
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <exec>:
.global exec
exec:
 li a7, SYS_exec
 79a:	489d                	li	a7,7
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <open>:
.global open
open:
 li a7, SYS_open
 7a2:	48bd                	li	a7,15
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7aa:	48c5                	li	a7,17
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7b2:	48c9                	li	a7,18
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7ba:	48a1                	li	a7,8
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <link>:
.global link
link:
 li a7, SYS_link
 7c2:	48cd                	li	a7,19
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7ca:	48d1                	li	a7,20
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7d2:	48a5                	li	a7,9
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <dup>:
.global dup
dup:
 li a7, SYS_dup
 7da:	48a9                	li	a7,10
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7e2:	48ad                	li	a7,11
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7ea:	48b1                	li	a7,12
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7f2:	48b5                	li	a7,13
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7fa:	48b9                	li	a7,14
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <ps>:
.global ps
ps:
 li a7, SYS_ps
 802:	48d9                	li	a7,22
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 80a:	48dd                	li	a7,23
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 812:	48e1                	li	a7,24
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 81a:	1101                	addi	sp,sp,-32
 81c:	ec06                	sd	ra,24(sp)
 81e:	e822                	sd	s0,16(sp)
 820:	1000                	addi	s0,sp,32
 822:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 826:	4605                	li	a2,1
 828:	fef40593          	addi	a1,s0,-17
 82c:	00000097          	auipc	ra,0x0
 830:	f56080e7          	jalr	-170(ra) # 782 <write>
}
 834:	60e2                	ld	ra,24(sp)
 836:	6442                	ld	s0,16(sp)
 838:	6105                	addi	sp,sp,32
 83a:	8082                	ret

000000000000083c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 83c:	7139                	addi	sp,sp,-64
 83e:	fc06                	sd	ra,56(sp)
 840:	f822                	sd	s0,48(sp)
 842:	f426                	sd	s1,40(sp)
 844:	f04a                	sd	s2,32(sp)
 846:	ec4e                	sd	s3,24(sp)
 848:	0080                	addi	s0,sp,64
 84a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 84c:	c299                	beqz	a3,852 <printint+0x16>
 84e:	0805c963          	bltz	a1,8e0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 852:	2581                	sext.w	a1,a1
  neg = 0;
 854:	4881                	li	a7,0
 856:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 85a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 85c:	2601                	sext.w	a2,a2
 85e:	00000517          	auipc	a0,0x0
 862:	51a50513          	addi	a0,a0,1306 # d78 <digits>
 866:	883a                	mv	a6,a4
 868:	2705                	addiw	a4,a4,1
 86a:	02c5f7bb          	remuw	a5,a1,a2
 86e:	1782                	slli	a5,a5,0x20
 870:	9381                	srli	a5,a5,0x20
 872:	97aa                	add	a5,a5,a0
 874:	0007c783          	lbu	a5,0(a5)
 878:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 87c:	0005879b          	sext.w	a5,a1
 880:	02c5d5bb          	divuw	a1,a1,a2
 884:	0685                	addi	a3,a3,1
 886:	fec7f0e3          	bgeu	a5,a2,866 <printint+0x2a>
  if(neg)
 88a:	00088c63          	beqz	a7,8a2 <printint+0x66>
    buf[i++] = '-';
 88e:	fd070793          	addi	a5,a4,-48
 892:	00878733          	add	a4,a5,s0
 896:	02d00793          	li	a5,45
 89a:	fef70823          	sb	a5,-16(a4)
 89e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8a2:	02e05863          	blez	a4,8d2 <printint+0x96>
 8a6:	fc040793          	addi	a5,s0,-64
 8aa:	00e78933          	add	s2,a5,a4
 8ae:	fff78993          	addi	s3,a5,-1
 8b2:	99ba                	add	s3,s3,a4
 8b4:	377d                	addiw	a4,a4,-1
 8b6:	1702                	slli	a4,a4,0x20
 8b8:	9301                	srli	a4,a4,0x20
 8ba:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8be:	fff94583          	lbu	a1,-1(s2)
 8c2:	8526                	mv	a0,s1
 8c4:	00000097          	auipc	ra,0x0
 8c8:	f56080e7          	jalr	-170(ra) # 81a <putc>
  while(--i >= 0)
 8cc:	197d                	addi	s2,s2,-1
 8ce:	ff3918e3          	bne	s2,s3,8be <printint+0x82>
}
 8d2:	70e2                	ld	ra,56(sp)
 8d4:	7442                	ld	s0,48(sp)
 8d6:	74a2                	ld	s1,40(sp)
 8d8:	7902                	ld	s2,32(sp)
 8da:	69e2                	ld	s3,24(sp)
 8dc:	6121                	addi	sp,sp,64
 8de:	8082                	ret
    x = -xx;
 8e0:	40b005bb          	negw	a1,a1
    neg = 1;
 8e4:	4885                	li	a7,1
    x = -xx;
 8e6:	bf85                	j	856 <printint+0x1a>

00000000000008e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8e8:	715d                	addi	sp,sp,-80
 8ea:	e486                	sd	ra,72(sp)
 8ec:	e0a2                	sd	s0,64(sp)
 8ee:	fc26                	sd	s1,56(sp)
 8f0:	f84a                	sd	s2,48(sp)
 8f2:	f44e                	sd	s3,40(sp)
 8f4:	f052                	sd	s4,32(sp)
 8f6:	ec56                	sd	s5,24(sp)
 8f8:	e85a                	sd	s6,16(sp)
 8fa:	e45e                	sd	s7,8(sp)
 8fc:	e062                	sd	s8,0(sp)
 8fe:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 900:	0005c903          	lbu	s2,0(a1)
 904:	18090c63          	beqz	s2,a9c <vprintf+0x1b4>
 908:	8aaa                	mv	s5,a0
 90a:	8bb2                	mv	s7,a2
 90c:	00158493          	addi	s1,a1,1
  state = 0;
 910:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 912:	02500a13          	li	s4,37
 916:	4b55                	li	s6,21
 918:	a839                	j	936 <vprintf+0x4e>
        putc(fd, c);
 91a:	85ca                	mv	a1,s2
 91c:	8556                	mv	a0,s5
 91e:	00000097          	auipc	ra,0x0
 922:	efc080e7          	jalr	-260(ra) # 81a <putc>
 926:	a019                	j	92c <vprintf+0x44>
    } else if(state == '%'){
 928:	01498d63          	beq	s3,s4,942 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 92c:	0485                	addi	s1,s1,1
 92e:	fff4c903          	lbu	s2,-1(s1)
 932:	16090563          	beqz	s2,a9c <vprintf+0x1b4>
    if(state == 0){
 936:	fe0999e3          	bnez	s3,928 <vprintf+0x40>
      if(c == '%'){
 93a:	ff4910e3          	bne	s2,s4,91a <vprintf+0x32>
        state = '%';
 93e:	89d2                	mv	s3,s4
 940:	b7f5                	j	92c <vprintf+0x44>
      if(c == 'd'){
 942:	13490263          	beq	s2,s4,a66 <vprintf+0x17e>
 946:	f9d9079b          	addiw	a5,s2,-99
 94a:	0ff7f793          	zext.b	a5,a5
 94e:	12fb6563          	bltu	s6,a5,a78 <vprintf+0x190>
 952:	f9d9079b          	addiw	a5,s2,-99
 956:	0ff7f713          	zext.b	a4,a5
 95a:	10eb6f63          	bltu	s6,a4,a78 <vprintf+0x190>
 95e:	00271793          	slli	a5,a4,0x2
 962:	00000717          	auipc	a4,0x0
 966:	3be70713          	addi	a4,a4,958 # d20 <malloc+0x186>
 96a:	97ba                	add	a5,a5,a4
 96c:	439c                	lw	a5,0(a5)
 96e:	97ba                	add	a5,a5,a4
 970:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 972:	008b8913          	addi	s2,s7,8
 976:	4685                	li	a3,1
 978:	4629                	li	a2,10
 97a:	000ba583          	lw	a1,0(s7)
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	ebc080e7          	jalr	-324(ra) # 83c <printint>
 988:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 98a:	4981                	li	s3,0
 98c:	b745                	j	92c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 98e:	008b8913          	addi	s2,s7,8
 992:	4681                	li	a3,0
 994:	4629                	li	a2,10
 996:	000ba583          	lw	a1,0(s7)
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	ea0080e7          	jalr	-352(ra) # 83c <printint>
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	b751                	j	92c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9aa:	008b8913          	addi	s2,s7,8
 9ae:	4681                	li	a3,0
 9b0:	4641                	li	a2,16
 9b2:	000ba583          	lw	a1,0(s7)
 9b6:	8556                	mv	a0,s5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	e84080e7          	jalr	-380(ra) # 83c <printint>
 9c0:	8bca                	mv	s7,s2
      state = 0;
 9c2:	4981                	li	s3,0
 9c4:	b7a5                	j	92c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9c6:	008b8c13          	addi	s8,s7,8
 9ca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9ce:	03000593          	li	a1,48
 9d2:	8556                	mv	a0,s5
 9d4:	00000097          	auipc	ra,0x0
 9d8:	e46080e7          	jalr	-442(ra) # 81a <putc>
  putc(fd, 'x');
 9dc:	07800593          	li	a1,120
 9e0:	8556                	mv	a0,s5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e38080e7          	jalr	-456(ra) # 81a <putc>
 9ea:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9ec:	00000b97          	auipc	s7,0x0
 9f0:	38cb8b93          	addi	s7,s7,908 # d78 <digits>
 9f4:	03c9d793          	srli	a5,s3,0x3c
 9f8:	97de                	add	a5,a5,s7
 9fa:	0007c583          	lbu	a1,0(a5)
 9fe:	8556                	mv	a0,s5
 a00:	00000097          	auipc	ra,0x0
 a04:	e1a080e7          	jalr	-486(ra) # 81a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a08:	0992                	slli	s3,s3,0x4
 a0a:	397d                	addiw	s2,s2,-1
 a0c:	fe0914e3          	bnez	s2,9f4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a10:	8be2                	mv	s7,s8
      state = 0;
 a12:	4981                	li	s3,0
 a14:	bf21                	j	92c <vprintf+0x44>
        s = va_arg(ap, char*);
 a16:	008b8993          	addi	s3,s7,8
 a1a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a1e:	02090163          	beqz	s2,a40 <vprintf+0x158>
        while(*s != 0){
 a22:	00094583          	lbu	a1,0(s2)
 a26:	c9a5                	beqz	a1,a96 <vprintf+0x1ae>
          putc(fd, *s);
 a28:	8556                	mv	a0,s5
 a2a:	00000097          	auipc	ra,0x0
 a2e:	df0080e7          	jalr	-528(ra) # 81a <putc>
          s++;
 a32:	0905                	addi	s2,s2,1
        while(*s != 0){
 a34:	00094583          	lbu	a1,0(s2)
 a38:	f9e5                	bnez	a1,a28 <vprintf+0x140>
        s = va_arg(ap, char*);
 a3a:	8bce                	mv	s7,s3
      state = 0;
 a3c:	4981                	li	s3,0
 a3e:	b5fd                	j	92c <vprintf+0x44>
          s = "(null)";
 a40:	00000917          	auipc	s2,0x0
 a44:	2d890913          	addi	s2,s2,728 # d18 <malloc+0x17e>
        while(*s != 0){
 a48:	02800593          	li	a1,40
 a4c:	bff1                	j	a28 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a4e:	008b8913          	addi	s2,s7,8
 a52:	000bc583          	lbu	a1,0(s7)
 a56:	8556                	mv	a0,s5
 a58:	00000097          	auipc	ra,0x0
 a5c:	dc2080e7          	jalr	-574(ra) # 81a <putc>
 a60:	8bca                	mv	s7,s2
      state = 0;
 a62:	4981                	li	s3,0
 a64:	b5e1                	j	92c <vprintf+0x44>
        putc(fd, c);
 a66:	02500593          	li	a1,37
 a6a:	8556                	mv	a0,s5
 a6c:	00000097          	auipc	ra,0x0
 a70:	dae080e7          	jalr	-594(ra) # 81a <putc>
      state = 0;
 a74:	4981                	li	s3,0
 a76:	bd5d                	j	92c <vprintf+0x44>
        putc(fd, '%');
 a78:	02500593          	li	a1,37
 a7c:	8556                	mv	a0,s5
 a7e:	00000097          	auipc	ra,0x0
 a82:	d9c080e7          	jalr	-612(ra) # 81a <putc>
        putc(fd, c);
 a86:	85ca                	mv	a1,s2
 a88:	8556                	mv	a0,s5
 a8a:	00000097          	auipc	ra,0x0
 a8e:	d90080e7          	jalr	-624(ra) # 81a <putc>
      state = 0;
 a92:	4981                	li	s3,0
 a94:	bd61                	j	92c <vprintf+0x44>
        s = va_arg(ap, char*);
 a96:	8bce                	mv	s7,s3
      state = 0;
 a98:	4981                	li	s3,0
 a9a:	bd49                	j	92c <vprintf+0x44>
    }
  }
}
 a9c:	60a6                	ld	ra,72(sp)
 a9e:	6406                	ld	s0,64(sp)
 aa0:	74e2                	ld	s1,56(sp)
 aa2:	7942                	ld	s2,48(sp)
 aa4:	79a2                	ld	s3,40(sp)
 aa6:	7a02                	ld	s4,32(sp)
 aa8:	6ae2                	ld	s5,24(sp)
 aaa:	6b42                	ld	s6,16(sp)
 aac:	6ba2                	ld	s7,8(sp)
 aae:	6c02                	ld	s8,0(sp)
 ab0:	6161                	addi	sp,sp,80
 ab2:	8082                	ret

0000000000000ab4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ab4:	715d                	addi	sp,sp,-80
 ab6:	ec06                	sd	ra,24(sp)
 ab8:	e822                	sd	s0,16(sp)
 aba:	1000                	addi	s0,sp,32
 abc:	e010                	sd	a2,0(s0)
 abe:	e414                	sd	a3,8(s0)
 ac0:	e818                	sd	a4,16(s0)
 ac2:	ec1c                	sd	a5,24(s0)
 ac4:	03043023          	sd	a6,32(s0)
 ac8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 acc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ad0:	8622                	mv	a2,s0
 ad2:	00000097          	auipc	ra,0x0
 ad6:	e16080e7          	jalr	-490(ra) # 8e8 <vprintf>
}
 ada:	60e2                	ld	ra,24(sp)
 adc:	6442                	ld	s0,16(sp)
 ade:	6161                	addi	sp,sp,80
 ae0:	8082                	ret

0000000000000ae2 <printf>:

void
printf(const char *fmt, ...)
{
 ae2:	711d                	addi	sp,sp,-96
 ae4:	ec06                	sd	ra,24(sp)
 ae6:	e822                	sd	s0,16(sp)
 ae8:	1000                	addi	s0,sp,32
 aea:	e40c                	sd	a1,8(s0)
 aec:	e810                	sd	a2,16(s0)
 aee:	ec14                	sd	a3,24(s0)
 af0:	f018                	sd	a4,32(s0)
 af2:	f41c                	sd	a5,40(s0)
 af4:	03043823          	sd	a6,48(s0)
 af8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 afc:	00840613          	addi	a2,s0,8
 b00:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b04:	85aa                	mv	a1,a0
 b06:	4505                	li	a0,1
 b08:	00000097          	auipc	ra,0x0
 b0c:	de0080e7          	jalr	-544(ra) # 8e8 <vprintf>
}
 b10:	60e2                	ld	ra,24(sp)
 b12:	6442                	ld	s0,16(sp)
 b14:	6125                	addi	sp,sp,96
 b16:	8082                	ret

0000000000000b18 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b18:	1141                	addi	sp,sp,-16
 b1a:	e422                	sd	s0,8(sp)
 b1c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b1e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b22:	00000797          	auipc	a5,0x0
 b26:	4f67b783          	ld	a5,1270(a5) # 1018 <freep>
 b2a:	a02d                	j	b54 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b2c:	4618                	lw	a4,8(a2)
 b2e:	9f2d                	addw	a4,a4,a1
 b30:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b34:	6398                	ld	a4,0(a5)
 b36:	6310                	ld	a2,0(a4)
 b38:	a83d                	j	b76 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b3a:	ff852703          	lw	a4,-8(a0)
 b3e:	9f31                	addw	a4,a4,a2
 b40:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b42:	ff053683          	ld	a3,-16(a0)
 b46:	a091                	j	b8a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b48:	6398                	ld	a4,0(a5)
 b4a:	00e7e463          	bltu	a5,a4,b52 <free+0x3a>
 b4e:	00e6ea63          	bltu	a3,a4,b62 <free+0x4a>
{
 b52:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b54:	fed7fae3          	bgeu	a5,a3,b48 <free+0x30>
 b58:	6398                	ld	a4,0(a5)
 b5a:	00e6e463          	bltu	a3,a4,b62 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5e:	fee7eae3          	bltu	a5,a4,b52 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b62:	ff852583          	lw	a1,-8(a0)
 b66:	6390                	ld	a2,0(a5)
 b68:	02059813          	slli	a6,a1,0x20
 b6c:	01c85713          	srli	a4,a6,0x1c
 b70:	9736                	add	a4,a4,a3
 b72:	fae60de3          	beq	a2,a4,b2c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b76:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b7a:	4790                	lw	a2,8(a5)
 b7c:	02061593          	slli	a1,a2,0x20
 b80:	01c5d713          	srli	a4,a1,0x1c
 b84:	973e                	add	a4,a4,a5
 b86:	fae68ae3          	beq	a3,a4,b3a <free+0x22>
        p->s.ptr = bp->s.ptr;
 b8a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b8c:	00000717          	auipc	a4,0x0
 b90:	48f73623          	sd	a5,1164(a4) # 1018 <freep>
}
 b94:	6422                	ld	s0,8(sp)
 b96:	0141                	addi	sp,sp,16
 b98:	8082                	ret

0000000000000b9a <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b9a:	7139                	addi	sp,sp,-64
 b9c:	fc06                	sd	ra,56(sp)
 b9e:	f822                	sd	s0,48(sp)
 ba0:	f426                	sd	s1,40(sp)
 ba2:	f04a                	sd	s2,32(sp)
 ba4:	ec4e                	sd	s3,24(sp)
 ba6:	e852                	sd	s4,16(sp)
 ba8:	e456                	sd	s5,8(sp)
 baa:	e05a                	sd	s6,0(sp)
 bac:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bae:	02051493          	slli	s1,a0,0x20
 bb2:	9081                	srli	s1,s1,0x20
 bb4:	04bd                	addi	s1,s1,15
 bb6:	8091                	srli	s1,s1,0x4
 bb8:	0014899b          	addiw	s3,s1,1
 bbc:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bbe:	00000517          	auipc	a0,0x0
 bc2:	45a53503          	ld	a0,1114(a0) # 1018 <freep>
 bc6:	c515                	beqz	a0,bf2 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bc8:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bca:	4798                	lw	a4,8(a5)
 bcc:	02977f63          	bgeu	a4,s1,c0a <malloc+0x70>
    if (nu < 4096)
 bd0:	8a4e                	mv	s4,s3
 bd2:	0009871b          	sext.w	a4,s3
 bd6:	6685                	lui	a3,0x1
 bd8:	00d77363          	bgeu	a4,a3,bde <malloc+0x44>
 bdc:	6a05                	lui	s4,0x1
 bde:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 be2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 be6:	00000917          	auipc	s2,0x0
 bea:	43290913          	addi	s2,s2,1074 # 1018 <freep>
    if (p == (char *)-1)
 bee:	5afd                	li	s5,-1
 bf0:	a895                	j	c64 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bf2:	00000797          	auipc	a5,0x0
 bf6:	6ae78793          	addi	a5,a5,1710 # 12a0 <base>
 bfa:	00000717          	auipc	a4,0x0
 bfe:	40f73f23          	sd	a5,1054(a4) # 1018 <freep>
 c02:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c04:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c08:	b7e1                	j	bd0 <malloc+0x36>
            if (p->s.size == nunits)
 c0a:	02e48c63          	beq	s1,a4,c42 <malloc+0xa8>
                p->s.size -= nunits;
 c0e:	4137073b          	subw	a4,a4,s3
 c12:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c14:	02071693          	slli	a3,a4,0x20
 c18:	01c6d713          	srli	a4,a3,0x1c
 c1c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c1e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c22:	00000717          	auipc	a4,0x0
 c26:	3ea73b23          	sd	a0,1014(a4) # 1018 <freep>
            return (void *)(p + 1);
 c2a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c2e:	70e2                	ld	ra,56(sp)
 c30:	7442                	ld	s0,48(sp)
 c32:	74a2                	ld	s1,40(sp)
 c34:	7902                	ld	s2,32(sp)
 c36:	69e2                	ld	s3,24(sp)
 c38:	6a42                	ld	s4,16(sp)
 c3a:	6aa2                	ld	s5,8(sp)
 c3c:	6b02                	ld	s6,0(sp)
 c3e:	6121                	addi	sp,sp,64
 c40:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c42:	6398                	ld	a4,0(a5)
 c44:	e118                	sd	a4,0(a0)
 c46:	bff1                	j	c22 <malloc+0x88>
    hp->s.size = nu;
 c48:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c4c:	0541                	addi	a0,a0,16
 c4e:	00000097          	auipc	ra,0x0
 c52:	eca080e7          	jalr	-310(ra) # b18 <free>
    return freep;
 c56:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c5a:	d971                	beqz	a0,c2e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c5c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c5e:	4798                	lw	a4,8(a5)
 c60:	fa9775e3          	bgeu	a4,s1,c0a <malloc+0x70>
        if (p == freep)
 c64:	00093703          	ld	a4,0(s2)
 c68:	853e                	mv	a0,a5
 c6a:	fef719e3          	bne	a4,a5,c5c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c6e:	8552                	mv	a0,s4
 c70:	00000097          	auipc	ra,0x0
 c74:	b7a080e7          	jalr	-1158(ra) # 7ea <sbrk>
    if (p == (char *)-1)
 c78:	fd5518e3          	bne	a0,s5,c48 <malloc+0xae>
                return 0;
 c7c:	4501                	li	a0,0
 c7e:	bf45                	j	c2e <malloc+0x94>
