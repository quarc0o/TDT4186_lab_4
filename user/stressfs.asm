
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	b0a78793          	addi	a5,a5,-1270 # b20 <malloc+0x122>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	ac450513          	addi	a0,a0,-1340 # af0 <malloc+0xf2>
  34:	00001097          	auipc	ra,0x1
  38:	912080e7          	jalr	-1774(ra) # 946 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	384080e7          	jalr	900(ra) # 3cc <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	56a080e7          	jalr	1386(ra) # 5be <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	aa050513          	addi	a0,a0,-1376 # b08 <malloc+0x10a>
  70:	00001097          	auipc	ra,0x1
  74:	8d6080e7          	jalr	-1834(ra) # 946 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	57c080e7          	jalr	1404(ra) # 606 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	546080e7          	jalr	1350(ra) # 5e6 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	540080e7          	jalr	1344(ra) # 5ee <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	a6250513          	addi	a0,a0,-1438 # b18 <malloc+0x11a>
  be:	00001097          	auipc	ra,0x1
  c2:	888080e7          	jalr	-1912(ra) # 946 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	53a080e7          	jalr	1338(ra) # 606 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	4fc080e7          	jalr	1276(ra) # 5de <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	4fe080e7          	jalr	1278(ra) # 5ee <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	4d4080e7          	jalr	1236(ra) # 5ce <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	4c2080e7          	jalr	1218(ra) # 5c6 <exit>

000000000000010c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
    lk->name = name;
 112:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 114:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 118:	57fd                	li	a5,-1
 11a:	00f50823          	sb	a5,16(a0)
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 124:	00054783          	lbu	a5,0(a0)
 128:	e399                	bnez	a5,12e <holding+0xa>
 12a:	4501                	li	a0,0
}
 12c:	8082                	ret
{
 12e:	1101                	addi	sp,sp,-32
 130:	ec06                	sd	ra,24(sp)
 132:	e822                	sd	s0,16(sp)
 134:	e426                	sd	s1,8(sp)
 136:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 138:	01054483          	lbu	s1,16(a0)
 13c:	00000097          	auipc	ra,0x0
 140:	172080e7          	jalr	370(ra) # 2ae <twhoami>
 144:	2501                	sext.w	a0,a0
 146:	40a48533          	sub	a0,s1,a0
 14a:	00153513          	seqz	a0,a0
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret

0000000000000158 <acquire>:

void acquire(struct lock *lk)
{
 158:	7179                	addi	sp,sp,-48
 15a:	f406                	sd	ra,40(sp)
 15c:	f022                	sd	s0,32(sp)
 15e:	ec26                	sd	s1,24(sp)
 160:	e84a                	sd	s2,16(sp)
 162:	e44e                	sd	s3,8(sp)
 164:	e052                	sd	s4,0(sp)
 166:	1800                	addi	s0,sp,48
 168:	8a2a                	mv	s4,a0
    if (holding(lk))
 16a:	00000097          	auipc	ra,0x0
 16e:	fba080e7          	jalr	-70(ra) # 124 <holding>
 172:	e919                	bnez	a0,188 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 174:	ffca7493          	andi	s1,s4,-4
 178:	003a7913          	andi	s2,s4,3
 17c:	0039191b          	slliw	s2,s2,0x3
 180:	4985                	li	s3,1
 182:	012999bb          	sllw	s3,s3,s2
 186:	a015                	j	1aa <acquire+0x52>
        printf("re-acquiring lock we already hold");
 188:	00001517          	auipc	a0,0x1
 18c:	9a850513          	addi	a0,a0,-1624 # b30 <malloc+0x132>
 190:	00000097          	auipc	ra,0x0
 194:	7b6080e7          	jalr	1974(ra) # 946 <printf>
        exit(-1);
 198:	557d                	li	a0,-1
 19a:	00000097          	auipc	ra,0x0
 19e:	42c080e7          	jalr	1068(ra) # 5c6 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1a2:	00000097          	auipc	ra,0x0
 1a6:	0f4080e7          	jalr	244(ra) # 296 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1aa:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1ae:	0127d7bb          	srlw	a5,a5,s2
 1b2:	0ff7f793          	zext.b	a5,a5
 1b6:	f7f5                	bnez	a5,1a2 <acquire+0x4a>
    }

    __sync_synchronize();
 1b8:	0ff0000f          	fence

    lk->tid = twhoami();
 1bc:	00000097          	auipc	ra,0x0
 1c0:	0f2080e7          	jalr	242(ra) # 2ae <twhoami>
 1c4:	00aa0823          	sb	a0,16(s4)
}
 1c8:	70a2                	ld	ra,40(sp)
 1ca:	7402                	ld	s0,32(sp)
 1cc:	64e2                	ld	s1,24(sp)
 1ce:	6942                	ld	s2,16(sp)
 1d0:	69a2                	ld	s3,8(sp)
 1d2:	6a02                	ld	s4,0(sp)
 1d4:	6145                	addi	sp,sp,48
 1d6:	8082                	ret

00000000000001d8 <release>:

void release(struct lock *lk)
{
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	1000                	addi	s0,sp,32
 1e2:	84aa                	mv	s1,a0
    if (!holding(lk))
 1e4:	00000097          	auipc	ra,0x0
 1e8:	f40080e7          	jalr	-192(ra) # 124 <holding>
 1ec:	c11d                	beqz	a0,212 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1ee:	57fd                	li	a5,-1
 1f0:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1f4:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1f8:	0ff0000f          	fence
 1fc:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 200:	00000097          	auipc	ra,0x0
 204:	096080e7          	jalr	150(ra) # 296 <tyield>
}
 208:	60e2                	ld	ra,24(sp)
 20a:	6442                	ld	s0,16(sp)
 20c:	64a2                	ld	s1,8(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
        printf("releasing lock we are not holding");
 212:	00001517          	auipc	a0,0x1
 216:	94650513          	addi	a0,a0,-1722 # b58 <malloc+0x15a>
 21a:	00000097          	auipc	ra,0x0
 21e:	72c080e7          	jalr	1836(ra) # 946 <printf>
        exit(-1);
 222:	557d                	li	a0,-1
 224:	00000097          	auipc	ra,0x0
 228:	3a2080e7          	jalr	930(ra) # 5c6 <exit>

000000000000022c <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 232:	00001717          	auipc	a4,0x1
 236:	dce73703          	ld	a4,-562(a4) # 1000 <current_thread>
 23a:	47c1                	li	a5,16
 23c:	c319                	beqz	a4,242 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 23e:	37fd                	addiw	a5,a5,-1
 240:	fff5                	bnez	a5,23c <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 242:	6422                	ld	s0,8(sp)
 244:	0141                	addi	sp,sp,16
 246:	8082                	ret

0000000000000248 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 248:	7179                	addi	sp,sp,-48
 24a:	f406                	sd	ra,40(sp)
 24c:	f022                	sd	s0,32(sp)
 24e:	ec26                	sd	s1,24(sp)
 250:	e84a                	sd	s2,16(sp)
 252:	e44e                	sd	s3,8(sp)
 254:	1800                	addi	s0,sp,48
 256:	84aa                	mv	s1,a0
 258:	89b2                	mv	s3,a2
 25a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 25c:	09000513          	li	a0,144
 260:	00000097          	auipc	ra,0x0
 264:	79e080e7          	jalr	1950(ra) # 9fe <malloc>
 268:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 26a:	478d                	li	a5,3
 26c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 26e:	609c                	ld	a5,0(s1)
 270:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 274:	609c                	ld	a5,0(s1)
 276:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 27a:	70a2                	ld	ra,40(sp)
 27c:	7402                	ld	s0,32(sp)
 27e:	64e2                	ld	s1,24(sp)
 280:	6942                	ld	s2,16(sp)
 282:	69a2                	ld	s3,8(sp)
 284:	6145                	addi	sp,sp,48
 286:	8082                	ret

0000000000000288 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 28e:	4501                	li	a0,0
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <tyield>:

void tyield()
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 29c:	00001797          	auipc	a5,0x1
 2a0:	d647b783          	ld	a5,-668(a5) # 1000 <current_thread>
 2a4:	470d                	li	a4,3
 2a6:	dfb8                	sw	a4,120(a5)
    tsched();
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <twhoami>:

uint8 twhoami()
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 2b4:	4501                	li	a0,0
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <tswtch>:
 2bc:	00153023          	sd	ra,0(a0)
 2c0:	00253423          	sd	sp,8(a0)
 2c4:	e900                	sd	s0,16(a0)
 2c6:	ed04                	sd	s1,24(a0)
 2c8:	03253023          	sd	s2,32(a0)
 2cc:	03353423          	sd	s3,40(a0)
 2d0:	03453823          	sd	s4,48(a0)
 2d4:	03553c23          	sd	s5,56(a0)
 2d8:	05653023          	sd	s6,64(a0)
 2dc:	05753423          	sd	s7,72(a0)
 2e0:	05853823          	sd	s8,80(a0)
 2e4:	05953c23          	sd	s9,88(a0)
 2e8:	07a53023          	sd	s10,96(a0)
 2ec:	07b53423          	sd	s11,104(a0)
 2f0:	0005b083          	ld	ra,0(a1)
 2f4:	0085b103          	ld	sp,8(a1)
 2f8:	6980                	ld	s0,16(a1)
 2fa:	6d84                	ld	s1,24(a1)
 2fc:	0205b903          	ld	s2,32(a1)
 300:	0285b983          	ld	s3,40(a1)
 304:	0305ba03          	ld	s4,48(a1)
 308:	0385ba83          	ld	s5,56(a1)
 30c:	0405bb03          	ld	s6,64(a1)
 310:	0485bb83          	ld	s7,72(a1)
 314:	0505bc03          	ld	s8,80(a1)
 318:	0585bc83          	ld	s9,88(a1)
 31c:	0605bd03          	ld	s10,96(a1)
 320:	0685bd83          	ld	s11,104(a1)
 324:	8082                	ret

0000000000000326 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 326:	1101                	addi	sp,sp,-32
 328:	ec06                	sd	ra,24(sp)
 32a:	e822                	sd	s0,16(sp)
 32c:	e426                	sd	s1,8(sp)
 32e:	e04a                	sd	s2,0(sp)
 330:	1000                	addi	s0,sp,32
 332:	84aa                	mv	s1,a0
 334:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 336:	09000513          	li	a0,144
 33a:	00000097          	auipc	ra,0x0
 33e:	6c4080e7          	jalr	1732(ra) # 9fe <malloc>

    main_thread->tid = 0;
 342:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 346:	85ca                	mv	a1,s2
 348:	8526                	mv	a0,s1
 34a:	00000097          	auipc	ra,0x0
 34e:	cb6080e7          	jalr	-842(ra) # 0 <main>
    exit(res);
 352:	00000097          	auipc	ra,0x0
 356:	274080e7          	jalr	628(ra) # 5c6 <exit>

000000000000035a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 35a:	1141                	addi	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 360:	87aa                	mv	a5,a0
 362:	0585                	addi	a1,a1,1
 364:	0785                	addi	a5,a5,1
 366:	fff5c703          	lbu	a4,-1(a1)
 36a:	fee78fa3          	sb	a4,-1(a5)
 36e:	fb75                	bnez	a4,362 <strcpy+0x8>
        ;
    return os;
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <strcmp>:

int strcmp(const char *p, const char *q)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 37c:	00054783          	lbu	a5,0(a0)
 380:	cb91                	beqz	a5,394 <strcmp+0x1e>
 382:	0005c703          	lbu	a4,0(a1)
 386:	00f71763          	bne	a4,a5,394 <strcmp+0x1e>
        p++, q++;
 38a:	0505                	addi	a0,a0,1
 38c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 38e:	00054783          	lbu	a5,0(a0)
 392:	fbe5                	bnez	a5,382 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 394:	0005c503          	lbu	a0,0(a1)
}
 398:	40a7853b          	subw	a0,a5,a0
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <strlen>:

uint strlen(const char *s)
{
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e422                	sd	s0,8(sp)
 3a6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	cf91                	beqz	a5,3c8 <strlen+0x26>
 3ae:	0505                	addi	a0,a0,1
 3b0:	87aa                	mv	a5,a0
 3b2:	86be                	mv	a3,a5
 3b4:	0785                	addi	a5,a5,1
 3b6:	fff7c703          	lbu	a4,-1(a5)
 3ba:	ff65                	bnez	a4,3b2 <strlen+0x10>
 3bc:	40a6853b          	subw	a0,a3,a0
 3c0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 3c2:	6422                	ld	s0,8(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret
    for (n = 0; s[n]; n++)
 3c8:	4501                	li	a0,0
 3ca:	bfe5                	j	3c2 <strlen+0x20>

00000000000003cc <memset>:

void *
memset(void *dst, int c, uint n)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e422                	sd	s0,8(sp)
 3d0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 3d2:	ca19                	beqz	a2,3e8 <memset+0x1c>
 3d4:	87aa                	mv	a5,a0
 3d6:	1602                	slli	a2,a2,0x20
 3d8:	9201                	srli	a2,a2,0x20
 3da:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 3de:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 3e2:	0785                	addi	a5,a5,1
 3e4:	fee79de3          	bne	a5,a4,3de <memset+0x12>
    }
    return dst;
}
 3e8:	6422                	ld	s0,8(sp)
 3ea:	0141                	addi	sp,sp,16
 3ec:	8082                	ret

00000000000003ee <strchr>:

char *
strchr(const char *s, char c)
{
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e422                	sd	s0,8(sp)
 3f2:	0800                	addi	s0,sp,16
    for (; *s; s++)
 3f4:	00054783          	lbu	a5,0(a0)
 3f8:	cb99                	beqz	a5,40e <strchr+0x20>
        if (*s == c)
 3fa:	00f58763          	beq	a1,a5,408 <strchr+0x1a>
    for (; *s; s++)
 3fe:	0505                	addi	a0,a0,1
 400:	00054783          	lbu	a5,0(a0)
 404:	fbfd                	bnez	a5,3fa <strchr+0xc>
            return (char *)s;
    return 0;
 406:	4501                	li	a0,0
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret
    return 0;
 40e:	4501                	li	a0,0
 410:	bfe5                	j	408 <strchr+0x1a>

0000000000000412 <gets>:

char *
gets(char *buf, int max)
{
 412:	711d                	addi	sp,sp,-96
 414:	ec86                	sd	ra,88(sp)
 416:	e8a2                	sd	s0,80(sp)
 418:	e4a6                	sd	s1,72(sp)
 41a:	e0ca                	sd	s2,64(sp)
 41c:	fc4e                	sd	s3,56(sp)
 41e:	f852                	sd	s4,48(sp)
 420:	f456                	sd	s5,40(sp)
 422:	f05a                	sd	s6,32(sp)
 424:	ec5e                	sd	s7,24(sp)
 426:	1080                	addi	s0,sp,96
 428:	8baa                	mv	s7,a0
 42a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 42c:	892a                	mv	s2,a0
 42e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 430:	4aa9                	li	s5,10
 432:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 434:	89a6                	mv	s3,s1
 436:	2485                	addiw	s1,s1,1
 438:	0344d863          	bge	s1,s4,468 <gets+0x56>
        cc = read(0, &c, 1);
 43c:	4605                	li	a2,1
 43e:	faf40593          	addi	a1,s0,-81
 442:	4501                	li	a0,0
 444:	00000097          	auipc	ra,0x0
 448:	19a080e7          	jalr	410(ra) # 5de <read>
        if (cc < 1)
 44c:	00a05e63          	blez	a0,468 <gets+0x56>
        buf[i++] = c;
 450:	faf44783          	lbu	a5,-81(s0)
 454:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 458:	01578763          	beq	a5,s5,466 <gets+0x54>
 45c:	0905                	addi	s2,s2,1
 45e:	fd679be3          	bne	a5,s6,434 <gets+0x22>
    for (i = 0; i + 1 < max;)
 462:	89a6                	mv	s3,s1
 464:	a011                	j	468 <gets+0x56>
 466:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 468:	99de                	add	s3,s3,s7
 46a:	00098023          	sb	zero,0(s3)
    return buf;
}
 46e:	855e                	mv	a0,s7
 470:	60e6                	ld	ra,88(sp)
 472:	6446                	ld	s0,80(sp)
 474:	64a6                	ld	s1,72(sp)
 476:	6906                	ld	s2,64(sp)
 478:	79e2                	ld	s3,56(sp)
 47a:	7a42                	ld	s4,48(sp)
 47c:	7aa2                	ld	s5,40(sp)
 47e:	7b02                	ld	s6,32(sp)
 480:	6be2                	ld	s7,24(sp)
 482:	6125                	addi	sp,sp,96
 484:	8082                	ret

0000000000000486 <stat>:

int stat(const char *n, struct stat *st)
{
 486:	1101                	addi	sp,sp,-32
 488:	ec06                	sd	ra,24(sp)
 48a:	e822                	sd	s0,16(sp)
 48c:	e426                	sd	s1,8(sp)
 48e:	e04a                	sd	s2,0(sp)
 490:	1000                	addi	s0,sp,32
 492:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 494:	4581                	li	a1,0
 496:	00000097          	auipc	ra,0x0
 49a:	170080e7          	jalr	368(ra) # 606 <open>
    if (fd < 0)
 49e:	02054563          	bltz	a0,4c8 <stat+0x42>
 4a2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 4a4:	85ca                	mv	a1,s2
 4a6:	00000097          	auipc	ra,0x0
 4aa:	178080e7          	jalr	376(ra) # 61e <fstat>
 4ae:	892a                	mv	s2,a0
    close(fd);
 4b0:	8526                	mv	a0,s1
 4b2:	00000097          	auipc	ra,0x0
 4b6:	13c080e7          	jalr	316(ra) # 5ee <close>
    return r;
}
 4ba:	854a                	mv	a0,s2
 4bc:	60e2                	ld	ra,24(sp)
 4be:	6442                	ld	s0,16(sp)
 4c0:	64a2                	ld	s1,8(sp)
 4c2:	6902                	ld	s2,0(sp)
 4c4:	6105                	addi	sp,sp,32
 4c6:	8082                	ret
        return -1;
 4c8:	597d                	li	s2,-1
 4ca:	bfc5                	j	4ba <stat+0x34>

00000000000004cc <atoi>:

int atoi(const char *s)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e422                	sd	s0,8(sp)
 4d0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4d2:	00054683          	lbu	a3,0(a0)
 4d6:	fd06879b          	addiw	a5,a3,-48
 4da:	0ff7f793          	zext.b	a5,a5
 4de:	4625                	li	a2,9
 4e0:	02f66863          	bltu	a2,a5,510 <atoi+0x44>
 4e4:	872a                	mv	a4,a0
    n = 0;
 4e6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4e8:	0705                	addi	a4,a4,1
 4ea:	0025179b          	slliw	a5,a0,0x2
 4ee:	9fa9                	addw	a5,a5,a0
 4f0:	0017979b          	slliw	a5,a5,0x1
 4f4:	9fb5                	addw	a5,a5,a3
 4f6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 4fa:	00074683          	lbu	a3,0(a4)
 4fe:	fd06879b          	addiw	a5,a3,-48
 502:	0ff7f793          	zext.b	a5,a5
 506:	fef671e3          	bgeu	a2,a5,4e8 <atoi+0x1c>
    return n;
}
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
    n = 0;
 510:	4501                	li	a0,0
 512:	bfe5                	j	50a <atoi+0x3e>

