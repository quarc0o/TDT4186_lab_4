
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
  24:	7d0080e7          	jalr	2000(ra) # 7f0 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    {
        if (write(1, buf, n) != n)
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	7c4080e7          	jalr	1988(ra) # 7f8 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
        {
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	cc058593          	addi	a1,a1,-832 # d00 <malloc+0xf0>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	ae0080e7          	jalr	-1312(ra) # b2a <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	784080e7          	jalr	1924(ra) # 7d8 <exit>
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
  72:	caa58593          	addi	a1,a1,-854 # d18 <malloc+0x108>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	ab2080e7          	jalr	-1358(ra) # b2a <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	756080e7          	jalr	1878(ra) # 7d8 <exit>

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
  bc:	760080e7          	jalr	1888(ra) # 818 <open>
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
  d4:	730080e7          	jalr	1840(ra) # 800 <close>
    for (i = 1; i < argc; i++)
  d8:	0921                	addi	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
    }
    exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	6f8080e7          	jalr	1784(ra) # 7d8 <exit>
        cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
        exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	6e4080e7          	jalr	1764(ra) # 7d8 <exit>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	00093603          	ld	a2,0(s2)
 100:	00001597          	auipc	a1,0x1
 104:	c3058593          	addi	a1,a1,-976 # d30 <malloc+0x120>
 108:	4509                	li	a0,2
 10a:	00001097          	auipc	ra,0x1
 10e:	a20080e7          	jalr	-1504(ra) # b2a <fprintf>
            exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	6c4080e7          	jalr	1732(ra) # 7d8 <exit>

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
 150:	2dc080e7          	jalr	732(ra) # 428 <twhoami>
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
 19c:	bb050513          	addi	a0,a0,-1104 # d48 <malloc+0x138>
 1a0:	00001097          	auipc	ra,0x1
 1a4:	9b8080e7          	jalr	-1608(ra) # b58 <printf>
        exit(-1);
 1a8:	557d                	li	a0,-1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	62e080e7          	jalr	1582(ra) # 7d8 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b2:	00000097          	auipc	ra,0x0
 1b6:	252080e7          	jalr	594(ra) # 404 <tyield>
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
 1d0:	25c080e7          	jalr	604(ra) # 428 <twhoami>
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
 214:	1f4080e7          	jalr	500(ra) # 404 <tyield>
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
        printf("releasing lock we are not holding");
 222:	00001517          	auipc	a0,0x1
 226:	b4e50513          	addi	a0,a0,-1202 # d70 <malloc+0x160>
 22a:	00001097          	auipc	ra,0x1
 22e:	92e080e7          	jalr	-1746(ra) # b58 <printf>
        exit(-1);
 232:	557d                	li	a0,-1
 234:	00000097          	auipc	ra,0x0
 238:	5a4080e7          	jalr	1444(ra) # 7d8 <exit>

000000000000023c <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 23c:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 23e:	00001617          	auipc	a2,0x1
 242:	fe260613          	addi	a2,a2,-30 # 1220 <threads>
 246:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 248:	45c1                	li	a1,16
 24a:	a021                	j	252 <tsched+0x16>
 24c:	2685                	addiw	a3,a3,1
 24e:	08b68c63          	beq	a3,a1,2e6 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 252:	41f6d71b          	sraiw	a4,a3,0x1f
 256:	01c7571b          	srliw	a4,a4,0x1c
 25a:	00d707bb          	addw	a5,a4,a3
 25e:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 260:	9f99                	subw	a5,a5,a4
 262:	078e                	slli	a5,a5,0x3
 264:	97b2                	add	a5,a5,a2
 266:	639c                	ld	a5,0(a5)
 268:	d3f5                	beqz	a5,24c <tsched+0x10>
 26a:	5fb8                	lw	a4,120(a5)
 26c:	fea710e3          	bne	a4,a0,24c <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 270:	00001717          	auipc	a4,0x1
 274:	fb073703          	ld	a4,-80(a4) # 1220 <threads>
 278:	5f30                	lw	a2,120(a4)
 27a:	468d                	li	a3,3
 27c:	06d60363          	beq	a2,a3,2e2 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 280:	c3a5                	beqz	a5,2e0 <tsched+0xa4>
{
 282:	1101                	addi	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 28e:	00001497          	auipc	s1,0x1
 292:	d8248493          	addi	s1,s1,-638 # 1010 <current_thread>
 296:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 29a:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 29c:	0007c603          	lbu	a2,0(a5)
 2a0:	00094583          	lbu	a1,0(s2)
 2a4:	00001517          	auipc	a0,0x1
 2a8:	af450513          	addi	a0,a0,-1292 # d98 <malloc+0x188>
 2ac:	00001097          	auipc	ra,0x1
 2b0:	8ac080e7          	jalr	-1876(ra) # b58 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2b4:	608c                	ld	a1,0(s1)
 2b6:	05a1                	addi	a1,a1,8
 2b8:	00890513          	addi	a0,s2,8
 2bc:	00000097          	auipc	ra,0x0
 2c0:	184080e7          	jalr	388(ra) # 440 <tswtch>
        printf("Thread switch complete\n");
 2c4:	00001517          	auipc	a0,0x1
 2c8:	afc50513          	addi	a0,a0,-1284 # dc0 <malloc+0x1b0>
 2cc:	00001097          	auipc	ra,0x1
 2d0:	88c080e7          	jalr	-1908(ra) # b58 <printf>
    }
}
 2d4:	60e2                	ld	ra,24(sp)
 2d6:	6442                	ld	s0,16(sp)
 2d8:	64a2                	ld	s1,8(sp)
 2da:	6902                	ld	s2,0(sp)
 2dc:	6105                	addi	sp,sp,32
 2de:	8082                	ret
 2e0:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 2e2:	87ba                	mv	a5,a4
 2e4:	bf79                	j	282 <tsched+0x46>
 2e6:	00001797          	auipc	a5,0x1
 2ea:	f3a7b783          	ld	a5,-198(a5) # 1220 <threads>
 2ee:	5fb4                	lw	a3,120(a5)
 2f0:	470d                	li	a4,3
 2f2:	f8e688e3          	beq	a3,a4,282 <tsched+0x46>
 2f6:	8082                	ret