0000000000000514 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 51a:	02b57463          	bgeu	a0,a1,542 <memmove+0x2e>
    {
        while (n-- > 0)
 51e:	00c05f63          	blez	a2,53c <memmove+0x28>
 522:	1602                	slli	a2,a2,0x20
 524:	9201                	srli	a2,a2,0x20
 526:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 52a:	872a                	mv	a4,a0
            *dst++ = *src++;
 52c:	0585                	addi	a1,a1,1
 52e:	0705                	addi	a4,a4,1
 530:	fff5c683          	lbu	a3,-1(a1)
 534:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 538:	fee79ae3          	bne	a5,a4,52c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 53c:	6422                	ld	s0,8(sp)
 53e:	0141                	addi	sp,sp,16
 540:	8082                	ret
        dst += n;
 542:	00c50733          	add	a4,a0,a2
        src += n;
 546:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 548:	fec05ae3          	blez	a2,53c <memmove+0x28>
 54c:	fff6079b          	addiw	a5,a2,-1
 550:	1782                	slli	a5,a5,0x20
 552:	9381                	srli	a5,a5,0x20
 554:	fff7c793          	not	a5,a5
 558:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 55a:	15fd                	addi	a1,a1,-1
 55c:	177d                	addi	a4,a4,-1
 55e:	0005c683          	lbu	a3,0(a1)
 562:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 566:	fee79ae3          	bne	a5,a4,55a <memmove+0x46>
 56a:	bfc9                	j	53c <memmove+0x28>

000000000000056c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 56c:	1141                	addi	sp,sp,-16
 56e:	e422                	sd	s0,8(sp)
 570:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 572:	ca05                	beqz	a2,5a2 <memcmp+0x36>
 574:	fff6069b          	addiw	a3,a2,-1
 578:	1682                	slli	a3,a3,0x20
 57a:	9281                	srli	a3,a3,0x20
 57c:	0685                	addi	a3,a3,1
 57e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 580:	00054783          	lbu	a5,0(a0)
 584:	0005c703          	lbu	a4,0(a1)
 588:	00e79863          	bne	a5,a4,598 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 58c:	0505                	addi	a0,a0,1
        p2++;
 58e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 590:	fed518e3          	bne	a0,a3,580 <memcmp+0x14>
    }
    return 0;
 594:	4501                	li	a0,0
 596:	a019                	j	59c <memcmp+0x30>
            return *p1 - *p2;
 598:	40e7853b          	subw	a0,a5,a4
}
 59c:	6422                	ld	s0,8(sp)
 59e:	0141                	addi	sp,sp,16
 5a0:	8082                	ret
    return 0;
 5a2:	4501                	li	a0,0
 5a4:	bfe5                	j	59c <memcmp+0x30>