00000000000002f8 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2f8:	7179                	addi	sp,sp,-48
 2fa:	f406                	sd	ra,40(sp)
 2fc:	f022                	sd	s0,32(sp)
 2fe:	ec26                	sd	s1,24(sp)
 300:	e84a                	sd	s2,16(sp)
 302:	e44e                	sd	s3,8(sp)
 304:	1800                	addi	s0,sp,48
 306:	84aa                	mv	s1,a0
 308:	89b2                	mv	s3,a2
 30a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 30c:	09000513          	li	a0,144
 310:	00001097          	auipc	ra,0x1
 314:	900080e7          	jalr	-1792(ra) # c10 <malloc>
 318:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 31a:	478d                	li	a5,3
 31c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 31e:	609c                	ld	a5,0(s1)
 320:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 324:	609c                	ld	a5,0(s1)
 326:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 32a:	00001717          	auipc	a4,0x1
 32e:	cd670713          	addi	a4,a4,-810 # 1000 <next_tid>
 332:	431c                	lw	a5,0(a4)
 334:	0017869b          	addiw	a3,a5,1
 338:	c314                	sw	a3,0(a4)
 33a:	6098                	ld	a4,0(s1)
 33c:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 340:	00001717          	auipc	a4,0x1
 344:	ee070713          	addi	a4,a4,-288 # 1220 <threads>
 348:	4781                	li	a5,0
 34a:	4641                	li	a2,16
    if (threads[i] == NULL) {
 34c:	6314                	ld	a3,0(a4)
 34e:	ce81                	beqz	a3,366 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 350:	2785                	addiw	a5,a5,1
 352:	0721                	addi	a4,a4,8
 354:	fec79ce3          	bne	a5,a2,34c <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 358:	70a2                	ld	ra,40(sp)
 35a:	7402                	ld	s0,32(sp)
 35c:	64e2                	ld	s1,24(sp)
 35e:	6942                	ld	s2,16(sp)
 360:	69a2                	ld	s3,8(sp)
 362:	6145                	addi	sp,sp,48
 364:	8082                	ret
        threads[i] = *thread;
 366:	6094                	ld	a3,0(s1)
 368:	078e                	slli	a5,a5,0x3
 36a:	00001717          	auipc	a4,0x1
 36e:	eb670713          	addi	a4,a4,-330 # 1220 <threads>
 372:	97ba                	add	a5,a5,a4
 374:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 376:	0006c583          	lbu	a1,0(a3)
 37a:	00001517          	auipc	a0,0x1
 37e:	a5e50513          	addi	a0,a0,-1442 # dd8 <malloc+0x1c8>
 382:	00000097          	auipc	ra,0x0
 386:	7d6080e7          	jalr	2006(ra) # b58 <printf>
        break;
 38a:	b7f9                	j	358 <tcreate+0x60>

000000000000038c <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 38c:	7179                	addi	sp,sp,-48
 38e:	f406                	sd	ra,40(sp)
 390:	f022                	sd	s0,32(sp)
 392:	ec26                	sd	s1,24(sp)
 394:	e84a                	sd	s2,16(sp)
 396:	e44e                	sd	s3,8(sp)
 398:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 39a:	00001797          	auipc	a5,0x1
 39e:	e8678793          	addi	a5,a5,-378 # 1220 <threads>
 3a2:	00001697          	auipc	a3,0x1
 3a6:	efe68693          	addi	a3,a3,-258 # 12a0 <base>
 3aa:	a021                	j	3b2 <tjoin+0x26>
 3ac:	07a1                	addi	a5,a5,8
 3ae:	04d78763          	beq	a5,a3,3fc <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 3b2:	6384                	ld	s1,0(a5)
 3b4:	dce5                	beqz	s1,3ac <tjoin+0x20>
 3b6:	0004c703          	lbu	a4,0(s1)
 3ba:	fea719e3          	bne	a4,a0,3ac <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 3be:	5cb8                	lw	a4,120(s1)
 3c0:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3c2:	00001997          	auipc	s3,0x1
 3c6:	a4698993          	addi	s3,s3,-1466 # e08 <malloc+0x1f8>
    while (target_thread->state != EXITED) {
 3ca:	4919                	li	s2,6
 3cc:	02f70a63          	beq	a4,a5,400 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3d0:	0004c583          	lbu	a1,0(s1)
 3d4:	854e                	mv	a0,s3
 3d6:	00000097          	auipc	ra,0x0
 3da:	782080e7          	jalr	1922(ra) # b58 <printf>
        tsched();
 3de:	00000097          	auipc	ra,0x0
 3e2:	e5e080e7          	jalr	-418(ra) # 23c <tsched>
    while (target_thread->state != EXITED) {
 3e6:	5cbc                	lw	a5,120(s1)
 3e8:	ff2794e3          	bne	a5,s2,3d0 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 3ec:	4501                	li	a0,0
}
 3ee:	70a2                	ld	ra,40(sp)
 3f0:	7402                	ld	s0,32(sp)
 3f2:	64e2                	ld	s1,24(sp)
 3f4:	6942                	ld	s2,16(sp)
 3f6:	69a2                	ld	s3,8(sp)
 3f8:	6145                	addi	sp,sp,48
 3fa:	8082                	ret
        return -1;
 3fc:	557d                	li	a0,-1
 3fe:	bfc5                	j	3ee <tjoin+0x62>
    return 0;
 400:	4501                	li	a0,0
 402:	b7f5                	j	3ee <tjoin+0x62>

0000000000000404 <tyield>:


void tyield()
{
 404:	1141                	addi	sp,sp,-16
 406:	e406                	sd	ra,8(sp)
 408:	e022                	sd	s0,0(sp)
 40a:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 40c:	00001797          	auipc	a5,0x1
 410:	c047b783          	ld	a5,-1020(a5) # 1010 <current_thread>
 414:	470d                	li	a4,3
 416:	dfb8                	sw	a4,120(a5)
    tsched();
 418:	00000097          	auipc	ra,0x0
 41c:	e24080e7          	jalr	-476(ra) # 23c <tsched>
}
 420:	60a2                	ld	ra,8(sp)
 422:	6402                	ld	s0,0(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <twhoami>:

uint8 twhoami()
{
 428:	1141                	addi	sp,sp,-16
 42a:	e422                	sd	s0,8(sp)
 42c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 42e:	00001797          	auipc	a5,0x1
 432:	be27b783          	ld	a5,-1054(a5) # 1010 <current_thread>
 436:	0007c503          	lbu	a0,0(a5)
 43a:	6422                	ld	s0,8(sp)
 43c:	0141                	addi	sp,sp,16
 43e:	8082                	ret

0000000000000440 <tswtch>:
 440:	00153023          	sd	ra,0(a0)
 444:	00253423          	sd	sp,8(a0)
 448:	e900                	sd	s0,16(a0)
 44a:	ed04                	sd	s1,24(a0)
 44c:	03253023          	sd	s2,32(a0)
 450:	03353423          	sd	s3,40(a0)
 454:	03453823          	sd	s4,48(a0)
 458:	03553c23          	sd	s5,56(a0)
 45c:	05653023          	sd	s6,64(a0)
 460:	05753423          	sd	s7,72(a0)
 464:	05853823          	sd	s8,80(a0)
 468:	05953c23          	sd	s9,88(a0)
 46c:	07a53023          	sd	s10,96(a0)
 470:	07b53423          	sd	s11,104(a0)
 474:	0005b083          	ld	ra,0(a1)
 478:	0085b103          	ld	sp,8(a1)
 47c:	6980                	ld	s0,16(a1)
 47e:	6d84                	ld	s1,24(a1)
 480:	0205b903          	ld	s2,32(a1)
 484:	0285b983          	ld	s3,40(a1)
 488:	0305ba03          	ld	s4,48(a1)
 48c:	0385ba83          	ld	s5,56(a1)
 490:	0405bb03          	ld	s6,64(a1)
 494:	0485bb83          	ld	s7,72(a1)
 498:	0505bc03          	ld	s8,80(a1)
 49c:	0585bc83          	ld	s9,88(a1)
 4a0:	0605bd03          	ld	s10,96(a1)
 4a4:	0685bd83          	ld	s11,104(a1)
 4a8:	8082                	ret

00000000000004aa <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4aa:	715d                	addi	sp,sp,-80
 4ac:	e486                	sd	ra,72(sp)
 4ae:	e0a2                	sd	s0,64(sp)
 4b0:	fc26                	sd	s1,56(sp)
 4b2:	f84a                	sd	s2,48(sp)
 4b4:	f44e                	sd	s3,40(sp)
 4b6:	f052                	sd	s4,32(sp)
 4b8:	ec56                	sd	s5,24(sp)
 4ba:	e85a                	sd	s6,16(sp)
 4bc:	e45e                	sd	s7,8(sp)
 4be:	0880                	addi	s0,sp,80
 4c0:	892a                	mv	s2,a0
 4c2:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 4c4:	00001517          	auipc	a0,0x1
 4c8:	96450513          	addi	a0,a0,-1692 # e28 <malloc+0x218>
 4cc:	00000097          	auipc	ra,0x0
 4d0:	68c080e7          	jalr	1676(ra) # b58 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4d4:	09000513          	li	a0,144
 4d8:	00000097          	auipc	ra,0x0
 4dc:	738080e7          	jalr	1848(ra) # c10 <malloc>

    main_thread->tid = 0;
 4e0:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 4e4:	4791                	li	a5,4
 4e6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4e8:	00001797          	auipc	a5,0x1
 4ec:	b2a7b423          	sd	a0,-1240(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4f0:	00001a17          	auipc	s4,0x1
 4f4:	d30a0a13          	addi	s4,s4,-720 # 1220 <threads>
 4f8:	00001497          	auipc	s1,0x1
 4fc:	da848493          	addi	s1,s1,-600 # 12a0 <base>
    current_thread = main_thread;
 500:	87d2                	mv	a5,s4
        threads[i] = NULL;
 502:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 506:	07a1                	addi	a5,a5,8
 508:	fe979de3          	bne	a5,s1,502 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 50c:	00001797          	auipc	a5,0x1
 510:	d0a7ba23          	sd	a0,-748(a5) # 1220 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 514:	85ce                	mv	a1,s3
 516:	854a                	mv	a0,s2
 518:	00000097          	auipc	ra,0x0
 51c:	b72080e7          	jalr	-1166(ra) # 8a <main>
 520:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 522:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 524:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 526:	00001a97          	auipc	s5,0x1
 52a:	922a8a93          	addi	s5,s5,-1758 # e48 <malloc+0x238>
 52e:	a03d                	j	55c <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 530:	07a1                	addi	a5,a5,8
 532:	00978963          	beq	a5,s1,544 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 536:	6398                	ld	a4,0(a5)
 538:	df65                	beqz	a4,530 <_main+0x86>
 53a:	5f38                	lw	a4,120(a4)
 53c:	ff370ae3          	beq	a4,s3,530 <_main+0x86>
                running_threads++;
 540:	2905                	addiw	s2,s2,1
 542:	b7fd                	j	530 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 544:	85ca                	mv	a1,s2
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	610080e7          	jalr	1552(ra) # b58 <printf>
        if (running_threads > 0) {
 550:	01205963          	blez	s2,562 <_main+0xb8>
            tsched(); // Schedule another thread to run
 554:	00000097          	auipc	ra,0x0
 558:	ce8080e7          	jalr	-792(ra) # 23c <tsched>
    current_thread = main_thread;
 55c:	87d2                	mv	a5,s4
        running_threads = 0;
 55e:	895a                	mv	s2,s6
 560:	bfd9                	j	536 <_main+0x8c>
        }
    }

    exit(res);
 562:	855e                	mv	a0,s7
 564:	00000097          	auipc	ra,0x0
 568:	274080e7          	jalr	628(ra) # 7d8 <exit>

000000000000056c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 56c:	1141                	addi	sp,sp,-16
 56e:	e422                	sd	s0,8(sp)
 570:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 572:	87aa                	mv	a5,a0
 574:	0585                	addi	a1,a1,1
 576:	0785                	addi	a5,a5,1
 578:	fff5c703          	lbu	a4,-1(a1)
 57c:	fee78fa3          	sb	a4,-1(a5)
 580:	fb75                	bnez	a4,574 <strcpy+0x8>
        ;
    return os;
}
 582:	6422                	ld	s0,8(sp)
 584:	0141                	addi	sp,sp,16
 586:	8082                	ret

0000000000000588 <strcmp>:

int strcmp(const char *p, const char *q)
{
 588:	1141                	addi	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 58e:	00054783          	lbu	a5,0(a0)
 592:	cb91                	beqz	a5,5a6 <strcmp+0x1e>
 594:	0005c703          	lbu	a4,0(a1)
 598:	00f71763          	bne	a4,a5,5a6 <strcmp+0x1e>
        p++, q++;
 59c:	0505                	addi	a0,a0,1
 59e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 5a0:	00054783          	lbu	a5,0(a0)
 5a4:	fbe5                	bnez	a5,594 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 5a6:	0005c503          	lbu	a0,0(a1)
}
 5aa:	40a7853b          	subw	a0,a5,a0
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <strlen>:

uint strlen(const char *s)
{
 5b4:	1141                	addi	sp,sp,-16
 5b6:	e422                	sd	s0,8(sp)
 5b8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 5ba:	00054783          	lbu	a5,0(a0)
 5be:	cf91                	beqz	a5,5da <strlen+0x26>
 5c0:	0505                	addi	a0,a0,1
 5c2:	87aa                	mv	a5,a0
 5c4:	86be                	mv	a3,a5
 5c6:	0785                	addi	a5,a5,1
 5c8:	fff7c703          	lbu	a4,-1(a5)
 5cc:	ff65                	bnez	a4,5c4 <strlen+0x10>
 5ce:	40a6853b          	subw	a0,a3,a0
 5d2:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5d4:	6422                	ld	s0,8(sp)
 5d6:	0141                	addi	sp,sp,16
 5d8:	8082                	ret
    for (n = 0; s[n]; n++)
 5da:	4501                	li	a0,0
 5dc:	bfe5                	j	5d4 <strlen+0x20>

00000000000005de <memset>:

void *
memset(void *dst, int c, uint n)
{
 5de:	1141                	addi	sp,sp,-16
 5e0:	e422                	sd	s0,8(sp)
 5e2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5e4:	ca19                	beqz	a2,5fa <memset+0x1c>
 5e6:	87aa                	mv	a5,a0
 5e8:	1602                	slli	a2,a2,0x20
 5ea:	9201                	srli	a2,a2,0x20
 5ec:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5f0:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5f4:	0785                	addi	a5,a5,1
 5f6:	fee79de3          	bne	a5,a4,5f0 <memset+0x12>
    }
    return dst;
}
 5fa:	6422                	ld	s0,8(sp)
 5fc:	0141                	addi	sp,sp,16
 5fe:	8082                	ret

0000000000000600 <strchr>:

char *
strchr(const char *s, char c)
{
 600:	1141                	addi	sp,sp,-16
 602:	e422                	sd	s0,8(sp)
 604:	0800                	addi	s0,sp,16
    for (; *s; s++)
 606:	00054783          	lbu	a5,0(a0)
 60a:	cb99                	beqz	a5,620 <strchr+0x20>
        if (*s == c)
 60c:	00f58763          	beq	a1,a5,61a <strchr+0x1a>
    for (; *s; s++)
 610:	0505                	addi	a0,a0,1
 612:	00054783          	lbu	a5,0(a0)
 616:	fbfd                	bnez	a5,60c <strchr+0xc>
            return (char *)s;
    return 0;
 618:	4501                	li	a0,0
}
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	addi	sp,sp,16
 61e:	8082                	ret
    return 0;
 620:	4501                	li	a0,0
 622:	bfe5                	j	61a <strchr+0x1a>

0000000000000624 <gets>:

char *
gets(char *buf, int max)
{
 624:	711d                	addi	sp,sp,-96
 626:	ec86                	sd	ra,88(sp)
 628:	e8a2                	sd	s0,80(sp)
 62a:	e4a6                	sd	s1,72(sp)
 62c:	e0ca                	sd	s2,64(sp)
 62e:	fc4e                	sd	s3,56(sp)
 630:	f852                	sd	s4,48(sp)
 632:	f456                	sd	s5,40(sp)
 634:	f05a                	sd	s6,32(sp)
 636:	ec5e                	sd	s7,24(sp)
 638:	1080                	addi	s0,sp,96
 63a:	8baa                	mv	s7,a0
 63c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 63e:	892a                	mv	s2,a0
 640:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 642:	4aa9                	li	s5,10
 644:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 646:	89a6                	mv	s3,s1
 648:	2485                	addiw	s1,s1,1
 64a:	0344d863          	bge	s1,s4,67a <gets+0x56>
        cc = read(0, &c, 1);
 64e:	4605                	li	a2,1
 650:	faf40593          	addi	a1,s0,-81
 654:	4501                	li	a0,0
 656:	00000097          	auipc	ra,0x0
 65a:	19a080e7          	jalr	410(ra) # 7f0 <read>
        if (cc < 1)
 65e:	00a05e63          	blez	a0,67a <gets+0x56>
        buf[i++] = c;
 662:	faf44783          	lbu	a5,-81(s0)
 666:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 66a:	01578763          	beq	a5,s5,678 <gets+0x54>
 66e:	0905                	addi	s2,s2,1
 670:	fd679be3          	bne	a5,s6,646 <gets+0x22>
    for (i = 0; i + 1 < max;)
 674:	89a6                	mv	s3,s1
 676:	a011                	j	67a <gets+0x56>
 678:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 67a:	99de                	add	s3,s3,s7
 67c:	00098023          	sb	zero,0(s3)
    return buf;
}
 680:	855e                	mv	a0,s7
 682:	60e6                	ld	ra,88(sp)
 684:	6446                	ld	s0,80(sp)
 686:	64a6                	ld	s1,72(sp)
 688:	6906                	ld	s2,64(sp)
 68a:	79e2                	ld	s3,56(sp)
 68c:	7a42                	ld	s4,48(sp)
 68e:	7aa2                	ld	s5,40(sp)
 690:	7b02                	ld	s6,32(sp)
 692:	6be2                	ld	s7,24(sp)
 694:	6125                	addi	sp,sp,96
 696:	8082                	ret

0000000000000698 <stat>:

int stat(const char *n, struct stat *st)
{
 698:	1101                	addi	sp,sp,-32
 69a:	ec06                	sd	ra,24(sp)
 69c:	e822                	sd	s0,16(sp)
 69e:	e426                	sd	s1,8(sp)
 6a0:	e04a                	sd	s2,0(sp)
 6a2:	1000                	addi	s0,sp,32
 6a4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 6a6:	4581                	li	a1,0
 6a8:	00000097          	auipc	ra,0x0
 6ac:	170080e7          	jalr	368(ra) # 818 <open>
    if (fd < 0)
 6b0:	02054563          	bltz	a0,6da <stat+0x42>
 6b4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 6b6:	85ca                	mv	a1,s2
 6b8:	00000097          	auipc	ra,0x0
 6bc:	178080e7          	jalr	376(ra) # 830 <fstat>
 6c0:	892a                	mv	s2,a0
    close(fd);
 6c2:	8526                	mv	a0,s1
 6c4:	00000097          	auipc	ra,0x0
 6c8:	13c080e7          	jalr	316(ra) # 800 <close>
    return r;
}
 6cc:	854a                	mv	a0,s2
 6ce:	60e2                	ld	ra,24(sp)
 6d0:	6442                	ld	s0,16(sp)
 6d2:	64a2                	ld	s1,8(sp)
 6d4:	6902                	ld	s2,0(sp)
 6d6:	6105                	addi	sp,sp,32
 6d8:	8082                	ret
        return -1;
 6da:	597d                	li	s2,-1
 6dc:	bfc5                	j	6cc <stat+0x34>

00000000000006de <atoi>:

int atoi(const char *s)
{
 6de:	1141                	addi	sp,sp,-16
 6e0:	e422                	sd	s0,8(sp)
 6e2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6e4:	00054683          	lbu	a3,0(a0)
 6e8:	fd06879b          	addiw	a5,a3,-48
 6ec:	0ff7f793          	zext.b	a5,a5
 6f0:	4625                	li	a2,9
 6f2:	02f66863          	bltu	a2,a5,722 <atoi+0x44>
 6f6:	872a                	mv	a4,a0
    n = 0;
 6f8:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6fa:	0705                	addi	a4,a4,1
 6fc:	0025179b          	slliw	a5,a0,0x2
 700:	9fa9                	addw	a5,a5,a0
 702:	0017979b          	slliw	a5,a5,0x1
 706:	9fb5                	addw	a5,a5,a3
 708:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 70c:	00074683          	lbu	a3,0(a4)
 710:	fd06879b          	addiw	a5,a3,-48
 714:	0ff7f793          	zext.b	a5,a5
 718:	fef671e3          	bgeu	a2,a5,6fa <atoi+0x1c>
    return n;
}
 71c:	6422                	ld	s0,8(sp)
 71e:	0141                	addi	sp,sp,16
 720:	8082                	ret
    n = 0;
 722:	4501                	li	a0,0
 724:	bfe5                	j	71c <atoi+0x3e>

0000000000000726 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 726:	1141                	addi	sp,sp,-16
 728:	e422                	sd	s0,8(sp)
 72a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 72c:	02b57463          	bgeu	a0,a1,754 <memmove+0x2e>
    {
        while (n-- > 0)
 730:	00c05f63          	blez	a2,74e <memmove+0x28>
 734:	1602                	slli	a2,a2,0x20
 736:	9201                	srli	a2,a2,0x20
 738:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 73c:	872a                	mv	a4,a0
            *dst++ = *src++;
 73e:	0585                	addi	a1,a1,1
 740:	0705                	addi	a4,a4,1
 742:	fff5c683          	lbu	a3,-1(a1)
 746:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 74a:	fee79ae3          	bne	a5,a4,73e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 74e:	6422                	ld	s0,8(sp)
 750:	0141                	addi	sp,sp,16
 752:	8082                	ret
        dst += n;
 754:	00c50733          	add	a4,a0,a2
        src += n;
 758:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 75a:	fec05ae3          	blez	a2,74e <memmove+0x28>
 75e:	fff6079b          	addiw	a5,a2,-1
 762:	1782                	slli	a5,a5,0x20
 764:	9381                	srli	a5,a5,0x20
 766:	fff7c793          	not	a5,a5
 76a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 76c:	15fd                	addi	a1,a1,-1
 76e:	177d                	addi	a4,a4,-1
 770:	0005c683          	lbu	a3,0(a1)
 774:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 778:	fee79ae3          	bne	a5,a4,76c <memmove+0x46>
 77c:	bfc9                	j	74e <memmove+0x28>

000000000000077e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 77e:	1141                	addi	sp,sp,-16
 780:	e422                	sd	s0,8(sp)
 782:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 784:	ca05                	beqz	a2,7b4 <memcmp+0x36>
 786:	fff6069b          	addiw	a3,a2,-1
 78a:	1682                	slli	a3,a3,0x20
 78c:	9281                	srli	a3,a3,0x20
 78e:	0685                	addi	a3,a3,1
 790:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 792:	00054783          	lbu	a5,0(a0)
 796:	0005c703          	lbu	a4,0(a1)
 79a:	00e79863          	bne	a5,a4,7aa <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 79e:	0505                	addi	a0,a0,1
        p2++;
 7a0:	0585                	addi	a1,a1,1
    while (n-- > 0)
 7a2:	fed518e3          	bne	a0,a3,792 <memcmp+0x14>
    }
    return 0;
 7a6:	4501                	li	a0,0
 7a8:	a019                	j	7ae <memcmp+0x30>
            return *p1 - *p2;
 7aa:	40e7853b          	subw	a0,a5,a4
}
 7ae:	6422                	ld	s0,8(sp)
 7b0:	0141                	addi	sp,sp,16
 7b2:	8082                	ret
    return 0;
 7b4:	4501                	li	a0,0
 7b6:	bfe5                	j	7ae <memcmp+0x30>

00000000000007b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e406                	sd	ra,8(sp)
 7bc:	e022                	sd	s0,0(sp)
 7be:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 7c0:	00000097          	auipc	ra,0x0
 7c4:	f66080e7          	jalr	-154(ra) # 726 <memmove>
}
 7c8:	60a2                	ld	ra,8(sp)
 7ca:	6402                	ld	s0,0(sp)
 7cc:	0141                	addi	sp,sp,16
 7ce:	8082                	ret

00000000000007d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7d0:	4885                	li	a7,1
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7d8:	4889                	li	a7,2
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7e0:	488d                	li	a7,3
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7e8:	4891                	li	a7,4
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <read>:
.global read
read:
 li a7, SYS_read
 7f0:	4895                	li	a7,5
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <write>:
.global write
write:
 li a7, SYS_write
 7f8:	48c1                	li	a7,16
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <close>:
.global close
close:
 li a7, SYS_close
 800:	48d5                	li	a7,21
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <kill>:
.global kill
kill:
 li a7, SYS_kill
 808:	4899                	li	a7,6
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <exec>:
.global exec
exec:
 li a7, SYS_exec
 810:	489d                	li	a7,7
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <open>:
.global open
open:
 li a7, SYS_open
 818:	48bd                	li	a7,15
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 820:	48c5                	li	a7,17
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 828:	48c9                	li	a7,18
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 830:	48a1                	li	a7,8
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <link>:
.global link
link:
 li a7, SYS_link
 838:	48cd                	li	a7,19
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 840:	48d1                	li	a7,20
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 848:	48a5                	li	a7,9
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <dup>:
.global dup
dup:
 li a7, SYS_dup
 850:	48a9                	li	a7,10
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 858:	48ad                	li	a7,11
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 860:	48b1                	li	a7,12
 ecall
 862:	00000073          	ecall
 ret
 866:	8082                	ret

0000000000000868 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 868:	48b5                	li	a7,13
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 870:	48b9                	li	a7,14
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <ps>:
.global ps
ps:
 li a7, SYS_ps
 878:	48d9                	li	a7,22
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 880:	48dd                	li	a7,23
 ecall
 882:	00000073          	ecall
 ret
 886:	8082                	ret

0000000000000888 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 888:	48e1                	li	a7,24
 ecall
 88a:	00000073          	ecall
 ret
 88e:	8082                	ret

0000000000000890 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 890:	1101                	addi	sp,sp,-32
 892:	ec06                	sd	ra,24(sp)
 894:	e822                	sd	s0,16(sp)
 896:	1000                	addi	s0,sp,32
 898:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 89c:	4605                	li	a2,1
 89e:	fef40593          	addi	a1,s0,-17
 8a2:	00000097          	auipc	ra,0x0
 8a6:	f56080e7          	jalr	-170(ra) # 7f8 <write>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6105                	addi	sp,sp,32
 8b0:	8082                	ret

00000000000008b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8b2:	7139                	addi	sp,sp,-64
 8b4:	fc06                	sd	ra,56(sp)
 8b6:	f822                	sd	s0,48(sp)
 8b8:	f426                	sd	s1,40(sp)
 8ba:	f04a                	sd	s2,32(sp)
 8bc:	ec4e                	sd	s3,24(sp)
 8be:	0080                	addi	s0,sp,64
 8c0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8c2:	c299                	beqz	a3,8c8 <printint+0x16>
 8c4:	0805c963          	bltz	a1,956 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8c8:	2581                	sext.w	a1,a1
  neg = 0;
 8ca:	4881                	li	a7,0
 8cc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8d2:	2601                	sext.w	a2,a2
 8d4:	00000517          	auipc	a0,0x0
 8d8:	5f450513          	addi	a0,a0,1524 # ec8 <digits>
 8dc:	883a                	mv	a6,a4
 8de:	2705                	addiw	a4,a4,1
 8e0:	02c5f7bb          	remuw	a5,a1,a2
 8e4:	1782                	slli	a5,a5,0x20
 8e6:	9381                	srli	a5,a5,0x20
 8e8:	97aa                	add	a5,a5,a0
 8ea:	0007c783          	lbu	a5,0(a5)
 8ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8f2:	0005879b          	sext.w	a5,a1
 8f6:	02c5d5bb          	divuw	a1,a1,a2
 8fa:	0685                	addi	a3,a3,1
 8fc:	fec7f0e3          	bgeu	a5,a2,8dc <printint+0x2a>
  if(neg)
 900:	00088c63          	beqz	a7,918 <printint+0x66>
    buf[i++] = '-';
 904:	fd070793          	addi	a5,a4,-48
 908:	00878733          	add	a4,a5,s0
 90c:	02d00793          	li	a5,45
 910:	fef70823          	sb	a5,-16(a4)
 914:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 918:	02e05863          	blez	a4,948 <printint+0x96>
 91c:	fc040793          	addi	a5,s0,-64
 920:	00e78933          	add	s2,a5,a4
 924:	fff78993          	addi	s3,a5,-1
 928:	99ba                	add	s3,s3,a4
 92a:	377d                	addiw	a4,a4,-1
 92c:	1702                	slli	a4,a4,0x20
 92e:	9301                	srli	a4,a4,0x20
 930:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 934:	fff94583          	lbu	a1,-1(s2)
 938:	8526                	mv	a0,s1
 93a:	00000097          	auipc	ra,0x0
 93e:	f56080e7          	jalr	-170(ra) # 890 <putc>
  while(--i >= 0)
 942:	197d                	addi	s2,s2,-1
 944:	ff3918e3          	bne	s2,s3,934 <printint+0x82>
}
 948:	70e2                	ld	ra,56(sp)
 94a:	7442                	ld	s0,48(sp)
 94c:	74a2                	ld	s1,40(sp)
 94e:	7902                	ld	s2,32(sp)
 950:	69e2                	ld	s3,24(sp)
 952:	6121                	addi	sp,sp,64
 954:	8082                	ret
    x = -xx;
 956:	40b005bb          	negw	a1,a1
    neg = 1;
 95a:	4885                	li	a7,1
    x = -xx;
 95c:	bf85                	j	8cc <printint+0x1a>