00000000000005a6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5a6:	1141                	addi	sp,sp,-16
 5a8:	e406                	sd	ra,8(sp)
 5aa:	e022                	sd	s0,0(sp)
 5ac:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 5ae:	00000097          	auipc	ra,0x0
 5b2:	f66080e7          	jalr	-154(ra) # 514 <memmove>
}
 5b6:	60a2                	ld	ra,8(sp)
 5b8:	6402                	ld	s0,0(sp)
 5ba:	0141                	addi	sp,sp,16
 5bc:	8082                	ret

00000000000005be <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5be:	4885                	li	a7,1
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5c6:	4889                	li	a7,2
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ce:	488d                	li	a7,3
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5d6:	4891                	li	a7,4
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <read>:
.global read
read:
 li a7, SYS_read
 5de:	4895                	li	a7,5
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <write>:
.global write
write:
 li a7, SYS_write
 5e6:	48c1                	li	a7,16
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <close>:
.global close
close:
 li a7, SYS_close
 5ee:	48d5                	li	a7,21
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5f6:	4899                	li	a7,6
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <exec>:
.global exec
exec:
 li a7, SYS_exec
 5fe:	489d                	li	a7,7
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <open>:
.global open
open:
 li a7, SYS_open
 606:	48bd                	li	a7,15
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 60e:	48c5                	li	a7,17
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 616:	48c9                	li	a7,18
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 61e:	48a1                	li	a7,8
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <link>:
.global link
link:
 li a7, SYS_link
 626:	48cd                	li	a7,19
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 62e:	48d1                	li	a7,20
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 636:	48a5                	li	a7,9
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <dup>:
.global dup
dup:
 li a7, SYS_dup
 63e:	48a9                	li	a7,10
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 646:	48ad                	li	a7,11
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 64e:	48b1                	li	a7,12
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 656:	48b5                	li	a7,13
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 65e:	48b9                	li	a7,14
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <ps>:
.global ps
ps:
 li a7, SYS_ps
 666:	48d9                	li	a7,22
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 66e:	48dd                	li	a7,23
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 676:	48e1                	li	a7,24
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 67e:	1101                	addi	sp,sp,-32
 680:	ec06                	sd	ra,24(sp)
 682:	e822                	sd	s0,16(sp)
 684:	1000                	addi	s0,sp,32
 686:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 68a:	4605                	li	a2,1
 68c:	fef40593          	addi	a1,s0,-17
 690:	00000097          	auipc	ra,0x0
 694:	f56080e7          	jalr	-170(ra) # 5e6 <write>
}
 698:	60e2                	ld	ra,24(sp)
 69a:	6442                	ld	s0,16(sp)
 69c:	6105                	addi	sp,sp,32
 69e:	8082                	ret

00000000000006a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6a0:	7139                	addi	sp,sp,-64
 6a2:	fc06                	sd	ra,56(sp)
 6a4:	f822                	sd	s0,48(sp)
 6a6:	f426                	sd	s1,40(sp)
 6a8:	f04a                	sd	s2,32(sp)
 6aa:	ec4e                	sd	s3,24(sp)
 6ac:	0080                	addi	s0,sp,64
 6ae:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6b0:	c299                	beqz	a3,6b6 <printint+0x16>
 6b2:	0805c963          	bltz	a1,744 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6b6:	2581                	sext.w	a1,a1
  neg = 0;
 6b8:	4881                	li	a7,0
 6ba:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6be:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6c0:	2601                	sext.w	a2,a2
 6c2:	00000517          	auipc	a0,0x0
 6c6:	51e50513          	addi	a0,a0,1310 # be0 <digits>
 6ca:	883a                	mv	a6,a4
 6cc:	2705                	addiw	a4,a4,1
 6ce:	02c5f7bb          	remuw	a5,a1,a2
 6d2:	1782                	slli	a5,a5,0x20
 6d4:	9381                	srli	a5,a5,0x20
 6d6:	97aa                	add	a5,a5,a0
 6d8:	0007c783          	lbu	a5,0(a5)
 6dc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6e0:	0005879b          	sext.w	a5,a1
 6e4:	02c5d5bb          	divuw	a1,a1,a2
 6e8:	0685                	addi	a3,a3,1
 6ea:	fec7f0e3          	bgeu	a5,a2,6ca <printint+0x2a>
  if(neg)
 6ee:	00088c63          	beqz	a7,706 <printint+0x66>
    buf[i++] = '-';
 6f2:	fd070793          	addi	a5,a4,-48
 6f6:	00878733          	add	a4,a5,s0
 6fa:	02d00793          	li	a5,45
 6fe:	fef70823          	sb	a5,-16(a4)
 702:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 706:	02e05863          	blez	a4,736 <printint+0x96>
 70a:	fc040793          	addi	a5,s0,-64
 70e:	00e78933          	add	s2,a5,a4
 712:	fff78993          	addi	s3,a5,-1
 716:	99ba                	add	s3,s3,a4
 718:	377d                	addiw	a4,a4,-1
 71a:	1702                	slli	a4,a4,0x20
 71c:	9301                	srli	a4,a4,0x20
 71e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 722:	fff94583          	lbu	a1,-1(s2)
 726:	8526                	mv	a0,s1
 728:	00000097          	auipc	ra,0x0
 72c:	f56080e7          	jalr	-170(ra) # 67e <putc>
  while(--i >= 0)
 730:	197d                	addi	s2,s2,-1
 732:	ff3918e3          	bne	s2,s3,722 <printint+0x82>
}
 736:	70e2                	ld	ra,56(sp)
 738:	7442                	ld	s0,48(sp)
 73a:	74a2                	ld	s1,40(sp)
 73c:	7902                	ld	s2,32(sp)
 73e:	69e2                	ld	s3,24(sp)
 740:	6121                	addi	sp,sp,64
 742:	8082                	ret
    x = -xx;
 744:	40b005bb          	negw	a1,a1
    neg = 1;
 748:	4885                	li	a7,1
    x = -xx;
 74a:	bf85                	j	6ba <printint+0x1a>

000000000000074c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 74c:	715d                	addi	sp,sp,-80
 74e:	e486                	sd	ra,72(sp)
 750:	e0a2                	sd	s0,64(sp)
 752:	fc26                	sd	s1,56(sp)
 754:	f84a                	sd	s2,48(sp)
 756:	f44e                	sd	s3,40(sp)
 758:	f052                	sd	s4,32(sp)
 75a:	ec56                	sd	s5,24(sp)
 75c:	e85a                	sd	s6,16(sp)
 75e:	e45e                	sd	s7,8(sp)
 760:	e062                	sd	s8,0(sp)
 762:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 764:	0005c903          	lbu	s2,0(a1)
 768:	18090c63          	beqz	s2,900 <vprintf+0x1b4>
 76c:	8aaa                	mv	s5,a0
 76e:	8bb2                	mv	s7,a2
 770:	00158493          	addi	s1,a1,1
  state = 0;
 774:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 776:	02500a13          	li	s4,37
 77a:	4b55                	li	s6,21
 77c:	a839                	j	79a <vprintf+0x4e>
        putc(fd, c);
 77e:	85ca                	mv	a1,s2
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	efc080e7          	jalr	-260(ra) # 67e <putc>
 78a:	a019                	j	790 <vprintf+0x44>
    } else if(state == '%'){
 78c:	01498d63          	beq	s3,s4,7a6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 790:	0485                	addi	s1,s1,1
 792:	fff4c903          	lbu	s2,-1(s1)
 796:	16090563          	beqz	s2,900 <vprintf+0x1b4>
    if(state == 0){
 79a:	fe0999e3          	bnez	s3,78c <vprintf+0x40>
      if(c == '%'){
 79e:	ff4910e3          	bne	s2,s4,77e <vprintf+0x32>
        state = '%';
 7a2:	89d2                	mv	s3,s4
 7a4:	b7f5                	j	790 <vprintf+0x44>
      if(c == 'd'){
 7a6:	13490263          	beq	s2,s4,8ca <vprintf+0x17e>
 7aa:	f9d9079b          	addiw	a5,s2,-99
 7ae:	0ff7f793          	zext.b	a5,a5
 7b2:	12fb6563          	bltu	s6,a5,8dc <vprintf+0x190>
 7b6:	f9d9079b          	addiw	a5,s2,-99
 7ba:	0ff7f713          	zext.b	a4,a5
 7be:	10eb6f63          	bltu	s6,a4,8dc <vprintf+0x190>
 7c2:	00271793          	slli	a5,a4,0x2
 7c6:	00000717          	auipc	a4,0x0
 7ca:	3c270713          	addi	a4,a4,962 # b88 <malloc+0x18a>
 7ce:	97ba                	add	a5,a5,a4
 7d0:	439c                	lw	a5,0(a5)
 7d2:	97ba                	add	a5,a5,a4
 7d4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7d6:	008b8913          	addi	s2,s7,8
 7da:	4685                	li	a3,1
 7dc:	4629                	li	a2,10
 7de:	000ba583          	lw	a1,0(s7)
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	ebc080e7          	jalr	-324(ra) # 6a0 <printint>
 7ec:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b745                	j	790 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f2:	008b8913          	addi	s2,s7,8
 7f6:	4681                	li	a3,0
 7f8:	4629                	li	a2,10
 7fa:	000ba583          	lw	a1,0(s7)
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	ea0080e7          	jalr	-352(ra) # 6a0 <printint>
 808:	8bca                	mv	s7,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b751                	j	790 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 80e:	008b8913          	addi	s2,s7,8
 812:	4681                	li	a3,0
 814:	4641                	li	a2,16
 816:	000ba583          	lw	a1,0(s7)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e84080e7          	jalr	-380(ra) # 6a0 <printint>
 824:	8bca                	mv	s7,s2
      state = 0;
 826:	4981                	li	s3,0
 828:	b7a5                	j	790 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 82a:	008b8c13          	addi	s8,s7,8
 82e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 832:	03000593          	li	a1,48
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	e46080e7          	jalr	-442(ra) # 67e <putc>
  putc(fd, 'x');
 840:	07800593          	li	a1,120
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	e38080e7          	jalr	-456(ra) # 67e <putc>
 84e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 850:	00000b97          	auipc	s7,0x0
 854:	390b8b93          	addi	s7,s7,912 # be0 <digits>
 858:	03c9d793          	srli	a5,s3,0x3c
 85c:	97de                	add	a5,a5,s7
 85e:	0007c583          	lbu	a1,0(a5)
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	e1a080e7          	jalr	-486(ra) # 67e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86c:	0992                	slli	s3,s3,0x4
 86e:	397d                	addiw	s2,s2,-1
 870:	fe0914e3          	bnez	s2,858 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 874:	8be2                	mv	s7,s8
      state = 0;
 876:	4981                	li	s3,0
 878:	bf21                	j	790 <vprintf+0x44>
        s = va_arg(ap, char*);
 87a:	008b8993          	addi	s3,s7,8
 87e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 882:	02090163          	beqz	s2,8a4 <vprintf+0x158>
        while(*s != 0){
 886:	00094583          	lbu	a1,0(s2)
 88a:	c9a5                	beqz	a1,8fa <vprintf+0x1ae>
          putc(fd, *s);
 88c:	8556                	mv	a0,s5
 88e:	00000097          	auipc	ra,0x0
 892:	df0080e7          	jalr	-528(ra) # 67e <putc>
          s++;
 896:	0905                	addi	s2,s2,1
        while(*s != 0){
 898:	00094583          	lbu	a1,0(s2)
 89c:	f9e5                	bnez	a1,88c <vprintf+0x140>
        s = va_arg(ap, char*);
 89e:	8bce                	mv	s7,s3
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	b5fd                	j	790 <vprintf+0x44>
          s = "(null)";
 8a4:	00000917          	auipc	s2,0x0
 8a8:	2dc90913          	addi	s2,s2,732 # b80 <malloc+0x182>
        while(*s != 0){
 8ac:	02800593          	li	a1,40
 8b0:	bff1                	j	88c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 8b2:	008b8913          	addi	s2,s7,8
 8b6:	000bc583          	lbu	a1,0(s7)
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	dc2080e7          	jalr	-574(ra) # 67e <putc>
 8c4:	8bca                	mv	s7,s2
      state = 0;
 8c6:	4981                	li	s3,0
 8c8:	b5e1                	j	790 <vprintf+0x44>
        putc(fd, c);
 8ca:	02500593          	li	a1,37
 8ce:	8556                	mv	a0,s5
 8d0:	00000097          	auipc	ra,0x0
 8d4:	dae080e7          	jalr	-594(ra) # 67e <putc>
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	bd5d                	j	790 <vprintf+0x44>
        putc(fd, '%');
 8dc:	02500593          	li	a1,37
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	d9c080e7          	jalr	-612(ra) # 67e <putc>
        putc(fd, c);
 8ea:	85ca                	mv	a1,s2
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	d90080e7          	jalr	-624(ra) # 67e <putc>
      state = 0;
 8f6:	4981                	li	s3,0
 8f8:	bd61                	j	790 <vprintf+0x44>
        s = va_arg(ap, char*);
 8fa:	8bce                	mv	s7,s3
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	bd49                	j	790 <vprintf+0x44>
    }
  }
}
 900:	60a6                	ld	ra,72(sp)
 902:	6406                	ld	s0,64(sp)
 904:	74e2                	ld	s1,56(sp)
 906:	7942                	ld	s2,48(sp)
 908:	79a2                	ld	s3,40(sp)
 90a:	7a02                	ld	s4,32(sp)
 90c:	6ae2                	ld	s5,24(sp)
 90e:	6b42                	ld	s6,16(sp)
 910:	6ba2                	ld	s7,8(sp)
 912:	6c02                	ld	s8,0(sp)
 914:	6161                	addi	sp,sp,80
 916:	8082                	ret

0000000000000918 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 918:	715d                	addi	sp,sp,-80
 91a:	ec06                	sd	ra,24(sp)
 91c:	e822                	sd	s0,16(sp)
 91e:	1000                	addi	s0,sp,32
 920:	e010                	sd	a2,0(s0)
 922:	e414                	sd	a3,8(s0)
 924:	e818                	sd	a4,16(s0)
 926:	ec1c                	sd	a5,24(s0)
 928:	03043023          	sd	a6,32(s0)
 92c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 930:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 934:	8622                	mv	a2,s0
 936:	00000097          	auipc	ra,0x0
 93a:	e16080e7          	jalr	-490(ra) # 74c <vprintf>
}
 93e:	60e2                	ld	ra,24(sp)
 940:	6442                	ld	s0,16(sp)
 942:	6161                	addi	sp,sp,80
 944:	8082                	ret

0000000000000946 <printf>:

void
printf(const char *fmt, ...)
{
 946:	711d                	addi	sp,sp,-96
 948:	ec06                	sd	ra,24(sp)
 94a:	e822                	sd	s0,16(sp)
 94c:	1000                	addi	s0,sp,32
 94e:	e40c                	sd	a1,8(s0)
 950:	e810                	sd	a2,16(s0)
 952:	ec14                	sd	a3,24(s0)
 954:	f018                	sd	a4,32(s0)
 956:	f41c                	sd	a5,40(s0)
 958:	03043823          	sd	a6,48(s0)
 95c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 960:	00840613          	addi	a2,s0,8
 964:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 968:	85aa                	mv	a1,a0
 96a:	4505                	li	a0,1
 96c:	00000097          	auipc	ra,0x0
 970:	de0080e7          	jalr	-544(ra) # 74c <vprintf>
}
 974:	60e2                	ld	ra,24(sp)
 976:	6442                	ld	s0,16(sp)
 978:	6125                	addi	sp,sp,96
 97a:	8082                	ret

000000000000097c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 97c:	1141                	addi	sp,sp,-16
 97e:	e422                	sd	s0,8(sp)
 980:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 982:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 986:	00000797          	auipc	a5,0x0
 98a:	6827b783          	ld	a5,1666(a5) # 1008 <freep>
 98e:	a02d                	j	9b8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 990:	4618                	lw	a4,8(a2)
 992:	9f2d                	addw	a4,a4,a1
 994:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 998:	6398                	ld	a4,0(a5)
 99a:	6310                	ld	a2,0(a4)
 99c:	a83d                	j	9da <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 99e:	ff852703          	lw	a4,-8(a0)
 9a2:	9f31                	addw	a4,a4,a2
 9a4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 9a6:	ff053683          	ld	a3,-16(a0)
 9aa:	a091                	j	9ee <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ac:	6398                	ld	a4,0(a5)
 9ae:	00e7e463          	bltu	a5,a4,9b6 <free+0x3a>
 9b2:	00e6ea63          	bltu	a3,a4,9c6 <free+0x4a>
{
 9b6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b8:	fed7fae3          	bgeu	a5,a3,9ac <free+0x30>
 9bc:	6398                	ld	a4,0(a5)
 9be:	00e6e463          	bltu	a3,a4,9c6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c2:	fee7eae3          	bltu	a5,a4,9b6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 9c6:	ff852583          	lw	a1,-8(a0)
 9ca:	6390                	ld	a2,0(a5)
 9cc:	02059813          	slli	a6,a1,0x20
 9d0:	01c85713          	srli	a4,a6,0x1c
 9d4:	9736                	add	a4,a4,a3
 9d6:	fae60de3          	beq	a2,a4,990 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9da:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 9de:	4790                	lw	a2,8(a5)
 9e0:	02061593          	slli	a1,a2,0x20
 9e4:	01c5d713          	srli	a4,a1,0x1c
 9e8:	973e                	add	a4,a4,a5
 9ea:	fae68ae3          	beq	a3,a4,99e <free+0x22>
        p->s.ptr = bp->s.ptr;
 9ee:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 9f0:	00000717          	auipc	a4,0x0
 9f4:	60f73c23          	sd	a5,1560(a4) # 1008 <freep>
}
 9f8:	6422                	ld	s0,8(sp)
 9fa:	0141                	addi	sp,sp,16
 9fc:	8082                	ret

00000000000009fe <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 9fe:	7139                	addi	sp,sp,-64
 a00:	fc06                	sd	ra,56(sp)
 a02:	f822                	sd	s0,48(sp)
 a04:	f426                	sd	s1,40(sp)
 a06:	f04a                	sd	s2,32(sp)
 a08:	ec4e                	sd	s3,24(sp)
 a0a:	e852                	sd	s4,16(sp)
 a0c:	e456                	sd	s5,8(sp)
 a0e:	e05a                	sd	s6,0(sp)
 a10:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 a12:	02051493          	slli	s1,a0,0x20
 a16:	9081                	srli	s1,s1,0x20
 a18:	04bd                	addi	s1,s1,15
 a1a:	8091                	srli	s1,s1,0x4
 a1c:	0014899b          	addiw	s3,s1,1
 a20:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 a22:	00000517          	auipc	a0,0x0
 a26:	5e653503          	ld	a0,1510(a0) # 1008 <freep>
 a2a:	c515                	beqz	a0,a56 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a2c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 a2e:	4798                	lw	a4,8(a5)
 a30:	02977f63          	bgeu	a4,s1,a6e <malloc+0x70>
    if (nu < 4096)
 a34:	8a4e                	mv	s4,s3
 a36:	0009871b          	sext.w	a4,s3
 a3a:	6685                	lui	a3,0x1
 a3c:	00d77363          	bgeu	a4,a3,a42 <malloc+0x44>
 a40:	6a05                	lui	s4,0x1
 a42:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a46:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a4a:	00000917          	auipc	s2,0x0
 a4e:	5be90913          	addi	s2,s2,1470 # 1008 <freep>
    if (p == (char *)-1)
 a52:	5afd                	li	s5,-1
 a54:	a895                	j	ac8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 a56:	00000797          	auipc	a5,0x0
 a5a:	5ba78793          	addi	a5,a5,1466 # 1010 <base>
 a5e:	00000717          	auipc	a4,0x0
 a62:	5af73523          	sd	a5,1450(a4) # 1008 <freep>
 a66:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a68:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a6c:	b7e1                	j	a34 <malloc+0x36>
            if (p->s.size == nunits)
 a6e:	02e48c63          	beq	s1,a4,aa6 <malloc+0xa8>
                p->s.size -= nunits;
 a72:	4137073b          	subw	a4,a4,s3
 a76:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a78:	02071693          	slli	a3,a4,0x20
 a7c:	01c6d713          	srli	a4,a3,0x1c
 a80:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a82:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a86:	00000717          	auipc	a4,0x0
 a8a:	58a73123          	sd	a0,1410(a4) # 1008 <freep>
            return (void *)(p + 1);
 a8e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 a92:	70e2                	ld	ra,56(sp)
 a94:	7442                	ld	s0,48(sp)
 a96:	74a2                	ld	s1,40(sp)
 a98:	7902                	ld	s2,32(sp)
 a9a:	69e2                	ld	s3,24(sp)
 a9c:	6a42                	ld	s4,16(sp)
 a9e:	6aa2                	ld	s5,8(sp)
 aa0:	6b02                	ld	s6,0(sp)
 aa2:	6121                	addi	sp,sp,64
 aa4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 aa6:	6398                	ld	a4,0(a5)
 aa8:	e118                	sd	a4,0(a0)
 aaa:	bff1                	j	a86 <malloc+0x88>
    hp->s.size = nu;
 aac:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 ab0:	0541                	addi	a0,a0,16
 ab2:	00000097          	auipc	ra,0x0
 ab6:	eca080e7          	jalr	-310(ra) # 97c <free>
    return freep;
 aba:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 abe:	d971                	beqz	a0,a92 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ac0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ac2:	4798                	lw	a4,8(a5)
 ac4:	fa9775e3          	bgeu	a4,s1,a6e <malloc+0x70>
        if (p == freep)
 ac8:	00093703          	ld	a4,0(s2)
 acc:	853e                	mv	a0,a5
 ace:	fef719e3          	bne	a4,a5,ac0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ad2:	8552                	mv	a0,s4
 ad4:	00000097          	auipc	ra,0x0
 ad8:	b7a080e7          	jalr	-1158(ra) # 64e <sbrk>
    if (p == (char *)-1)
 adc:	fd5518e3          	bne	a0,s5,aac <malloc+0xae>
                return 0;
 ae0:	4501                	li	a0,0
 ae2:	bf45                	j	a92 <malloc+0x94>