000000000000095e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 95e:	715d                	addi	sp,sp,-80
 960:	e486                	sd	ra,72(sp)
 962:	e0a2                	sd	s0,64(sp)
 964:	fc26                	sd	s1,56(sp)
 966:	f84a                	sd	s2,48(sp)
 968:	f44e                	sd	s3,40(sp)
 96a:	f052                	sd	s4,32(sp)
 96c:	ec56                	sd	s5,24(sp)
 96e:	e85a                	sd	s6,16(sp)
 970:	e45e                	sd	s7,8(sp)
 972:	e062                	sd	s8,0(sp)
 974:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 976:	0005c903          	lbu	s2,0(a1)
 97a:	18090c63          	beqz	s2,b12 <vprintf+0x1b4>
 97e:	8aaa                	mv	s5,a0
 980:	8bb2                	mv	s7,a2
 982:	00158493          	addi	s1,a1,1
  state = 0;
 986:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 988:	02500a13          	li	s4,37
 98c:	4b55                	li	s6,21
 98e:	a839                	j	9ac <vprintf+0x4e>
        putc(fd, c);
 990:	85ca                	mv	a1,s2
 992:	8556                	mv	a0,s5
 994:	00000097          	auipc	ra,0x0
 998:	efc080e7          	jalr	-260(ra) # 890 <putc>
 99c:	a019                	j	9a2 <vprintf+0x44>
    } else if(state == '%'){
 99e:	01498d63          	beq	s3,s4,9b8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 9a2:	0485                	addi	s1,s1,1
 9a4:	fff4c903          	lbu	s2,-1(s1)
 9a8:	16090563          	beqz	s2,b12 <vprintf+0x1b4>
    if(state == 0){
 9ac:	fe0999e3          	bnez	s3,99e <vprintf+0x40>
      if(c == '%'){
 9b0:	ff4910e3          	bne	s2,s4,990 <vprintf+0x32>
        state = '%';
 9b4:	89d2                	mv	s3,s4
 9b6:	b7f5                	j	9a2 <vprintf+0x44>
      if(c == 'd'){
 9b8:	13490263          	beq	s2,s4,adc <vprintf+0x17e>
 9bc:	f9d9079b          	addiw	a5,s2,-99
 9c0:	0ff7f793          	zext.b	a5,a5
 9c4:	12fb6563          	bltu	s6,a5,aee <vprintf+0x190>
 9c8:	f9d9079b          	addiw	a5,s2,-99
 9cc:	0ff7f713          	zext.b	a4,a5
 9d0:	10eb6f63          	bltu	s6,a4,aee <vprintf+0x190>
 9d4:	00271793          	slli	a5,a4,0x2
 9d8:	00000717          	auipc	a4,0x0
 9dc:	49870713          	addi	a4,a4,1176 # e70 <malloc+0x260>
 9e0:	97ba                	add	a5,a5,a4
 9e2:	439c                	lw	a5,0(a5)
 9e4:	97ba                	add	a5,a5,a4
 9e6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9e8:	008b8913          	addi	s2,s7,8
 9ec:	4685                	li	a3,1
 9ee:	4629                	li	a2,10
 9f0:	000ba583          	lw	a1,0(s7)
 9f4:	8556                	mv	a0,s5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	ebc080e7          	jalr	-324(ra) # 8b2 <printint>
 9fe:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b745                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a04:	008b8913          	addi	s2,s7,8
 a08:	4681                	li	a3,0
 a0a:	4629                	li	a2,10
 a0c:	000ba583          	lw	a1,0(s7)
 a10:	8556                	mv	a0,s5
 a12:	00000097          	auipc	ra,0x0
 a16:	ea0080e7          	jalr	-352(ra) # 8b2 <printint>
 a1a:	8bca                	mv	s7,s2
      state = 0;
 a1c:	4981                	li	s3,0
 a1e:	b751                	j	9a2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a20:	008b8913          	addi	s2,s7,8
 a24:	4681                	li	a3,0
 a26:	4641                	li	a2,16
 a28:	000ba583          	lw	a1,0(s7)
 a2c:	8556                	mv	a0,s5
 a2e:	00000097          	auipc	ra,0x0
 a32:	e84080e7          	jalr	-380(ra) # 8b2 <printint>
 a36:	8bca                	mv	s7,s2
      state = 0;
 a38:	4981                	li	s3,0
 a3a:	b7a5                	j	9a2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a3c:	008b8c13          	addi	s8,s7,8
 a40:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a44:	03000593          	li	a1,48
 a48:	8556                	mv	a0,s5
 a4a:	00000097          	auipc	ra,0x0
 a4e:	e46080e7          	jalr	-442(ra) # 890 <putc>
  putc(fd, 'x');
 a52:	07800593          	li	a1,120
 a56:	8556                	mv	a0,s5
 a58:	00000097          	auipc	ra,0x0
 a5c:	e38080e7          	jalr	-456(ra) # 890 <putc>
 a60:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a62:	00000b97          	auipc	s7,0x0
 a66:	466b8b93          	addi	s7,s7,1126 # ec8 <digits>
 a6a:	03c9d793          	srli	a5,s3,0x3c
 a6e:	97de                	add	a5,a5,s7
 a70:	0007c583          	lbu	a1,0(a5)
 a74:	8556                	mv	a0,s5
 a76:	00000097          	auipc	ra,0x0
 a7a:	e1a080e7          	jalr	-486(ra) # 890 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a7e:	0992                	slli	s3,s3,0x4
 a80:	397d                	addiw	s2,s2,-1
 a82:	fe0914e3          	bnez	s2,a6a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a86:	8be2                	mv	s7,s8
      state = 0;
 a88:	4981                	li	s3,0
 a8a:	bf21                	j	9a2 <vprintf+0x44>
        s = va_arg(ap, char*);
 a8c:	008b8993          	addi	s3,s7,8
 a90:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a94:	02090163          	beqz	s2,ab6 <vprintf+0x158>
        while(*s != 0){
 a98:	00094583          	lbu	a1,0(s2)
 a9c:	c9a5                	beqz	a1,b0c <vprintf+0x1ae>
          putc(fd, *s);
 a9e:	8556                	mv	a0,s5
 aa0:	00000097          	auipc	ra,0x0
 aa4:	df0080e7          	jalr	-528(ra) # 890 <putc>
          s++;
 aa8:	0905                	addi	s2,s2,1
        while(*s != 0){
 aaa:	00094583          	lbu	a1,0(s2)
 aae:	f9e5                	bnez	a1,a9e <vprintf+0x140>
        s = va_arg(ap, char*);
 ab0:	8bce                	mv	s7,s3
      state = 0;
 ab2:	4981                	li	s3,0
 ab4:	b5fd                	j	9a2 <vprintf+0x44>
          s = "(null)";
 ab6:	00000917          	auipc	s2,0x0
 aba:	3b290913          	addi	s2,s2,946 # e68 <malloc+0x258>
        while(*s != 0){
 abe:	02800593          	li	a1,40
 ac2:	bff1                	j	a9e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 ac4:	008b8913          	addi	s2,s7,8
 ac8:	000bc583          	lbu	a1,0(s7)
 acc:	8556                	mv	a0,s5
 ace:	00000097          	auipc	ra,0x0
 ad2:	dc2080e7          	jalr	-574(ra) # 890 <putc>
 ad6:	8bca                	mv	s7,s2
      state = 0;
 ad8:	4981                	li	s3,0
 ada:	b5e1                	j	9a2 <vprintf+0x44>
        putc(fd, c);
 adc:	02500593          	li	a1,37
 ae0:	8556                	mv	a0,s5
 ae2:	00000097          	auipc	ra,0x0
 ae6:	dae080e7          	jalr	-594(ra) # 890 <putc>
      state = 0;
 aea:	4981                	li	s3,0
 aec:	bd5d                	j	9a2 <vprintf+0x44>
        putc(fd, '%');
 aee:	02500593          	li	a1,37
 af2:	8556                	mv	a0,s5
 af4:	00000097          	auipc	ra,0x0
 af8:	d9c080e7          	jalr	-612(ra) # 890 <putc>
        putc(fd, c);
 afc:	85ca                	mv	a1,s2
 afe:	8556                	mv	a0,s5
 b00:	00000097          	auipc	ra,0x0
 b04:	d90080e7          	jalr	-624(ra) # 890 <putc>
      state = 0;
 b08:	4981                	li	s3,0
 b0a:	bd61                	j	9a2 <vprintf+0x44>
        s = va_arg(ap, char*);
 b0c:	8bce                	mv	s7,s3
      state = 0;
 b0e:	4981                	li	s3,0
 b10:	bd49                	j	9a2 <vprintf+0x44>
    }
  }
}
 b12:	60a6                	ld	ra,72(sp)
 b14:	6406                	ld	s0,64(sp)
 b16:	74e2                	ld	s1,56(sp)
 b18:	7942                	ld	s2,48(sp)
 b1a:	79a2                	ld	s3,40(sp)
 b1c:	7a02                	ld	s4,32(sp)
 b1e:	6ae2                	ld	s5,24(sp)
 b20:	6b42                	ld	s6,16(sp)
 b22:	6ba2                	ld	s7,8(sp)
 b24:	6c02                	ld	s8,0(sp)
 b26:	6161                	addi	sp,sp,80
 b28:	8082                	ret

0000000000000b2a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b2a:	715d                	addi	sp,sp,-80
 b2c:	ec06                	sd	ra,24(sp)
 b2e:	e822                	sd	s0,16(sp)
 b30:	1000                	addi	s0,sp,32
 b32:	e010                	sd	a2,0(s0)
 b34:	e414                	sd	a3,8(s0)
 b36:	e818                	sd	a4,16(s0)
 b38:	ec1c                	sd	a5,24(s0)
 b3a:	03043023          	sd	a6,32(s0)
 b3e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b42:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b46:	8622                	mv	a2,s0
 b48:	00000097          	auipc	ra,0x0
 b4c:	e16080e7          	jalr	-490(ra) # 95e <vprintf>
}
 b50:	60e2                	ld	ra,24(sp)
 b52:	6442                	ld	s0,16(sp)
 b54:	6161                	addi	sp,sp,80
 b56:	8082                	ret

0000000000000b58 <printf>:

void
printf(const char *fmt, ...)
{
 b58:	711d                	addi	sp,sp,-96
 b5a:	ec06                	sd	ra,24(sp)
 b5c:	e822                	sd	s0,16(sp)
 b5e:	1000                	addi	s0,sp,32
 b60:	e40c                	sd	a1,8(s0)
 b62:	e810                	sd	a2,16(s0)
 b64:	ec14                	sd	a3,24(s0)
 b66:	f018                	sd	a4,32(s0)
 b68:	f41c                	sd	a5,40(s0)
 b6a:	03043823          	sd	a6,48(s0)
 b6e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b72:	00840613          	addi	a2,s0,8
 b76:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b7a:	85aa                	mv	a1,a0
 b7c:	4505                	li	a0,1
 b7e:	00000097          	auipc	ra,0x0
 b82:	de0080e7          	jalr	-544(ra) # 95e <vprintf>
}
 b86:	60e2                	ld	ra,24(sp)
 b88:	6442                	ld	s0,16(sp)
 b8a:	6125                	addi	sp,sp,96
 b8c:	8082                	ret

0000000000000b8e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b8e:	1141                	addi	sp,sp,-16
 b90:	e422                	sd	s0,8(sp)
 b92:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b94:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b98:	00000797          	auipc	a5,0x0
 b9c:	4807b783          	ld	a5,1152(a5) # 1018 <freep>
 ba0:	a02d                	j	bca <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ba2:	4618                	lw	a4,8(a2)
 ba4:	9f2d                	addw	a4,a4,a1
 ba6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 baa:	6398                	ld	a4,0(a5)
 bac:	6310                	ld	a2,0(a4)
 bae:	a83d                	j	bec <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 bb0:	ff852703          	lw	a4,-8(a0)
 bb4:	9f31                	addw	a4,a4,a2
 bb6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 bb8:	ff053683          	ld	a3,-16(a0)
 bbc:	a091                	j	c00 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bbe:	6398                	ld	a4,0(a5)
 bc0:	00e7e463          	bltu	a5,a4,bc8 <free+0x3a>
 bc4:	00e6ea63          	bltu	a3,a4,bd8 <free+0x4a>
{
 bc8:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bca:	fed7fae3          	bgeu	a5,a3,bbe <free+0x30>
 bce:	6398                	ld	a4,0(a5)
 bd0:	00e6e463          	bltu	a3,a4,bd8 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd4:	fee7eae3          	bltu	a5,a4,bc8 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 bd8:	ff852583          	lw	a1,-8(a0)
 bdc:	6390                	ld	a2,0(a5)
 bde:	02059813          	slli	a6,a1,0x20
 be2:	01c85713          	srli	a4,a6,0x1c
 be6:	9736                	add	a4,a4,a3
 be8:	fae60de3          	beq	a2,a4,ba2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bec:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bf0:	4790                	lw	a2,8(a5)
 bf2:	02061593          	slli	a1,a2,0x20
 bf6:	01c5d713          	srli	a4,a1,0x1c
 bfa:	973e                	add	a4,a4,a5
 bfc:	fae68ae3          	beq	a3,a4,bb0 <free+0x22>
        p->s.ptr = bp->s.ptr;
 c00:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 c02:	00000717          	auipc	a4,0x0
 c06:	40f73b23          	sd	a5,1046(a4) # 1018 <freep>
}
 c0a:	6422                	ld	s0,8(sp)
 c0c:	0141                	addi	sp,sp,16
 c0e:	8082                	ret

0000000000000c10 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c10:	7139                	addi	sp,sp,-64
 c12:	fc06                	sd	ra,56(sp)
 c14:	f822                	sd	s0,48(sp)
 c16:	f426                	sd	s1,40(sp)
 c18:	f04a                	sd	s2,32(sp)
 c1a:	ec4e                	sd	s3,24(sp)
 c1c:	e852                	sd	s4,16(sp)
 c1e:	e456                	sd	s5,8(sp)
 c20:	e05a                	sd	s6,0(sp)
 c22:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c24:	02051493          	slli	s1,a0,0x20
 c28:	9081                	srli	s1,s1,0x20
 c2a:	04bd                	addi	s1,s1,15
 c2c:	8091                	srli	s1,s1,0x4
 c2e:	0014899b          	addiw	s3,s1,1
 c32:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c34:	00000517          	auipc	a0,0x0
 c38:	3e453503          	ld	a0,996(a0) # 1018 <freep>
 c3c:	c515                	beqz	a0,c68 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c3e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c40:	4798                	lw	a4,8(a5)
 c42:	02977f63          	bgeu	a4,s1,c80 <malloc+0x70>
    if (nu < 4096)
 c46:	8a4e                	mv	s4,s3
 c48:	0009871b          	sext.w	a4,s3
 c4c:	6685                	lui	a3,0x1
 c4e:	00d77363          	bgeu	a4,a3,c54 <malloc+0x44>
 c52:	6a05                	lui	s4,0x1
 c54:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c58:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c5c:	00000917          	auipc	s2,0x0
 c60:	3bc90913          	addi	s2,s2,956 # 1018 <freep>
    if (p == (char *)-1)
 c64:	5afd                	li	s5,-1
 c66:	a895                	j	cda <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c68:	00000797          	auipc	a5,0x0
 c6c:	63878793          	addi	a5,a5,1592 # 12a0 <base>
 c70:	00000717          	auipc	a4,0x0
 c74:	3af73423          	sd	a5,936(a4) # 1018 <freep>
 c78:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c7a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c7e:	b7e1                	j	c46 <malloc+0x36>
            if (p->s.size == nunits)
 c80:	02e48c63          	beq	s1,a4,cb8 <malloc+0xa8>
                p->s.size -= nunits;
 c84:	4137073b          	subw	a4,a4,s3
 c88:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c8a:	02071693          	slli	a3,a4,0x20
 c8e:	01c6d713          	srli	a4,a3,0x1c
 c92:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c94:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c98:	00000717          	auipc	a4,0x0
 c9c:	38a73023          	sd	a0,896(a4) # 1018 <freep>
            return (void *)(p + 1);
 ca0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ca4:	70e2                	ld	ra,56(sp)
 ca6:	7442                	ld	s0,48(sp)
 ca8:	74a2                	ld	s1,40(sp)
 caa:	7902                	ld	s2,32(sp)
 cac:	69e2                	ld	s3,24(sp)
 cae:	6a42                	ld	s4,16(sp)
 cb0:	6aa2                	ld	s5,8(sp)
 cb2:	6b02                	ld	s6,0(sp)
 cb4:	6121                	addi	sp,sp,64
 cb6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 cb8:	6398                	ld	a4,0(a5)
 cba:	e118                	sd	a4,0(a0)
 cbc:	bff1                	j	c98 <malloc+0x88>
    hp->s.size = nu;
 cbe:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 cc2:	0541                	addi	a0,a0,16
 cc4:	00000097          	auipc	ra,0x0
 cc8:	eca080e7          	jalr	-310(ra) # b8e <free>
    return freep;
 ccc:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 cd0:	d971                	beqz	a0,ca4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cd2:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 cd4:	4798                	lw	a4,8(a5)
 cd6:	fa9775e3          	bgeu	a4,s1,c80 <malloc+0x70>
        if (p == freep)
 cda:	00093703          	ld	a4,0(s2)
 cde:	853e                	mv	a0,a5
 ce0:	fef719e3          	bne	a4,a5,cd2 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ce4:	8552                	mv	a0,s4
 ce6:	00000097          	auipc	ra,0x0
 cea:	b7a080e7          	jalr	-1158(ra) # 860 <sbrk>
    if (p == (char *)-1)
 cee:	fd5518e3          	bne	a0,s5,cbe <malloc+0xae>
                return 0;
 cf2:	4501                	li	a0,0
 cf4:	bf45                	j	ca4 <malloc+0x94>
