
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
    }
    exit(0);
}

int getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
    write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	77e58593          	addi	a1,a1,1918 # 1790 <malloc+0xe6>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	276080e7          	jalr	630(ra) # 1292 <write>
    memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	04e080e7          	jalr	78(ra) # 1078 <memset>
    gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	088080e7          	jalr	136(ra) # 10be <gets>
    if (buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
      42:	00153513          	seqz	a0,a0
        return -1;
    return 0;
}
      46:	40a00533          	neg	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
    }
    exit(0);
}

void panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
      5e:	862a                	mv	a2,a0
    fprintf(2, "%s\n", s);
      60:	00001597          	auipc	a1,0x1
      64:	73858593          	addi	a1,a1,1848 # 1798 <malloc+0xee>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	55a080e7          	jalr	1370(ra) # 15c4 <fprintf>
    exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	1fe080e7          	jalr	510(ra) # 1272 <exit>

000000000000007c <fork1>:
}

int fork1(void)
{
      7c:	1141                	addi	sp,sp,-16
      7e:	e406                	sd	ra,8(sp)
      80:	e022                	sd	s0,0(sp)
      82:	0800                	addi	s0,sp,16
    int pid;

    pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	1e6080e7          	jalr	486(ra) # 126a <fork>
    if (pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
        panic("fork");
    return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	addi	sp,sp,16
      98:	8082                	ret
        panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	70650513          	addi	a0,a0,1798 # 17a0 <malloc+0xf6>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f406                	sd	ra,40(sp)
      ae:	f022                	sd	s0,32(sp)
      b0:	ec26                	sd	s1,24(sp)
      b2:	1800                	addi	s0,sp,48
    if (cmd == 0)
      b4:	c10d                	beqz	a0,d6 <runcmd+0x2c>
      b6:	84aa                	mv	s1,a0
    switch (cmd->type)
      b8:	4118                	lw	a4,0(a0)
      ba:	4795                	li	a5,5
      bc:	02e7e263          	bltu	a5,a4,e0 <runcmd+0x36>
      c0:	00056783          	lwu	a5,0(a0)
      c4:	078a                	slli	a5,a5,0x2
      c6:	00001717          	auipc	a4,0x1
      ca:	7ee70713          	addi	a4,a4,2030 # 18b4 <malloc+0x20a>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
        exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	19a080e7          	jalr	410(ra) # 1272 <exit>
        panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	6c850513          	addi	a0,a0,1736 # 17a8 <malloc+0xfe>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
        if (ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
        exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	1b2080e7          	jalr	434(ra) # 12aa <exec>
        fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	6ae58593          	addi	a1,a1,1710 # 17b0 <malloc+0x106>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	4b8080e7          	jalr	1208(ra) # 15c4 <fprintf>
    exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	15c080e7          	jalr	348(ra) # 1272 <exit>
            exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	152080e7          	jalr	338(ra) # 1272 <exit>
        close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	170080e7          	jalr	368(ra) # 129a <close>
        if (open(rcmd->file, rcmd->mode) < 0)
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	17c080e7          	jalr	380(ra) # 12b2 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
        runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
            fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	67258593          	addi	a1,a1,1650 # 17c0 <malloc+0x116>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	46c080e7          	jalr	1132(ra) # 15c4 <fprintf>
            exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	110080e7          	jalr	272(ra) # 1272 <exit>
        if (fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f12080e7          	jalr	-238(ra) # 7c <fork1>
     172:	e511                	bnez	a0,17e <runcmd+0xd4>
            runcmd(lcmd->left);
     174:	6488                	ld	a0,8(s1)
     176:	00000097          	auipc	ra,0x0
     17a:	f34080e7          	jalr	-204(ra) # aa <runcmd>
        wait(0);
     17e:	4501                	li	a0,0
     180:	00001097          	auipc	ra,0x1
     184:	0fa080e7          	jalr	250(ra) # 127a <wait>
        runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
        if (pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	0ec080e7          	jalr	236(ra) # 1282 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
        if (fork1() == 0)
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	e529                	bnez	a0,1f4 <runcmd+0x14a>
            close(1);
     1ac:	4505                	li	a0,1
     1ae:	00001097          	auipc	ra,0x1
     1b2:	0ec080e7          	jalr	236(ra) # 129a <close>
            dup(p[1]);
     1b6:	fdc42503          	lw	a0,-36(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	130080e7          	jalr	304(ra) # 12ea <dup>
            close(p[0]);
     1c2:	fd842503          	lw	a0,-40(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	0d4080e7          	jalr	212(ra) # 129a <close>
            close(p[1]);
     1ce:	fdc42503          	lw	a0,-36(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	0c8080e7          	jalr	200(ra) # 129a <close>
            runcmd(pcmd->left);
     1da:	6488                	ld	a0,8(s1)
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ece080e7          	jalr	-306(ra) # aa <runcmd>
            panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	5ec50513          	addi	a0,a0,1516 # 17d0 <malloc+0x126>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
        if (fork1() == 0)
     1f4:	00000097          	auipc	ra,0x0
     1f8:	e88080e7          	jalr	-376(ra) # 7c <fork1>
     1fc:	ed05                	bnez	a0,234 <runcmd+0x18a>
            close(0);
     1fe:	00001097          	auipc	ra,0x1
     202:	09c080e7          	jalr	156(ra) # 129a <close>
            dup(p[0]);
     206:	fd842503          	lw	a0,-40(s0)
     20a:	00001097          	auipc	ra,0x1
     20e:	0e0080e7          	jalr	224(ra) # 12ea <dup>
            close(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	084080e7          	jalr	132(ra) # 129a <close>
            close(p[1]);
     21e:	fdc42503          	lw	a0,-36(s0)
     222:	00001097          	auipc	ra,0x1
     226:	078080e7          	jalr	120(ra) # 129a <close>
            runcmd(pcmd->right);
     22a:	6888                	ld	a0,16(s1)
     22c:	00000097          	auipc	ra,0x0
     230:	e7e080e7          	jalr	-386(ra) # aa <runcmd>
        close(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	062080e7          	jalr	98(ra) # 129a <close>
        close(p[1]);
     240:	fdc42503          	lw	a0,-36(s0)
     244:	00001097          	auipc	ra,0x1
     248:	056080e7          	jalr	86(ra) # 129a <close>
        wait(0);
     24c:	4501                	li	a0,0
     24e:	00001097          	auipc	ra,0x1
     252:	02c080e7          	jalr	44(ra) # 127a <wait>
        wait(0);
     256:	4501                	li	a0,0
     258:	00001097          	auipc	ra,0x1
     25c:	022080e7          	jalr	34(ra) # 127a <wait>
        break;
     260:	bd55                	j	114 <runcmd+0x6a>
        if (fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e1a080e7          	jalr	-486(ra) # 7c <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6a>
            runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e3a080e7          	jalr	-454(ra) # aa <runcmd>

0000000000000278 <execcmd>:
// PAGEBREAK!
//  Constructors

struct cmd *
execcmd(void)
{
     278:	1101                	addi	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	addi	s0,sp,32
    struct execcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	424080e7          	jalr	1060(ra) # 16aa <malloc>
     28e:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	de2080e7          	jalr	-542(ra) # 1078 <memset>
    cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
    return (struct cmd *)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd *
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	addi	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	addi	s0,sp,64
     2c2:	8b2a                	mv	s6,a0
     2c4:	8aae                	mv	s5,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	89b6                	mv	s3,a3
     2ca:	893a                	mv	s2,a4
    struct redircmd *cmd;

    cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	3da080e7          	jalr	986(ra) # 16aa <malloc>
     2d8:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	d98080e7          	jalr	-616(ra) # 1078 <memset>
    cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
    cmd->cmd = subcmd;
     2ec:	0164b423          	sd	s6,8(s1)
    cmd->file = file;
     2f0:	0154b823          	sd	s5,16(s1)
    cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
    cmd->mode = mode;
     2f8:	0334a023          	sw	s3,32(s1)
    cmd->fd = fd;
     2fc:	0324a223          	sw	s2,36(s1)
    return (struct cmd *)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	addi	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd *
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	addi	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	addi	s0,sp,48
     324:	89aa                	mv	s3,a0
     326:	892e                	mv	s2,a1
    struct pipecmd *cmd;

    cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	380080e7          	jalr	896(ra) # 16aa <malloc>
     332:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	d40080e7          	jalr	-704(ra) # 1078 <memset>
    cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
    cmd->left = left;
     344:	0134b423          	sd	s3,8(s1)
    cmd->right = right;
     348:	0124b823          	sd	s2,16(s1)
    return (struct cmd *)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	addi	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd *
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	addi	s0,sp,48
     36a:	89aa                	mv	s3,a0
     36c:	892e                	mv	s2,a1
    struct listcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	33a080e7          	jalr	826(ra) # 16aa <malloc>
     378:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	cfa080e7          	jalr	-774(ra) # 1078 <memset>
    cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
    cmd->left = left;
     38a:	0134b423          	sd	s3,8(s1)
    cmd->right = right;
     38e:	0124b823          	sd	s2,16(s1)
    return (struct cmd *)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd *
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	892a                	mv	s2,a0
    struct backcmd *cmd;

    cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	2f8080e7          	jalr	760(ra) # 16aa <malloc>
     3ba:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	cb8080e7          	jalr	-840(ra) # 1078 <memset>
    cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
    cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
    return (struct cmd *)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	addi	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	addi	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
    char *s;
    int ret;

    s = *ps;
     3fa:	6104                	ld	s1,0(a0)
    while (s < es && strchr(whitespace, *s))
     3fc:	00002997          	auipc	s3,0x2
     400:	c0c98993          	addi	s3,s3,-1012 # 2008 <whitespace>
     404:	00b4fe63          	bgeu	s1,a1,420 <gettoken+0x42>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00001097          	auipc	ra,0x1
     412:	c8c080e7          	jalr	-884(ra) # 109a <strchr>
     416:	c509                	beqz	a0,420 <gettoken+0x42>
        s++;
     418:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
        s++;
     41e:	84ca                	mv	s1,s2
    if (q)
     420:	000a8463          	beqz	s5,428 <gettoken+0x4a>
        *q = s;
     424:	009ab023          	sd	s1,0(s5)
    ret = *s;
     428:	0004c783          	lbu	a5,0(s1)
     42c:	00078a9b          	sext.w	s5,a5
    switch (*s)
     430:	03c00713          	li	a4,60
     434:	06f76663          	bltu	a4,a5,4a0 <gettoken+0xc2>
     438:	03a00713          	li	a4,58
     43c:	00f76e63          	bltu	a4,a5,458 <gettoken+0x7a>
     440:	cf89                	beqz	a5,45a <gettoken+0x7c>
     442:	02600713          	li	a4,38
     446:	00e78963          	beq	a5,a4,458 <gettoken+0x7a>
     44a:	fd87879b          	addiw	a5,a5,-40
     44e:	0ff7f793          	zext.b	a5,a5
     452:	4705                	li	a4,1
     454:	06f76d63          	bltu	a4,a5,4ce <gettoken+0xf0>
    case '(':
    case ')':
    case ';':
    case '&':
    case '<':
        s++;
     458:	0485                	addi	s1,s1,1
        ret = 'a';
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
            s++;
        break;
    }
    if (eq)
     45a:	000b0463          	beqz	s6,462 <gettoken+0x84>
        *eq = s;
     45e:	009b3023          	sd	s1,0(s6)

    while (s < es && strchr(whitespace, *s))
     462:	00002997          	auipc	s3,0x2
     466:	ba698993          	addi	s3,s3,-1114 # 2008 <whitespace>
     46a:	0124fe63          	bgeu	s1,s2,486 <gettoken+0xa8>
     46e:	0004c583          	lbu	a1,0(s1)
     472:	854e                	mv	a0,s3
     474:	00001097          	auipc	ra,0x1
     478:	c26080e7          	jalr	-986(ra) # 109a <strchr>
     47c:	c509                	beqz	a0,486 <gettoken+0xa8>
        s++;
     47e:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     480:	fe9917e3          	bne	s2,s1,46e <gettoken+0x90>
        s++;
     484:	84ca                	mv	s1,s2
    *ps = s;
     486:	009a3023          	sd	s1,0(s4)
    return ret;
}
     48a:	8556                	mv	a0,s5
     48c:	70e2                	ld	ra,56(sp)
     48e:	7442                	ld	s0,48(sp)
     490:	74a2                	ld	s1,40(sp)
     492:	7902                	ld	s2,32(sp)
     494:	69e2                	ld	s3,24(sp)
     496:	6a42                	ld	s4,16(sp)
     498:	6aa2                	ld	s5,8(sp)
     49a:	6b02                	ld	s6,0(sp)
     49c:	6121                	addi	sp,sp,64
     49e:	8082                	ret
    switch (*s)
     4a0:	03e00713          	li	a4,62
     4a4:	02e79163          	bne	a5,a4,4c6 <gettoken+0xe8>
        s++;
     4a8:	00148693          	addi	a3,s1,1
        if (*s == '>')
     4ac:	0014c703          	lbu	a4,1(s1)
     4b0:	03e00793          	li	a5,62
            s++;
     4b4:	0489                	addi	s1,s1,2
            ret = '+';
     4b6:	02b00a93          	li	s5,43
        if (*s == '>')
     4ba:	faf700e3          	beq	a4,a5,45a <gettoken+0x7c>
        s++;
     4be:	84b6                	mv	s1,a3
    ret = *s;
     4c0:	03e00a93          	li	s5,62
     4c4:	bf59                	j	45a <gettoken+0x7c>
    switch (*s)
     4c6:	07c00713          	li	a4,124
     4ca:	f8e787e3          	beq	a5,a4,458 <gettoken+0x7a>
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ce:	00002997          	auipc	s3,0x2
     4d2:	b3a98993          	addi	s3,s3,-1222 # 2008 <whitespace>
     4d6:	00002a97          	auipc	s5,0x2
     4da:	b2aa8a93          	addi	s5,s5,-1238 # 2000 <symbols>
     4de:	0524f163          	bgeu	s1,s2,520 <gettoken+0x142>
     4e2:	0004c583          	lbu	a1,0(s1)
     4e6:	854e                	mv	a0,s3
     4e8:	00001097          	auipc	ra,0x1
     4ec:	bb2080e7          	jalr	-1102(ra) # 109a <strchr>
     4f0:	e50d                	bnez	a0,51a <gettoken+0x13c>
     4f2:	0004c583          	lbu	a1,0(s1)
     4f6:	8556                	mv	a0,s5
     4f8:	00001097          	auipc	ra,0x1
     4fc:	ba2080e7          	jalr	-1118(ra) # 109a <strchr>
     500:	e911                	bnez	a0,514 <gettoken+0x136>
            s++;
     502:	0485                	addi	s1,s1,1
        while (s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     504:	fc991fe3          	bne	s2,s1,4e2 <gettoken+0x104>
            s++;
     508:	84ca                	mv	s1,s2
        ret = 'a';
     50a:	06100a93          	li	s5,97
    if (eq)
     50e:	f40b18e3          	bnez	s6,45e <gettoken+0x80>
     512:	bf95                	j	486 <gettoken+0xa8>
        ret = 'a';
     514:	06100a93          	li	s5,97
     518:	b789                	j	45a <gettoken+0x7c>
     51a:	06100a93          	li	s5,97
     51e:	bf35                	j	45a <gettoken+0x7c>
     520:	06100a93          	li	s5,97
    if (eq)
     524:	f20b1de3          	bnez	s6,45e <gettoken+0x80>
     528:	bfb9                	j	486 <gettoken+0xa8>

000000000000052a <peek>:

int peek(char **ps, char *es, char *toks)
{
     52a:	7139                	addi	sp,sp,-64
     52c:	fc06                	sd	ra,56(sp)
     52e:	f822                	sd	s0,48(sp)
     530:	f426                	sd	s1,40(sp)
     532:	f04a                	sd	s2,32(sp)
     534:	ec4e                	sd	s3,24(sp)
     536:	e852                	sd	s4,16(sp)
     538:	e456                	sd	s5,8(sp)
     53a:	0080                	addi	s0,sp,64
     53c:	8a2a                	mv	s4,a0
     53e:	892e                	mv	s2,a1
     540:	8ab2                	mv	s5,a2
    char *s;

    s = *ps;
     542:	6104                	ld	s1,0(a0)
    while (s < es && strchr(whitespace, *s))
     544:	00002997          	auipc	s3,0x2
     548:	ac498993          	addi	s3,s3,-1340 # 2008 <whitespace>
     54c:	00b4fe63          	bgeu	s1,a1,568 <peek+0x3e>
     550:	0004c583          	lbu	a1,0(s1)
     554:	854e                	mv	a0,s3
     556:	00001097          	auipc	ra,0x1
     55a:	b44080e7          	jalr	-1212(ra) # 109a <strchr>
     55e:	c509                	beqz	a0,568 <peek+0x3e>
        s++;
     560:	0485                	addi	s1,s1,1
    while (s < es && strchr(whitespace, *s))
     562:	fe9917e3          	bne	s2,s1,550 <peek+0x26>
        s++;
     566:	84ca                	mv	s1,s2
    *ps = s;
     568:	009a3023          	sd	s1,0(s4)
    return *s && strchr(toks, *s);
     56c:	0004c583          	lbu	a1,0(s1)
     570:	4501                	li	a0,0
     572:	e991                	bnez	a1,586 <peek+0x5c>
}
     574:	70e2                	ld	ra,56(sp)
     576:	7442                	ld	s0,48(sp)
     578:	74a2                	ld	s1,40(sp)
     57a:	7902                	ld	s2,32(sp)
     57c:	69e2                	ld	s3,24(sp)
     57e:	6a42                	ld	s4,16(sp)
     580:	6aa2                	ld	s5,8(sp)
     582:	6121                	addi	sp,sp,64
     584:	8082                	ret
    return *s && strchr(toks, *s);
     586:	8556                	mv	a0,s5
     588:	00001097          	auipc	ra,0x1
     58c:	b12080e7          	jalr	-1262(ra) # 109a <strchr>
     590:	00a03533          	snez	a0,a0
     594:	b7c5                	j	574 <peek+0x4a>

0000000000000596 <parseredirs>:
    return cmd;
}

struct cmd *
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     596:	7159                	addi	sp,sp,-112
     598:	f486                	sd	ra,104(sp)
     59a:	f0a2                	sd	s0,96(sp)
     59c:	eca6                	sd	s1,88(sp)
     59e:	e8ca                	sd	s2,80(sp)
     5a0:	e4ce                	sd	s3,72(sp)
     5a2:	e0d2                	sd	s4,64(sp)
     5a4:	fc56                	sd	s5,56(sp)
     5a6:	f85a                	sd	s6,48(sp)
     5a8:	f45e                	sd	s7,40(sp)
     5aa:	f062                	sd	s8,32(sp)
     5ac:	ec66                	sd	s9,24(sp)
     5ae:	1880                	addi	s0,sp,112
     5b0:	8a2a                	mv	s4,a0
     5b2:	89ae                	mv	s3,a1
     5b4:	8932                	mv	s2,a2
    int tok;
    char *q, *eq;

    while (peek(ps, es, "<>"))
     5b6:	00001b97          	auipc	s7,0x1
     5ba:	242b8b93          	addi	s7,s7,578 # 17f8 <malloc+0x14e>
    {
        tok = gettoken(ps, es, 0, 0);
        if (gettoken(ps, es, &q, &eq) != 'a')
     5be:	06100c13          	li	s8,97
            panic("missing file for redirection");
        switch (tok)
     5c2:	03c00c93          	li	s9,60
    while (peek(ps, es, "<>"))
     5c6:	a02d                	j	5f0 <parseredirs+0x5a>
            panic("missing file for redirection");
     5c8:	00001517          	auipc	a0,0x1
     5cc:	21050513          	addi	a0,a0,528 # 17d8 <malloc+0x12e>
     5d0:	00000097          	auipc	ra,0x0
     5d4:	a86080e7          	jalr	-1402(ra) # 56 <panic>
        {
        case '<':
            cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d8:	4701                	li	a4,0
     5da:	4681                	li	a3,0
     5dc:	f9043603          	ld	a2,-112(s0)
     5e0:	f9843583          	ld	a1,-104(s0)
     5e4:	8552                	mv	a0,s4
     5e6:	00000097          	auipc	ra,0x0
     5ea:	cc8080e7          	jalr	-824(ra) # 2ae <redircmd>
     5ee:	8a2a                	mv	s4,a0
        switch (tok)
     5f0:	03e00b13          	li	s6,62
     5f4:	02b00a93          	li	s5,43
    while (peek(ps, es, "<>"))
     5f8:	865e                	mv	a2,s7
     5fa:	85ca                	mv	a1,s2
     5fc:	854e                	mv	a0,s3
     5fe:	00000097          	auipc	ra,0x0
     602:	f2c080e7          	jalr	-212(ra) # 52a <peek>
     606:	c925                	beqz	a0,676 <parseredirs+0xe0>
        tok = gettoken(ps, es, 0, 0);
     608:	4681                	li	a3,0
     60a:	4601                	li	a2,0
     60c:	85ca                	mv	a1,s2
     60e:	854e                	mv	a0,s3
     610:	00000097          	auipc	ra,0x0
     614:	dce080e7          	jalr	-562(ra) # 3de <gettoken>
     618:	84aa                	mv	s1,a0
        if (gettoken(ps, es, &q, &eq) != 'a')
     61a:	f9040693          	addi	a3,s0,-112
     61e:	f9840613          	addi	a2,s0,-104
     622:	85ca                	mv	a1,s2
     624:	854e                	mv	a0,s3
     626:	00000097          	auipc	ra,0x0
     62a:	db8080e7          	jalr	-584(ra) # 3de <gettoken>
     62e:	f9851de3          	bne	a0,s8,5c8 <parseredirs+0x32>
        switch (tok)
     632:	fb9483e3          	beq	s1,s9,5d8 <parseredirs+0x42>
     636:	03648263          	beq	s1,s6,65a <parseredirs+0xc4>
     63a:	fb549fe3          	bne	s1,s5,5f8 <parseredirs+0x62>
            break;
        case '>':
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
            break;
        case '+': // >>
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE, 1);
     63e:	4705                	li	a4,1
     640:	20100693          	li	a3,513
     644:	f9043603          	ld	a2,-112(s0)
     648:	f9843583          	ld	a1,-104(s0)
     64c:	8552                	mv	a0,s4
     64e:	00000097          	auipc	ra,0x0
     652:	c60080e7          	jalr	-928(ra) # 2ae <redircmd>
     656:	8a2a                	mv	s4,a0
            break;
     658:	bf61                	j	5f0 <parseredirs+0x5a>
            cmd = redircmd(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     65a:	4705                	li	a4,1
     65c:	60100693          	li	a3,1537
     660:	f9043603          	ld	a2,-112(s0)
     664:	f9843583          	ld	a1,-104(s0)
     668:	8552                	mv	a0,s4
     66a:	00000097          	auipc	ra,0x0
     66e:	c44080e7          	jalr	-956(ra) # 2ae <redircmd>
     672:	8a2a                	mv	s4,a0
            break;
     674:	bfb5                	j	5f0 <parseredirs+0x5a>
        }
    }
    return cmd;
}
     676:	8552                	mv	a0,s4
     678:	70a6                	ld	ra,104(sp)
     67a:	7406                	ld	s0,96(sp)
     67c:	64e6                	ld	s1,88(sp)
     67e:	6946                	ld	s2,80(sp)
     680:	69a6                	ld	s3,72(sp)
     682:	6a06                	ld	s4,64(sp)
     684:	7ae2                	ld	s5,56(sp)
     686:	7b42                	ld	s6,48(sp)
     688:	7ba2                	ld	s7,40(sp)
     68a:	7c02                	ld	s8,32(sp)
     68c:	6ce2                	ld	s9,24(sp)
     68e:	6165                	addi	sp,sp,112
     690:	8082                	ret

0000000000000692 <parseexec>:
    return cmd;
}

struct cmd *
parseexec(char **ps, char *es)
{
     692:	7159                	addi	sp,sp,-112
     694:	f486                	sd	ra,104(sp)
     696:	f0a2                	sd	s0,96(sp)
     698:	eca6                	sd	s1,88(sp)
     69a:	e8ca                	sd	s2,80(sp)
     69c:	e4ce                	sd	s3,72(sp)
     69e:	e0d2                	sd	s4,64(sp)
     6a0:	fc56                	sd	s5,56(sp)
     6a2:	f85a                	sd	s6,48(sp)
     6a4:	f45e                	sd	s7,40(sp)
     6a6:	f062                	sd	s8,32(sp)
     6a8:	ec66                	sd	s9,24(sp)
     6aa:	1880                	addi	s0,sp,112
     6ac:	8a2a                	mv	s4,a0
     6ae:	8aae                	mv	s5,a1
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;

    if (peek(ps, es, "("))
     6b0:	00001617          	auipc	a2,0x1
     6b4:	15060613          	addi	a2,a2,336 # 1800 <malloc+0x156>
     6b8:	00000097          	auipc	ra,0x0
     6bc:	e72080e7          	jalr	-398(ra) # 52a <peek>
     6c0:	e905                	bnez	a0,6f0 <parseexec+0x5e>
     6c2:	89aa                	mv	s3,a0
        return parseblock(ps, es);

    ret = execcmd();
     6c4:	00000097          	auipc	ra,0x0
     6c8:	bb4080e7          	jalr	-1100(ra) # 278 <execcmd>
     6cc:	8c2a                	mv	s8,a0
    cmd = (struct execcmd *)ret;

    argc = 0;
    ret = parseredirs(ret, ps, es);
     6ce:	8656                	mv	a2,s5
     6d0:	85d2                	mv	a1,s4
     6d2:	00000097          	auipc	ra,0x0
     6d6:	ec4080e7          	jalr	-316(ra) # 596 <parseredirs>
     6da:	84aa                	mv	s1,a0
    while (!peek(ps, es, "|)&;"))
     6dc:	008c0913          	addi	s2,s8,8
     6e0:	00001b17          	auipc	s6,0x1
     6e4:	140b0b13          	addi	s6,s6,320 # 1820 <malloc+0x176>
    {
        if ((tok = gettoken(ps, es, &q, &eq)) == 0)
            break;
        if (tok != 'a')
     6e8:	06100c93          	li	s9,97
            panic("syntax");
        cmd->argv[argc] = q;
        cmd->eargv[argc] = eq;
        argc++;
        if (argc >= MAXARGS)
     6ec:	4ba9                	li	s7,10
    while (!peek(ps, es, "|)&;"))
     6ee:	a0b1                	j	73a <parseexec+0xa8>
        return parseblock(ps, es);
     6f0:	85d6                	mv	a1,s5
     6f2:	8552                	mv	a0,s4
     6f4:	00000097          	auipc	ra,0x0
     6f8:	1bc080e7          	jalr	444(ra) # 8b0 <parseblock>
     6fc:	84aa                	mv	s1,a0
        ret = parseredirs(ret, ps, es);
    }
    cmd->argv[argc] = 0;
    cmd->eargv[argc] = 0;
    return ret;
}
     6fe:	8526                	mv	a0,s1
     700:	70a6                	ld	ra,104(sp)
     702:	7406                	ld	s0,96(sp)
     704:	64e6                	ld	s1,88(sp)
     706:	6946                	ld	s2,80(sp)
     708:	69a6                	ld	s3,72(sp)
     70a:	6a06                	ld	s4,64(sp)
     70c:	7ae2                	ld	s5,56(sp)
     70e:	7b42                	ld	s6,48(sp)
     710:	7ba2                	ld	s7,40(sp)
     712:	7c02                	ld	s8,32(sp)
     714:	6ce2                	ld	s9,24(sp)
     716:	6165                	addi	sp,sp,112
     718:	8082                	ret
            panic("syntax");
     71a:	00001517          	auipc	a0,0x1
     71e:	0ee50513          	addi	a0,a0,238 # 1808 <malloc+0x15e>
     722:	00000097          	auipc	ra,0x0
     726:	934080e7          	jalr	-1740(ra) # 56 <panic>
        ret = parseredirs(ret, ps, es);
     72a:	8656                	mv	a2,s5
     72c:	85d2                	mv	a1,s4
     72e:	8526                	mv	a0,s1
     730:	00000097          	auipc	ra,0x0
     734:	e66080e7          	jalr	-410(ra) # 596 <parseredirs>
     738:	84aa                	mv	s1,a0
    while (!peek(ps, es, "|)&;"))
     73a:	865a                	mv	a2,s6
     73c:	85d6                	mv	a1,s5
     73e:	8552                	mv	a0,s4
     740:	00000097          	auipc	ra,0x0
     744:	dea080e7          	jalr	-534(ra) # 52a <peek>
     748:	e131                	bnez	a0,78c <parseexec+0xfa>
        if ((tok = gettoken(ps, es, &q, &eq)) == 0)
     74a:	f9040693          	addi	a3,s0,-112
     74e:	f9840613          	addi	a2,s0,-104
     752:	85d6                	mv	a1,s5
     754:	8552                	mv	a0,s4
     756:	00000097          	auipc	ra,0x0
     75a:	c88080e7          	jalr	-888(ra) # 3de <gettoken>
     75e:	c51d                	beqz	a0,78c <parseexec+0xfa>
        if (tok != 'a')
     760:	fb951de3          	bne	a0,s9,71a <parseexec+0x88>
        cmd->argv[argc] = q;
     764:	f9843783          	ld	a5,-104(s0)
     768:	00f93023          	sd	a5,0(s2)
        cmd->eargv[argc] = eq;
     76c:	f9043783          	ld	a5,-112(s0)
     770:	04f93823          	sd	a5,80(s2)
        argc++;
     774:	2985                	addiw	s3,s3,1
        if (argc >= MAXARGS)
     776:	0921                	addi	s2,s2,8
     778:	fb7999e3          	bne	s3,s7,72a <parseexec+0x98>
            panic("too many args");
     77c:	00001517          	auipc	a0,0x1
     780:	09450513          	addi	a0,a0,148 # 1810 <malloc+0x166>
     784:	00000097          	auipc	ra,0x0
     788:	8d2080e7          	jalr	-1838(ra) # 56 <panic>
    cmd->argv[argc] = 0;
     78c:	098e                	slli	s3,s3,0x3
     78e:	9c4e                	add	s8,s8,s3
     790:	000c3423          	sd	zero,8(s8)
    cmd->eargv[argc] = 0;
     794:	040c3c23          	sd	zero,88(s8)
    return ret;
     798:	b79d                	j	6fe <parseexec+0x6c>

000000000000079a <parsepipe>:
{
     79a:	7179                	addi	sp,sp,-48
     79c:	f406                	sd	ra,40(sp)
     79e:	f022                	sd	s0,32(sp)
     7a0:	ec26                	sd	s1,24(sp)
     7a2:	e84a                	sd	s2,16(sp)
     7a4:	e44e                	sd	s3,8(sp)
     7a6:	1800                	addi	s0,sp,48
     7a8:	892a                	mv	s2,a0
     7aa:	89ae                	mv	s3,a1
    cmd = parseexec(ps, es);
     7ac:	00000097          	auipc	ra,0x0
     7b0:	ee6080e7          	jalr	-282(ra) # 692 <parseexec>
     7b4:	84aa                	mv	s1,a0
    if (peek(ps, es, "|"))
     7b6:	00001617          	auipc	a2,0x1
     7ba:	07260613          	addi	a2,a2,114 # 1828 <malloc+0x17e>
     7be:	85ce                	mv	a1,s3
     7c0:	854a                	mv	a0,s2
     7c2:	00000097          	auipc	ra,0x0
     7c6:	d68080e7          	jalr	-664(ra) # 52a <peek>
     7ca:	e909                	bnez	a0,7dc <parsepipe+0x42>
}
     7cc:	8526                	mv	a0,s1
     7ce:	70a2                	ld	ra,40(sp)
     7d0:	7402                	ld	s0,32(sp)
     7d2:	64e2                	ld	s1,24(sp)
     7d4:	6942                	ld	s2,16(sp)
     7d6:	69a2                	ld	s3,8(sp)
     7d8:	6145                	addi	sp,sp,48
     7da:	8082                	ret
        gettoken(ps, es, 0, 0);
     7dc:	4681                	li	a3,0
     7de:	4601                	li	a2,0
     7e0:	85ce                	mv	a1,s3
     7e2:	854a                	mv	a0,s2
     7e4:	00000097          	auipc	ra,0x0
     7e8:	bfa080e7          	jalr	-1030(ra) # 3de <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     7ec:	85ce                	mv	a1,s3
     7ee:	854a                	mv	a0,s2
     7f0:	00000097          	auipc	ra,0x0
     7f4:	faa080e7          	jalr	-86(ra) # 79a <parsepipe>
     7f8:	85aa                	mv	a1,a0
     7fa:	8526                	mv	a0,s1
     7fc:	00000097          	auipc	ra,0x0
     800:	b1a080e7          	jalr	-1254(ra) # 316 <pipecmd>
     804:	84aa                	mv	s1,a0
    return cmd;
     806:	b7d9                	j	7cc <parsepipe+0x32>

0000000000000808 <parseline>:
{
     808:	7179                	addi	sp,sp,-48
     80a:	f406                	sd	ra,40(sp)
     80c:	f022                	sd	s0,32(sp)
     80e:	ec26                	sd	s1,24(sp)
     810:	e84a                	sd	s2,16(sp)
     812:	e44e                	sd	s3,8(sp)
     814:	e052                	sd	s4,0(sp)
     816:	1800                	addi	s0,sp,48
     818:	892a                	mv	s2,a0
     81a:	89ae                	mv	s3,a1
    cmd = parsepipe(ps, es);
     81c:	00000097          	auipc	ra,0x0
     820:	f7e080e7          	jalr	-130(ra) # 79a <parsepipe>
     824:	84aa                	mv	s1,a0
    while (peek(ps, es, "&"))
     826:	00001a17          	auipc	s4,0x1
     82a:	00aa0a13          	addi	s4,s4,10 # 1830 <malloc+0x186>
     82e:	a839                	j	84c <parseline+0x44>
        gettoken(ps, es, 0, 0);
     830:	4681                	li	a3,0
     832:	4601                	li	a2,0
     834:	85ce                	mv	a1,s3
     836:	854a                	mv	a0,s2
     838:	00000097          	auipc	ra,0x0
     83c:	ba6080e7          	jalr	-1114(ra) # 3de <gettoken>
        cmd = backcmd(cmd);
     840:	8526                	mv	a0,s1
     842:	00000097          	auipc	ra,0x0
     846:	b60080e7          	jalr	-1184(ra) # 3a2 <backcmd>
     84a:	84aa                	mv	s1,a0
    while (peek(ps, es, "&"))
     84c:	8652                	mv	a2,s4
     84e:	85ce                	mv	a1,s3
     850:	854a                	mv	a0,s2
     852:	00000097          	auipc	ra,0x0
     856:	cd8080e7          	jalr	-808(ra) # 52a <peek>
     85a:	f979                	bnez	a0,830 <parseline+0x28>
    if (peek(ps, es, ";"))
     85c:	00001617          	auipc	a2,0x1
     860:	fdc60613          	addi	a2,a2,-36 # 1838 <malloc+0x18e>
     864:	85ce                	mv	a1,s3
     866:	854a                	mv	a0,s2
     868:	00000097          	auipc	ra,0x0
     86c:	cc2080e7          	jalr	-830(ra) # 52a <peek>
     870:	e911                	bnez	a0,884 <parseline+0x7c>
}
     872:	8526                	mv	a0,s1
     874:	70a2                	ld	ra,40(sp)
     876:	7402                	ld	s0,32(sp)
     878:	64e2                	ld	s1,24(sp)
     87a:	6942                	ld	s2,16(sp)
     87c:	69a2                	ld	s3,8(sp)
     87e:	6a02                	ld	s4,0(sp)
     880:	6145                	addi	sp,sp,48
     882:	8082                	ret
        gettoken(ps, es, 0, 0);
     884:	4681                	li	a3,0
     886:	4601                	li	a2,0
     888:	85ce                	mv	a1,s3
     88a:	854a                	mv	a0,s2
     88c:	00000097          	auipc	ra,0x0
     890:	b52080e7          	jalr	-1198(ra) # 3de <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     894:	85ce                	mv	a1,s3
     896:	854a                	mv	a0,s2
     898:	00000097          	auipc	ra,0x0
     89c:	f70080e7          	jalr	-144(ra) # 808 <parseline>
     8a0:	85aa                	mv	a1,a0
     8a2:	8526                	mv	a0,s1
     8a4:	00000097          	auipc	ra,0x0
     8a8:	ab8080e7          	jalr	-1352(ra) # 35c <listcmd>
     8ac:	84aa                	mv	s1,a0
    return cmd;
     8ae:	b7d1                	j	872 <parseline+0x6a>

00000000000008b0 <parseblock>:
{
     8b0:	7179                	addi	sp,sp,-48
     8b2:	f406                	sd	ra,40(sp)
     8b4:	f022                	sd	s0,32(sp)
     8b6:	ec26                	sd	s1,24(sp)
     8b8:	e84a                	sd	s2,16(sp)
     8ba:	e44e                	sd	s3,8(sp)
     8bc:	1800                	addi	s0,sp,48
     8be:	84aa                	mv	s1,a0
     8c0:	892e                	mv	s2,a1
    if (!peek(ps, es, "("))
     8c2:	00001617          	auipc	a2,0x1
     8c6:	f3e60613          	addi	a2,a2,-194 # 1800 <malloc+0x156>
     8ca:	00000097          	auipc	ra,0x0
     8ce:	c60080e7          	jalr	-928(ra) # 52a <peek>
     8d2:	c12d                	beqz	a0,934 <parseblock+0x84>
    gettoken(ps, es, 0, 0);
     8d4:	4681                	li	a3,0
     8d6:	4601                	li	a2,0
     8d8:	85ca                	mv	a1,s2
     8da:	8526                	mv	a0,s1
     8dc:	00000097          	auipc	ra,0x0
     8e0:	b02080e7          	jalr	-1278(ra) # 3de <gettoken>
    cmd = parseline(ps, es);
     8e4:	85ca                	mv	a1,s2
     8e6:	8526                	mv	a0,s1
     8e8:	00000097          	auipc	ra,0x0
     8ec:	f20080e7          	jalr	-224(ra) # 808 <parseline>
     8f0:	89aa                	mv	s3,a0
    if (!peek(ps, es, ")"))
     8f2:	00001617          	auipc	a2,0x1
     8f6:	f5e60613          	addi	a2,a2,-162 # 1850 <malloc+0x1a6>
     8fa:	85ca                	mv	a1,s2
     8fc:	8526                	mv	a0,s1
     8fe:	00000097          	auipc	ra,0x0
     902:	c2c080e7          	jalr	-980(ra) # 52a <peek>
     906:	cd1d                	beqz	a0,944 <parseblock+0x94>
    gettoken(ps, es, 0, 0);
     908:	4681                	li	a3,0
     90a:	4601                	li	a2,0
     90c:	85ca                	mv	a1,s2
     90e:	8526                	mv	a0,s1
     910:	00000097          	auipc	ra,0x0
     914:	ace080e7          	jalr	-1330(ra) # 3de <gettoken>
    cmd = parseredirs(cmd, ps, es);
     918:	864a                	mv	a2,s2
     91a:	85a6                	mv	a1,s1
     91c:	854e                	mv	a0,s3
     91e:	00000097          	auipc	ra,0x0
     922:	c78080e7          	jalr	-904(ra) # 596 <parseredirs>
}
     926:	70a2                	ld	ra,40(sp)
     928:	7402                	ld	s0,32(sp)
     92a:	64e2                	ld	s1,24(sp)
     92c:	6942                	ld	s2,16(sp)
     92e:	69a2                	ld	s3,8(sp)
     930:	6145                	addi	sp,sp,48
     932:	8082                	ret
        panic("parseblock");
     934:	00001517          	auipc	a0,0x1
     938:	f0c50513          	addi	a0,a0,-244 # 1840 <malloc+0x196>
     93c:	fffff097          	auipc	ra,0xfffff
     940:	71a080e7          	jalr	1818(ra) # 56 <panic>
        panic("syntax - missing )");
     944:	00001517          	auipc	a0,0x1
     948:	f1450513          	addi	a0,a0,-236 # 1858 <malloc+0x1ae>
     94c:	fffff097          	auipc	ra,0xfffff
     950:	70a080e7          	jalr	1802(ra) # 56 <panic>

0000000000000954 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd *
nulterminate(struct cmd *cmd)
{
     954:	1101                	addi	sp,sp,-32
     956:	ec06                	sd	ra,24(sp)
     958:	e822                	sd	s0,16(sp)
     95a:	e426                	sd	s1,8(sp)
     95c:	1000                	addi	s0,sp,32
     95e:	84aa                	mv	s1,a0
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;

    if (cmd == 0)
     960:	c521                	beqz	a0,9a8 <nulterminate+0x54>
        return 0;

    switch (cmd->type)
     962:	4118                	lw	a4,0(a0)
     964:	4795                	li	a5,5
     966:	04e7e163          	bltu	a5,a4,9a8 <nulterminate+0x54>
     96a:	00056783          	lwu	a5,0(a0)
     96e:	078a                	slli	a5,a5,0x2
     970:	00001717          	auipc	a4,0x1
     974:	f5c70713          	addi	a4,a4,-164 # 18cc <malloc+0x222>
     978:	97ba                	add	a5,a5,a4
     97a:	439c                	lw	a5,0(a5)
     97c:	97ba                	add	a5,a5,a4
     97e:	8782                	jr	a5
    {
    case EXEC:
        ecmd = (struct execcmd *)cmd;
        for (i = 0; ecmd->argv[i]; i++)
     980:	651c                	ld	a5,8(a0)
     982:	c39d                	beqz	a5,9a8 <nulterminate+0x54>
     984:	01050793          	addi	a5,a0,16
            *ecmd->eargv[i] = 0;
     988:	67b8                	ld	a4,72(a5)
     98a:	00070023          	sb	zero,0(a4)
        for (i = 0; ecmd->argv[i]; i++)
     98e:	07a1                	addi	a5,a5,8
     990:	ff87b703          	ld	a4,-8(a5)
     994:	fb75                	bnez	a4,988 <nulterminate+0x34>
     996:	a809                	j	9a8 <nulterminate+0x54>
        break;

    case REDIR:
        rcmd = (struct redircmd *)cmd;
        nulterminate(rcmd->cmd);
     998:	6508                	ld	a0,8(a0)
     99a:	00000097          	auipc	ra,0x0
     99e:	fba080e7          	jalr	-70(ra) # 954 <nulterminate>
        *rcmd->efile = 0;
     9a2:	6c9c                	ld	a5,24(s1)
     9a4:	00078023          	sb	zero,0(a5)
        bcmd = (struct backcmd *)cmd;
        nulterminate(bcmd->cmd);
        break;
    }
    return cmd;
}
     9a8:	8526                	mv	a0,s1
     9aa:	60e2                	ld	ra,24(sp)
     9ac:	6442                	ld	s0,16(sp)
     9ae:	64a2                	ld	s1,8(sp)
     9b0:	6105                	addi	sp,sp,32
     9b2:	8082                	ret
        nulterminate(pcmd->left);
     9b4:	6508                	ld	a0,8(a0)
     9b6:	00000097          	auipc	ra,0x0
     9ba:	f9e080e7          	jalr	-98(ra) # 954 <nulterminate>
        nulterminate(pcmd->right);
     9be:	6888                	ld	a0,16(s1)
     9c0:	00000097          	auipc	ra,0x0
     9c4:	f94080e7          	jalr	-108(ra) # 954 <nulterminate>
        break;
     9c8:	b7c5                	j	9a8 <nulterminate+0x54>
        nulterminate(lcmd->left);
     9ca:	6508                	ld	a0,8(a0)
     9cc:	00000097          	auipc	ra,0x0
     9d0:	f88080e7          	jalr	-120(ra) # 954 <nulterminate>
        nulterminate(lcmd->right);
     9d4:	6888                	ld	a0,16(s1)
     9d6:	00000097          	auipc	ra,0x0
     9da:	f7e080e7          	jalr	-130(ra) # 954 <nulterminate>
        break;
     9de:	b7e9                	j	9a8 <nulterminate+0x54>
        nulterminate(bcmd->cmd);
     9e0:	6508                	ld	a0,8(a0)
     9e2:	00000097          	auipc	ra,0x0
     9e6:	f72080e7          	jalr	-142(ra) # 954 <nulterminate>
        break;
     9ea:	bf7d                	j	9a8 <nulterminate+0x54>

00000000000009ec <parsecmd>:
{
     9ec:	7179                	addi	sp,sp,-48
     9ee:	f406                	sd	ra,40(sp)
     9f0:	f022                	sd	s0,32(sp)
     9f2:	ec26                	sd	s1,24(sp)
     9f4:	e84a                	sd	s2,16(sp)
     9f6:	1800                	addi	s0,sp,48
     9f8:	fca43c23          	sd	a0,-40(s0)
    es = s + strlen(s);
     9fc:	84aa                	mv	s1,a0
     9fe:	00000097          	auipc	ra,0x0
     a02:	650080e7          	jalr	1616(ra) # 104e <strlen>
     a06:	1502                	slli	a0,a0,0x20
     a08:	9101                	srli	a0,a0,0x20
     a0a:	94aa                	add	s1,s1,a0
    cmd = parseline(&s, es);
     a0c:	85a6                	mv	a1,s1
     a0e:	fd840513          	addi	a0,s0,-40
     a12:	00000097          	auipc	ra,0x0
     a16:	df6080e7          	jalr	-522(ra) # 808 <parseline>
     a1a:	892a                	mv	s2,a0
    peek(&s, es, "");
     a1c:	00001617          	auipc	a2,0x1
     a20:	e5460613          	addi	a2,a2,-428 # 1870 <malloc+0x1c6>
     a24:	85a6                	mv	a1,s1
     a26:	fd840513          	addi	a0,s0,-40
     a2a:	00000097          	auipc	ra,0x0
     a2e:	b00080e7          	jalr	-1280(ra) # 52a <peek>
    if (s != es)
     a32:	fd843603          	ld	a2,-40(s0)
     a36:	00961e63          	bne	a2,s1,a52 <parsecmd+0x66>
    nulterminate(cmd);
     a3a:	854a                	mv	a0,s2
     a3c:	00000097          	auipc	ra,0x0
     a40:	f18080e7          	jalr	-232(ra) # 954 <nulterminate>
}
     a44:	854a                	mv	a0,s2
     a46:	70a2                	ld	ra,40(sp)
     a48:	7402                	ld	s0,32(sp)
     a4a:	64e2                	ld	s1,24(sp)
     a4c:	6942                	ld	s2,16(sp)
     a4e:	6145                	addi	sp,sp,48
     a50:	8082                	ret
        fprintf(2, "leftovers: %s\n", s);
     a52:	00001597          	auipc	a1,0x1
     a56:	e2658593          	addi	a1,a1,-474 # 1878 <malloc+0x1ce>
     a5a:	4509                	li	a0,2
     a5c:	00001097          	auipc	ra,0x1
     a60:	b68080e7          	jalr	-1176(ra) # 15c4 <fprintf>
        panic("syntax");
     a64:	00001517          	auipc	a0,0x1
     a68:	da450513          	addi	a0,a0,-604 # 1808 <malloc+0x15e>
     a6c:	fffff097          	auipc	ra,0xfffff
     a70:	5ea080e7          	jalr	1514(ra) # 56 <panic>

0000000000000a74 <parse_buffer>:
{
     a74:	1101                	addi	sp,sp,-32
     a76:	ec06                	sd	ra,24(sp)
     a78:	e822                	sd	s0,16(sp)
     a7a:	e426                	sd	s1,8(sp)
     a7c:	1000                	addi	s0,sp,32
     a7e:	84aa                	mv	s1,a0
    if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     a80:	00054783          	lbu	a5,0(a0)
     a84:	06300713          	li	a4,99
     a88:	02e78b63          	beq	a5,a4,abe <parse_buffer+0x4a>
    if (buf[0] == 'e' &&
     a8c:	06500713          	li	a4,101
     a90:	00e79863          	bne	a5,a4,aa0 <parse_buffer+0x2c>
     a94:	00154703          	lbu	a4,1(a0)
     a98:	07800793          	li	a5,120
     a9c:	06f70b63          	beq	a4,a5,b12 <parse_buffer+0x9e>
    if (fork1() == 0)
     aa0:	fffff097          	auipc	ra,0xfffff
     aa4:	5dc080e7          	jalr	1500(ra) # 7c <fork1>
     aa8:	c551                	beqz	a0,b34 <parse_buffer+0xc0>
    wait(0);
     aaa:	4501                	li	a0,0
     aac:	00000097          	auipc	ra,0x0
     ab0:	7ce080e7          	jalr	1998(ra) # 127a <wait>
}
     ab4:	60e2                	ld	ra,24(sp)
     ab6:	6442                	ld	s0,16(sp)
     ab8:	64a2                	ld	s1,8(sp)
     aba:	6105                	addi	sp,sp,32
     abc:	8082                	ret
    if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     abe:	00154703          	lbu	a4,1(a0)
     ac2:	06400793          	li	a5,100
     ac6:	fcf71de3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
     aca:	00254703          	lbu	a4,2(a0)
     ace:	02000793          	li	a5,32
     ad2:	fcf717e3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        buf[strlen(buf) - 1] = 0; // chop \n
     ad6:	00000097          	auipc	ra,0x0
     ada:	578080e7          	jalr	1400(ra) # 104e <strlen>
     ade:	fff5079b          	addiw	a5,a0,-1
     ae2:	1782                	slli	a5,a5,0x20
     ae4:	9381                	srli	a5,a5,0x20
     ae6:	97a6                	add	a5,a5,s1
     ae8:	00078023          	sb	zero,0(a5)
        if (chdir(buf + 3) < 0)
     aec:	048d                	addi	s1,s1,3
     aee:	8526                	mv	a0,s1
     af0:	00000097          	auipc	ra,0x0
     af4:	7f2080e7          	jalr	2034(ra) # 12e2 <chdir>
     af8:	fa055ee3          	bgez	a0,ab4 <parse_buffer+0x40>
            fprintf(2, "cannot cd %s\n", buf + 3);
     afc:	8626                	mv	a2,s1
     afe:	00001597          	auipc	a1,0x1
     b02:	d8a58593          	addi	a1,a1,-630 # 1888 <malloc+0x1de>
     b06:	4509                	li	a0,2
     b08:	00001097          	auipc	ra,0x1
     b0c:	abc080e7          	jalr	-1348(ra) # 15c4 <fprintf>
     b10:	b755                	j	ab4 <parse_buffer+0x40>
        buf[1] == 'x' &&
     b12:	00254703          	lbu	a4,2(a0)
     b16:	06900793          	li	a5,105
     b1a:	f8f713e3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        buf[2] == 'i' &&
     b1e:	00354703          	lbu	a4,3(a0)
     b22:	07400793          	li	a5,116
     b26:	f6f71de3          	bne	a4,a5,aa0 <parse_buffer+0x2c>
        exit(0);
     b2a:	4501                	li	a0,0
     b2c:	00000097          	auipc	ra,0x0
     b30:	746080e7          	jalr	1862(ra) # 1272 <exit>
        runcmd(parsecmd(buf));
     b34:	8526                	mv	a0,s1
     b36:	00000097          	auipc	ra,0x0
     b3a:	eb6080e7          	jalr	-330(ra) # 9ec <parsecmd>
     b3e:	fffff097          	auipc	ra,0xfffff
     b42:	56c080e7          	jalr	1388(ra) # aa <runcmd>

0000000000000b46 <main>:
{
     b46:	7179                	addi	sp,sp,-48
     b48:	f406                	sd	ra,40(sp)
     b4a:	f022                	sd	s0,32(sp)
     b4c:	ec26                	sd	s1,24(sp)
     b4e:	e84a                	sd	s2,16(sp)
     b50:	e44e                	sd	s3,8(sp)
     b52:	1800                	addi	s0,sp,48
     b54:	892a                	mv	s2,a0
     b56:	89ae                	mv	s3,a1
    while ((fd = open("console", O_RDWR)) >= 0)
     b58:	00001497          	auipc	s1,0x1
     b5c:	d4048493          	addi	s1,s1,-704 # 1898 <malloc+0x1ee>
     b60:	4589                	li	a1,2
     b62:	8526                	mv	a0,s1
     b64:	00000097          	auipc	ra,0x0
     b68:	74e080e7          	jalr	1870(ra) # 12b2 <open>
     b6c:	00054963          	bltz	a0,b7e <main+0x38>
        if (fd >= 3)
     b70:	4789                	li	a5,2
     b72:	fea7d7e3          	bge	a5,a0,b60 <main+0x1a>
            close(fd);
     b76:	00000097          	auipc	ra,0x0
     b7a:	724080e7          	jalr	1828(ra) # 129a <close>
    if (argc == 2)
     b7e:	4789                	li	a5,2
    while (getcmd(buf, sizeof(buf)) >= 0)
     b80:	00001497          	auipc	s1,0x1
     b84:	4b048493          	addi	s1,s1,1200 # 2030 <buf.0>
    if (argc == 2)
     b88:	08f91463          	bne	s2,a5,c10 <main+0xca>
        char *shell_script_file = argv[1];
     b8c:	0089b483          	ld	s1,8(s3)
        int shfd = open(shell_script_file, O_RDWR);
     b90:	4589                	li	a1,2
     b92:	8526                	mv	a0,s1
     b94:	00000097          	auipc	ra,0x0
     b98:	71e080e7          	jalr	1822(ra) # 12b2 <open>
     b9c:	892a                	mv	s2,a0
        if (shfd < 0)
     b9e:	04054663          	bltz	a0,bea <main+0xa4>
        read(shfd, buf, sizeof(buf));
     ba2:	07800613          	li	a2,120
     ba6:	00001597          	auipc	a1,0x1
     baa:	48a58593          	addi	a1,a1,1162 # 2030 <buf.0>
     bae:	00000097          	auipc	ra,0x0
     bb2:	6dc080e7          	jalr	1756(ra) # 128a <read>
            parse_buffer(buf);
     bb6:	00001497          	auipc	s1,0x1
     bba:	47a48493          	addi	s1,s1,1146 # 2030 <buf.0>
     bbe:	8526                	mv	a0,s1
     bc0:	00000097          	auipc	ra,0x0
     bc4:	eb4080e7          	jalr	-332(ra) # a74 <parse_buffer>
        } while (read(shfd, buf, sizeof(buf)) == sizeof(buf));
     bc8:	07800613          	li	a2,120
     bcc:	85a6                	mv	a1,s1
     bce:	854a                	mv	a0,s2
     bd0:	00000097          	auipc	ra,0x0
     bd4:	6ba080e7          	jalr	1722(ra) # 128a <read>
     bd8:	07800793          	li	a5,120
     bdc:	fef501e3          	beq	a0,a5,bbe <main+0x78>
        exit(0);
     be0:	4501                	li	a0,0
     be2:	00000097          	auipc	ra,0x0
     be6:	690080e7          	jalr	1680(ra) # 1272 <exit>
            printf("Failed to open %s\n", shell_script_file);
     bea:	85a6                	mv	a1,s1
     bec:	00001517          	auipc	a0,0x1
     bf0:	cb450513          	addi	a0,a0,-844 # 18a0 <malloc+0x1f6>
     bf4:	00001097          	auipc	ra,0x1
     bf8:	9fe080e7          	jalr	-1538(ra) # 15f2 <printf>
            exit(1);
     bfc:	4505                	li	a0,1
     bfe:	00000097          	auipc	ra,0x0
     c02:	674080e7          	jalr	1652(ra) # 1272 <exit>
        parse_buffer(buf);
     c06:	8526                	mv	a0,s1
     c08:	00000097          	auipc	ra,0x0
     c0c:	e6c080e7          	jalr	-404(ra) # a74 <parse_buffer>
    while (getcmd(buf, sizeof(buf)) >= 0)
     c10:	07800593          	li	a1,120
     c14:	8526                	mv	a0,s1
     c16:	fffff097          	auipc	ra,0xfffff
     c1a:	3ea080e7          	jalr	1002(ra) # 0 <getcmd>
     c1e:	fe0554e3          	bgez	a0,c06 <main+0xc0>
    exit(0);
     c22:	4501                	li	a0,0
     c24:	00000097          	auipc	ra,0x0
     c28:	64e080e7          	jalr	1614(ra) # 1272 <exit>

0000000000000c2c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
     c2c:	1141                	addi	sp,sp,-16
     c2e:	e422                	sd	s0,8(sp)
     c30:	0800                	addi	s0,sp,16
    lk->name = name;
     c32:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
     c34:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
     c38:	57fd                	li	a5,-1
     c3a:	00f50823          	sb	a5,16(a0)
}
     c3e:	6422                	ld	s0,8(sp)
     c40:	0141                	addi	sp,sp,16
     c42:	8082                	ret

0000000000000c44 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
     c44:	00054783          	lbu	a5,0(a0)
     c48:	e399                	bnez	a5,c4e <holding+0xa>
     c4a:	4501                	li	a0,0
}
     c4c:	8082                	ret
{
     c4e:	1101                	addi	sp,sp,-32
     c50:	ec06                	sd	ra,24(sp)
     c52:	e822                	sd	s0,16(sp)
     c54:	e426                	sd	s1,8(sp)
     c56:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
     c58:	01054483          	lbu	s1,16(a0)
     c5c:	00000097          	auipc	ra,0x0
     c60:	2c4080e7          	jalr	708(ra) # f20 <twhoami>
     c64:	2501                	sext.w	a0,a0
     c66:	40a48533          	sub	a0,s1,a0
     c6a:	00153513          	seqz	a0,a0
}
     c6e:	60e2                	ld	ra,24(sp)
     c70:	6442                	ld	s0,16(sp)
     c72:	64a2                	ld	s1,8(sp)
     c74:	6105                	addi	sp,sp,32
     c76:	8082                	ret

0000000000000c78 <acquire>:

void acquire(struct lock *lk)
{
     c78:	7179                	addi	sp,sp,-48
     c7a:	f406                	sd	ra,40(sp)
     c7c:	f022                	sd	s0,32(sp)
     c7e:	ec26                	sd	s1,24(sp)
     c80:	e84a                	sd	s2,16(sp)
     c82:	e44e                	sd	s3,8(sp)
     c84:	e052                	sd	s4,0(sp)
     c86:	1800                	addi	s0,sp,48
     c88:	8a2a                	mv	s4,a0
    if (holding(lk))
     c8a:	00000097          	auipc	ra,0x0
     c8e:	fba080e7          	jalr	-70(ra) # c44 <holding>
     c92:	e919                	bnez	a0,ca8 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     c94:	ffca7493          	andi	s1,s4,-4
     c98:	003a7913          	andi	s2,s4,3
     c9c:	0039191b          	slliw	s2,s2,0x3
     ca0:	4985                	li	s3,1
     ca2:	012999bb          	sllw	s3,s3,s2
     ca6:	a015                	j	cca <acquire+0x52>
        printf("re-acquiring lock we already hold");
     ca8:	00001517          	auipc	a0,0x1
     cac:	c4050513          	addi	a0,a0,-960 # 18e8 <malloc+0x23e>
     cb0:	00001097          	auipc	ra,0x1
     cb4:	942080e7          	jalr	-1726(ra) # 15f2 <printf>
        exit(-1);
     cb8:	557d                	li	a0,-1
     cba:	00000097          	auipc	ra,0x0
     cbe:	5b8080e7          	jalr	1464(ra) # 1272 <exit>
    {
        // give up the cpu for other threads
        tyield();
     cc2:	00000097          	auipc	ra,0x0
     cc6:	1dc080e7          	jalr	476(ra) # e9e <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     cca:	4534a7af          	amoor.w.aq	a5,s3,(s1)
     cce:	0127d7bb          	srlw	a5,a5,s2
     cd2:	0ff7f793          	zext.b	a5,a5
     cd6:	f7f5                	bnez	a5,cc2 <acquire+0x4a>
    }

    __sync_synchronize();
     cd8:	0ff0000f          	fence

    lk->tid = twhoami();
     cdc:	00000097          	auipc	ra,0x0
     ce0:	244080e7          	jalr	580(ra) # f20 <twhoami>
     ce4:	00aa0823          	sb	a0,16(s4)
}
     ce8:	70a2                	ld	ra,40(sp)
     cea:	7402                	ld	s0,32(sp)
     cec:	64e2                	ld	s1,24(sp)
     cee:	6942                	ld	s2,16(sp)
     cf0:	69a2                	ld	s3,8(sp)
     cf2:	6a02                	ld	s4,0(sp)
     cf4:	6145                	addi	sp,sp,48
     cf6:	8082                	ret

0000000000000cf8 <release>:

void release(struct lock *lk)
{
     cf8:	1101                	addi	sp,sp,-32
     cfa:	ec06                	sd	ra,24(sp)
     cfc:	e822                	sd	s0,16(sp)
     cfe:	e426                	sd	s1,8(sp)
     d00:	1000                	addi	s0,sp,32
     d02:	84aa                	mv	s1,a0
    if (!holding(lk))
     d04:	00000097          	auipc	ra,0x0
     d08:	f40080e7          	jalr	-192(ra) # c44 <holding>
     d0c:	c11d                	beqz	a0,d32 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
     d0e:	57fd                	li	a5,-1
     d10:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
     d14:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
     d18:	0ff0000f          	fence
     d1c:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
     d20:	00000097          	auipc	ra,0x0
     d24:	17e080e7          	jalr	382(ra) # e9e <tyield>
}
     d28:	60e2                	ld	ra,24(sp)
     d2a:	6442                	ld	s0,16(sp)
     d2c:	64a2                	ld	s1,8(sp)
     d2e:	6105                	addi	sp,sp,32
     d30:	8082                	ret
        printf("releasing lock we are not holding");
     d32:	00001517          	auipc	a0,0x1
     d36:	bde50513          	addi	a0,a0,-1058 # 1910 <malloc+0x266>
     d3a:	00001097          	auipc	ra,0x1
     d3e:	8b8080e7          	jalr	-1864(ra) # 15f2 <printf>
        exit(-1);
     d42:	557d                	li	a0,-1
     d44:	00000097          	auipc	ra,0x0
     d48:	52e080e7          	jalr	1326(ra) # 1272 <exit>

0000000000000d4c <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
     d4c:	00001517          	auipc	a0,0x1
     d50:	2d453503          	ld	a0,724(a0) # 2020 <current_thread>
     d54:	00001717          	auipc	a4,0x1
     d58:	35470713          	addi	a4,a4,852 # 20a8 <threads>
    for (int i = 0; i < 16; i++) {
     d5c:	4781                	li	a5,0
     d5e:	4641                	li	a2,16
        if (threads[i] == current_thread) {
     d60:	6314                	ld	a3,0(a4)
     d62:	00a68763          	beq	a3,a0,d70 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
     d66:	2785                	addiw	a5,a5,1
     d68:	0721                	addi	a4,a4,8
     d6a:	fec79be3          	bne	a5,a2,d60 <tsched+0x14>
    int current_index = 0;
     d6e:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
     d70:	0017869b          	addiw	a3,a5,1
     d74:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d78:	00001817          	auipc	a6,0x1
     d7c:	33080813          	addi	a6,a6,816 # 20a8 <threads>
     d80:	488d                	li	a7,3
     d82:	a021                	j	d8a <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
     d84:	2685                	addiw	a3,a3,1
     d86:	04c68363          	beq	a3,a2,dcc <tsched+0x80>
        int next_index = (current_index + i) % 16;
     d8a:	41f6d71b          	sraiw	a4,a3,0x1f
     d8e:	01c7571b          	srliw	a4,a4,0x1c
     d92:	00d707bb          	addw	a5,a4,a3
     d96:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d98:	9f99                	subw	a5,a5,a4
     d9a:	078e                	slli	a5,a5,0x3
     d9c:	97c2                	add	a5,a5,a6
     d9e:	638c                	ld	a1,0(a5)
     da0:	d1f5                	beqz	a1,d84 <tsched+0x38>
     da2:	5dbc                	lw	a5,120(a1)
     da4:	ff1790e3          	bne	a5,a7,d84 <tsched+0x38>
{
     da8:	1141                	addi	sp,sp,-16
     daa:	e406                	sd	ra,8(sp)
     dac:	e022                	sd	s0,0(sp)
     dae:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
     db0:	00001797          	auipc	a5,0x1
     db4:	26b7b823          	sd	a1,624(a5) # 2020 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     db8:	05a1                	addi	a1,a1,8
     dba:	0521                	addi	a0,a0,8
     dbc:	00000097          	auipc	ra,0x0
     dc0:	17c080e7          	jalr	380(ra) # f38 <tswtch>
        //printf("Thread switch complete\n");
    }
}
     dc4:	60a2                	ld	ra,8(sp)
     dc6:	6402                	ld	s0,0(sp)
     dc8:	0141                	addi	sp,sp,16
     dca:	8082                	ret
     dcc:	8082                	ret

0000000000000dce <thread_wrapper>:
{
     dce:	1101                	addi	sp,sp,-32
     dd0:	ec06                	sd	ra,24(sp)
     dd2:	e822                	sd	s0,16(sp)
     dd4:	e426                	sd	s1,8(sp)
     dd6:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
     dd8:	00001497          	auipc	s1,0x1
     ddc:	24848493          	addi	s1,s1,584 # 2020 <current_thread>
     de0:	609c                	ld	a5,0(s1)
     de2:	67d8                	ld	a4,136(a5)
     de4:	63c8                	ld	a0,128(a5)
     de6:	9702                	jalr	a4
    current_thread->state = EXITED;
     de8:	609c                	ld	a5,0(s1)
     dea:	4719                	li	a4,6
     dec:	dfb8                	sw	a4,120(a5)
    tsched();
     dee:	00000097          	auipc	ra,0x0
     df2:	f5e080e7          	jalr	-162(ra) # d4c <tsched>
}
     df6:	60e2                	ld	ra,24(sp)
     df8:	6442                	ld	s0,16(sp)
     dfa:	64a2                	ld	s1,8(sp)
     dfc:	6105                	addi	sp,sp,32
     dfe:	8082                	ret

0000000000000e00 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     e00:	7179                	addi	sp,sp,-48
     e02:	f406                	sd	ra,40(sp)
     e04:	f022                	sd	s0,32(sp)
     e06:	ec26                	sd	s1,24(sp)
     e08:	e84a                	sd	s2,16(sp)
     e0a:	e44e                	sd	s3,8(sp)
     e0c:	1800                	addi	s0,sp,48
     e0e:	84aa                	mv	s1,a0
     e10:	89b2                	mv	s3,a2
     e12:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     e14:	09800513          	li	a0,152
     e18:	00001097          	auipc	ra,0x1
     e1c:	892080e7          	jalr	-1902(ra) # 16aa <malloc>
     e20:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     e22:	478d                	li	a5,3
     e24:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     e26:	609c                	ld	a5,0(s1)
     e28:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     e2c:	609c                	ld	a5,0(s1)
     e2e:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
     e32:	6098                	ld	a4,0(s1)
     e34:	00001797          	auipc	a5,0x1
     e38:	1dc78793          	addi	a5,a5,476 # 2010 <next_tid>
     e3c:	4394                	lw	a3,0(a5)
     e3e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
     e42:	4398                	lw	a4,0(a5)
     e44:	2705                	addiw	a4,a4,1
     e46:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
     e48:	6505                	lui	a0,0x1
     e4a:	00001097          	auipc	ra,0x1
     e4e:	860080e7          	jalr	-1952(ra) # 16aa <malloc>
     e52:	609c                	ld	a5,0(s1)
     e54:	6705                	lui	a4,0x1
     e56:	953a                	add	a0,a0,a4
     e58:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
     e5a:	609c                	ld	a5,0(s1)
     e5c:	00000717          	auipc	a4,0x0
     e60:	f7270713          	addi	a4,a4,-142 # dce <thread_wrapper>
     e64:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
     e66:	00001717          	auipc	a4,0x1
     e6a:	24270713          	addi	a4,a4,578 # 20a8 <threads>
     e6e:	4781                	li	a5,0
     e70:	4641                	li	a2,16
        if (threads[i] == NULL) {
     e72:	6314                	ld	a3,0(a4)
     e74:	ce81                	beqz	a3,e8c <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
     e76:	2785                	addiw	a5,a5,1
     e78:	0721                	addi	a4,a4,8
     e7a:	fec79ce3          	bne	a5,a2,e72 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
     e7e:	70a2                	ld	ra,40(sp)
     e80:	7402                	ld	s0,32(sp)
     e82:	64e2                	ld	s1,24(sp)
     e84:	6942                	ld	s2,16(sp)
     e86:	69a2                	ld	s3,8(sp)
     e88:	6145                	addi	sp,sp,48
     e8a:	8082                	ret
            threads[i] = *thread;
     e8c:	6094                	ld	a3,0(s1)
     e8e:	078e                	slli	a5,a5,0x3
     e90:	00001717          	auipc	a4,0x1
     e94:	21870713          	addi	a4,a4,536 # 20a8 <threads>
     e98:	97ba                	add	a5,a5,a4
     e9a:	e394                	sd	a3,0(a5)
            break;
     e9c:	b7cd                	j	e7e <tcreate+0x7e>

0000000000000e9e <tyield>:
    return 0;
}


void tyield()
{
     e9e:	1141                	addi	sp,sp,-16
     ea0:	e406                	sd	ra,8(sp)
     ea2:	e022                	sd	s0,0(sp)
     ea4:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
     ea6:	00001797          	auipc	a5,0x1
     eaa:	17a7b783          	ld	a5,378(a5) # 2020 <current_thread>
     eae:	470d                	li	a4,3
     eb0:	dfb8                	sw	a4,120(a5)
    tsched();
     eb2:	00000097          	auipc	ra,0x0
     eb6:	e9a080e7          	jalr	-358(ra) # d4c <tsched>
}
     eba:	60a2                	ld	ra,8(sp)
     ebc:	6402                	ld	s0,0(sp)
     ebe:	0141                	addi	sp,sp,16
     ec0:	8082                	ret

0000000000000ec2 <tjoin>:
{
     ec2:	1101                	addi	sp,sp,-32
     ec4:	ec06                	sd	ra,24(sp)
     ec6:	e822                	sd	s0,16(sp)
     ec8:	e426                	sd	s1,8(sp)
     eca:	e04a                	sd	s2,0(sp)
     ecc:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
     ece:	00001797          	auipc	a5,0x1
     ed2:	1da78793          	addi	a5,a5,474 # 20a8 <threads>
     ed6:	00001697          	auipc	a3,0x1
     eda:	25268693          	addi	a3,a3,594 # 2128 <base>
     ede:	a021                	j	ee6 <tjoin+0x24>
     ee0:	07a1                	addi	a5,a5,8
     ee2:	02d78b63          	beq	a5,a3,f18 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
     ee6:	6384                	ld	s1,0(a5)
     ee8:	dce5                	beqz	s1,ee0 <tjoin+0x1e>
     eea:	0004c703          	lbu	a4,0(s1)
     eee:	fea719e3          	bne	a4,a0,ee0 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
     ef2:	5cb8                	lw	a4,120(s1)
     ef4:	4799                	li	a5,6
     ef6:	4919                	li	s2,6
     ef8:	02f70263          	beq	a4,a5,f1c <tjoin+0x5a>
        tyield();
     efc:	00000097          	auipc	ra,0x0
     f00:	fa2080e7          	jalr	-94(ra) # e9e <tyield>
    while (target_thread->state != EXITED) {
     f04:	5cbc                	lw	a5,120(s1)
     f06:	ff279be3          	bne	a5,s2,efc <tjoin+0x3a>
    return 0;
     f0a:	4501                	li	a0,0
}
     f0c:	60e2                	ld	ra,24(sp)
     f0e:	6442                	ld	s0,16(sp)
     f10:	64a2                	ld	s1,8(sp)
     f12:	6902                	ld	s2,0(sp)
     f14:	6105                	addi	sp,sp,32
     f16:	8082                	ret
        return -1;
     f18:	557d                	li	a0,-1
     f1a:	bfcd                	j	f0c <tjoin+0x4a>
    return 0;
     f1c:	4501                	li	a0,0
     f1e:	b7fd                	j	f0c <tjoin+0x4a>

0000000000000f20 <twhoami>:

uint8 twhoami()
{
     f20:	1141                	addi	sp,sp,-16
     f22:	e422                	sd	s0,8(sp)
     f24:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
     f26:	00001797          	auipc	a5,0x1
     f2a:	0fa7b783          	ld	a5,250(a5) # 2020 <current_thread>
     f2e:	0007c503          	lbu	a0,0(a5)
     f32:	6422                	ld	s0,8(sp)
     f34:	0141                	addi	sp,sp,16
     f36:	8082                	ret

0000000000000f38 <tswtch>:
     f38:	00153023          	sd	ra,0(a0) # 1000 <_main+0x5e>
     f3c:	00253423          	sd	sp,8(a0)
     f40:	e900                	sd	s0,16(a0)
     f42:	ed04                	sd	s1,24(a0)
     f44:	03253023          	sd	s2,32(a0)
     f48:	03353423          	sd	s3,40(a0)
     f4c:	03453823          	sd	s4,48(a0)
     f50:	03553c23          	sd	s5,56(a0)
     f54:	05653023          	sd	s6,64(a0)
     f58:	05753423          	sd	s7,72(a0)
     f5c:	05853823          	sd	s8,80(a0)
     f60:	05953c23          	sd	s9,88(a0)
     f64:	07a53023          	sd	s10,96(a0)
     f68:	07b53423          	sd	s11,104(a0)
     f6c:	0005b083          	ld	ra,0(a1)
     f70:	0085b103          	ld	sp,8(a1)
     f74:	6980                	ld	s0,16(a1)
     f76:	6d84                	ld	s1,24(a1)
     f78:	0205b903          	ld	s2,32(a1)
     f7c:	0285b983          	ld	s3,40(a1)
     f80:	0305ba03          	ld	s4,48(a1)
     f84:	0385ba83          	ld	s5,56(a1)
     f88:	0405bb03          	ld	s6,64(a1)
     f8c:	0485bb83          	ld	s7,72(a1)
     f90:	0505bc03          	ld	s8,80(a1)
     f94:	0585bc83          	ld	s9,88(a1)
     f98:	0605bd03          	ld	s10,96(a1)
     f9c:	0685bd83          	ld	s11,104(a1)
     fa0:	8082                	ret

0000000000000fa2 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     fa2:	1101                	addi	sp,sp,-32
     fa4:	ec06                	sd	ra,24(sp)
     fa6:	e822                	sd	s0,16(sp)
     fa8:	e426                	sd	s1,8(sp)
     faa:	e04a                	sd	s2,0(sp)
     fac:	1000                	addi	s0,sp,32
     fae:	84aa                	mv	s1,a0
     fb0:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     fb2:	09800513          	li	a0,152
     fb6:	00000097          	auipc	ra,0x0
     fba:	6f4080e7          	jalr	1780(ra) # 16aa <malloc>

    main_thread->tid = 1;
     fbe:	4785                	li	a5,1
     fc0:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
     fc4:	4791                	li	a5,4
     fc6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     fc8:	00001797          	auipc	a5,0x1
     fcc:	04a7bc23          	sd	a0,88(a5) # 2020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
     fd0:	00001797          	auipc	a5,0x1
     fd4:	0d878793          	addi	a5,a5,216 # 20a8 <threads>
     fd8:	00001717          	auipc	a4,0x1
     fdc:	15070713          	addi	a4,a4,336 # 2128 <base>
        threads[i] = NULL;
     fe0:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
     fe4:	07a1                	addi	a5,a5,8
     fe6:	fee79de3          	bne	a5,a4,fe0 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
     fea:	00001797          	auipc	a5,0x1
     fee:	0aa7bf23          	sd	a0,190(a5) # 20a8 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
     ff2:	85ca                	mv	a1,s2
     ff4:	8526                	mv	a0,s1
     ff6:	00000097          	auipc	ra,0x0
     ffa:	b50080e7          	jalr	-1200(ra) # b46 <main>
    //tsched();

    exit(res);
     ffe:	00000097          	auipc	ra,0x0
    1002:	274080e7          	jalr	628(ra) # 1272 <exit>

0000000000001006 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    1006:	1141                	addi	sp,sp,-16
    1008:	e422                	sd	s0,8(sp)
    100a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    100c:	87aa                	mv	a5,a0
    100e:	0585                	addi	a1,a1,1
    1010:	0785                	addi	a5,a5,1
    1012:	fff5c703          	lbu	a4,-1(a1)
    1016:	fee78fa3          	sb	a4,-1(a5)
    101a:	fb75                	bnez	a4,100e <strcpy+0x8>
        ;
    return os;
}
    101c:	6422                	ld	s0,8(sp)
    101e:	0141                	addi	sp,sp,16
    1020:	8082                	ret

0000000000001022 <strcmp>:

int strcmp(const char *p, const char *q)
{
    1022:	1141                	addi	sp,sp,-16
    1024:	e422                	sd	s0,8(sp)
    1026:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    1028:	00054783          	lbu	a5,0(a0)
    102c:	cb91                	beqz	a5,1040 <strcmp+0x1e>
    102e:	0005c703          	lbu	a4,0(a1)
    1032:	00f71763          	bne	a4,a5,1040 <strcmp+0x1e>
        p++, q++;
    1036:	0505                	addi	a0,a0,1
    1038:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    103a:	00054783          	lbu	a5,0(a0)
    103e:	fbe5                	bnez	a5,102e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    1040:	0005c503          	lbu	a0,0(a1)
}
    1044:	40a7853b          	subw	a0,a5,a0
    1048:	6422                	ld	s0,8(sp)
    104a:	0141                	addi	sp,sp,16
    104c:	8082                	ret

000000000000104e <strlen>:

uint strlen(const char *s)
{
    104e:	1141                	addi	sp,sp,-16
    1050:	e422                	sd	s0,8(sp)
    1052:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    1054:	00054783          	lbu	a5,0(a0)
    1058:	cf91                	beqz	a5,1074 <strlen+0x26>
    105a:	0505                	addi	a0,a0,1
    105c:	87aa                	mv	a5,a0
    105e:	86be                	mv	a3,a5
    1060:	0785                	addi	a5,a5,1
    1062:	fff7c703          	lbu	a4,-1(a5)
    1066:	ff65                	bnez	a4,105e <strlen+0x10>
    1068:	40a6853b          	subw	a0,a3,a0
    106c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    106e:	6422                	ld	s0,8(sp)
    1070:	0141                	addi	sp,sp,16
    1072:	8082                	ret
    for (n = 0; s[n]; n++)
    1074:	4501                	li	a0,0
    1076:	bfe5                	j	106e <strlen+0x20>

0000000000001078 <memset>:

void *
memset(void *dst, int c, uint n)
{
    1078:	1141                	addi	sp,sp,-16
    107a:	e422                	sd	s0,8(sp)
    107c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    107e:	ca19                	beqz	a2,1094 <memset+0x1c>
    1080:	87aa                	mv	a5,a0
    1082:	1602                	slli	a2,a2,0x20
    1084:	9201                	srli	a2,a2,0x20
    1086:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    108a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    108e:	0785                	addi	a5,a5,1
    1090:	fee79de3          	bne	a5,a4,108a <memset+0x12>
    }
    return dst;
}
    1094:	6422                	ld	s0,8(sp)
    1096:	0141                	addi	sp,sp,16
    1098:	8082                	ret

000000000000109a <strchr>:

char *
strchr(const char *s, char c)
{
    109a:	1141                	addi	sp,sp,-16
    109c:	e422                	sd	s0,8(sp)
    109e:	0800                	addi	s0,sp,16
    for (; *s; s++)
    10a0:	00054783          	lbu	a5,0(a0)
    10a4:	cb99                	beqz	a5,10ba <strchr+0x20>
        if (*s == c)
    10a6:	00f58763          	beq	a1,a5,10b4 <strchr+0x1a>
    for (; *s; s++)
    10aa:	0505                	addi	a0,a0,1
    10ac:	00054783          	lbu	a5,0(a0)
    10b0:	fbfd                	bnez	a5,10a6 <strchr+0xc>
            return (char *)s;
    return 0;
    10b2:	4501                	li	a0,0
}
    10b4:	6422                	ld	s0,8(sp)
    10b6:	0141                	addi	sp,sp,16
    10b8:	8082                	ret
    return 0;
    10ba:	4501                	li	a0,0
    10bc:	bfe5                	j	10b4 <strchr+0x1a>

00000000000010be <gets>:

char *
gets(char *buf, int max)
{
    10be:	711d                	addi	sp,sp,-96
    10c0:	ec86                	sd	ra,88(sp)
    10c2:	e8a2                	sd	s0,80(sp)
    10c4:	e4a6                	sd	s1,72(sp)
    10c6:	e0ca                	sd	s2,64(sp)
    10c8:	fc4e                	sd	s3,56(sp)
    10ca:	f852                	sd	s4,48(sp)
    10cc:	f456                	sd	s5,40(sp)
    10ce:	f05a                	sd	s6,32(sp)
    10d0:	ec5e                	sd	s7,24(sp)
    10d2:	1080                	addi	s0,sp,96
    10d4:	8baa                	mv	s7,a0
    10d6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    10d8:	892a                	mv	s2,a0
    10da:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    10dc:	4aa9                	li	s5,10
    10de:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    10e0:	89a6                	mv	s3,s1
    10e2:	2485                	addiw	s1,s1,1
    10e4:	0344d863          	bge	s1,s4,1114 <gets+0x56>
        cc = read(0, &c, 1);
    10e8:	4605                	li	a2,1
    10ea:	faf40593          	addi	a1,s0,-81
    10ee:	4501                	li	a0,0
    10f0:	00000097          	auipc	ra,0x0
    10f4:	19a080e7          	jalr	410(ra) # 128a <read>
        if (cc < 1)
    10f8:	00a05e63          	blez	a0,1114 <gets+0x56>
        buf[i++] = c;
    10fc:	faf44783          	lbu	a5,-81(s0)
    1100:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    1104:	01578763          	beq	a5,s5,1112 <gets+0x54>
    1108:	0905                	addi	s2,s2,1
    110a:	fd679be3          	bne	a5,s6,10e0 <gets+0x22>
    for (i = 0; i + 1 < max;)
    110e:	89a6                	mv	s3,s1
    1110:	a011                	j	1114 <gets+0x56>
    1112:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    1114:	99de                	add	s3,s3,s7
    1116:	00098023          	sb	zero,0(s3)
    return buf;
}
    111a:	855e                	mv	a0,s7
    111c:	60e6                	ld	ra,88(sp)
    111e:	6446                	ld	s0,80(sp)
    1120:	64a6                	ld	s1,72(sp)
    1122:	6906                	ld	s2,64(sp)
    1124:	79e2                	ld	s3,56(sp)
    1126:	7a42                	ld	s4,48(sp)
    1128:	7aa2                	ld	s5,40(sp)
    112a:	7b02                	ld	s6,32(sp)
    112c:	6be2                	ld	s7,24(sp)
    112e:	6125                	addi	sp,sp,96
    1130:	8082                	ret

0000000000001132 <stat>:

int stat(const char *n, struct stat *st)
{
    1132:	1101                	addi	sp,sp,-32
    1134:	ec06                	sd	ra,24(sp)
    1136:	e822                	sd	s0,16(sp)
    1138:	e426                	sd	s1,8(sp)
    113a:	e04a                	sd	s2,0(sp)
    113c:	1000                	addi	s0,sp,32
    113e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    1140:	4581                	li	a1,0
    1142:	00000097          	auipc	ra,0x0
    1146:	170080e7          	jalr	368(ra) # 12b2 <open>
    if (fd < 0)
    114a:	02054563          	bltz	a0,1174 <stat+0x42>
    114e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    1150:	85ca                	mv	a1,s2
    1152:	00000097          	auipc	ra,0x0
    1156:	178080e7          	jalr	376(ra) # 12ca <fstat>
    115a:	892a                	mv	s2,a0
    close(fd);
    115c:	8526                	mv	a0,s1
    115e:	00000097          	auipc	ra,0x0
    1162:	13c080e7          	jalr	316(ra) # 129a <close>
    return r;
}
    1166:	854a                	mv	a0,s2
    1168:	60e2                	ld	ra,24(sp)
    116a:	6442                	ld	s0,16(sp)
    116c:	64a2                	ld	s1,8(sp)
    116e:	6902                	ld	s2,0(sp)
    1170:	6105                	addi	sp,sp,32
    1172:	8082                	ret
        return -1;
    1174:	597d                	li	s2,-1
    1176:	bfc5                	j	1166 <stat+0x34>

0000000000001178 <atoi>:

int atoi(const char *s)
{
    1178:	1141                	addi	sp,sp,-16
    117a:	e422                	sd	s0,8(sp)
    117c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    117e:	00054683          	lbu	a3,0(a0)
    1182:	fd06879b          	addiw	a5,a3,-48
    1186:	0ff7f793          	zext.b	a5,a5
    118a:	4625                	li	a2,9
    118c:	02f66863          	bltu	a2,a5,11bc <atoi+0x44>
    1190:	872a                	mv	a4,a0
    n = 0;
    1192:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    1194:	0705                	addi	a4,a4,1
    1196:	0025179b          	slliw	a5,a0,0x2
    119a:	9fa9                	addw	a5,a5,a0
    119c:	0017979b          	slliw	a5,a5,0x1
    11a0:	9fb5                	addw	a5,a5,a3
    11a2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    11a6:	00074683          	lbu	a3,0(a4)
    11aa:	fd06879b          	addiw	a5,a3,-48
    11ae:	0ff7f793          	zext.b	a5,a5
    11b2:	fef671e3          	bgeu	a2,a5,1194 <atoi+0x1c>
    return n;
}
    11b6:	6422                	ld	s0,8(sp)
    11b8:	0141                	addi	sp,sp,16
    11ba:	8082                	ret
    n = 0;
    11bc:	4501                	li	a0,0
    11be:	bfe5                	j	11b6 <atoi+0x3e>

00000000000011c0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    11c0:	1141                	addi	sp,sp,-16
    11c2:	e422                	sd	s0,8(sp)
    11c4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    11c6:	02b57463          	bgeu	a0,a1,11ee <memmove+0x2e>
    {
        while (n-- > 0)
    11ca:	00c05f63          	blez	a2,11e8 <memmove+0x28>
    11ce:	1602                	slli	a2,a2,0x20
    11d0:	9201                	srli	a2,a2,0x20
    11d2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    11d6:	872a                	mv	a4,a0
            *dst++ = *src++;
    11d8:	0585                	addi	a1,a1,1
    11da:	0705                	addi	a4,a4,1
    11dc:	fff5c683          	lbu	a3,-1(a1)
    11e0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    11e4:	fee79ae3          	bne	a5,a4,11d8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    11e8:	6422                	ld	s0,8(sp)
    11ea:	0141                	addi	sp,sp,16
    11ec:	8082                	ret
        dst += n;
    11ee:	00c50733          	add	a4,a0,a2
        src += n;
    11f2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    11f4:	fec05ae3          	blez	a2,11e8 <memmove+0x28>
    11f8:	fff6079b          	addiw	a5,a2,-1
    11fc:	1782                	slli	a5,a5,0x20
    11fe:	9381                	srli	a5,a5,0x20
    1200:	fff7c793          	not	a5,a5
    1204:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    1206:	15fd                	addi	a1,a1,-1
    1208:	177d                	addi	a4,a4,-1
    120a:	0005c683          	lbu	a3,0(a1)
    120e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1212:	fee79ae3          	bne	a5,a4,1206 <memmove+0x46>
    1216:	bfc9                	j	11e8 <memmove+0x28>

0000000000001218 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    1218:	1141                	addi	sp,sp,-16
    121a:	e422                	sd	s0,8(sp)
    121c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    121e:	ca05                	beqz	a2,124e <memcmp+0x36>
    1220:	fff6069b          	addiw	a3,a2,-1
    1224:	1682                	slli	a3,a3,0x20
    1226:	9281                	srli	a3,a3,0x20
    1228:	0685                	addi	a3,a3,1
    122a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    122c:	00054783          	lbu	a5,0(a0)
    1230:	0005c703          	lbu	a4,0(a1)
    1234:	00e79863          	bne	a5,a4,1244 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    1238:	0505                	addi	a0,a0,1
        p2++;
    123a:	0585                	addi	a1,a1,1
    while (n-- > 0)
    123c:	fed518e3          	bne	a0,a3,122c <memcmp+0x14>
    }
    return 0;
    1240:	4501                	li	a0,0
    1242:	a019                	j	1248 <memcmp+0x30>
            return *p1 - *p2;
    1244:	40e7853b          	subw	a0,a5,a4
}
    1248:	6422                	ld	s0,8(sp)
    124a:	0141                	addi	sp,sp,16
    124c:	8082                	ret
    return 0;
    124e:	4501                	li	a0,0
    1250:	bfe5                	j	1248 <memcmp+0x30>

0000000000001252 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1252:	1141                	addi	sp,sp,-16
    1254:	e406                	sd	ra,8(sp)
    1256:	e022                	sd	s0,0(sp)
    1258:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    125a:	00000097          	auipc	ra,0x0
    125e:	f66080e7          	jalr	-154(ra) # 11c0 <memmove>
}
    1262:	60a2                	ld	ra,8(sp)
    1264:	6402                	ld	s0,0(sp)
    1266:	0141                	addi	sp,sp,16
    1268:	8082                	ret

000000000000126a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    126a:	4885                	li	a7,1
 ecall
    126c:	00000073          	ecall
 ret
    1270:	8082                	ret

0000000000001272 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1272:	4889                	li	a7,2
 ecall
    1274:	00000073          	ecall
 ret
    1278:	8082                	ret

000000000000127a <wait>:
.global wait
wait:
 li a7, SYS_wait
    127a:	488d                	li	a7,3
 ecall
    127c:	00000073          	ecall
 ret
    1280:	8082                	ret

0000000000001282 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1282:	4891                	li	a7,4
 ecall
    1284:	00000073          	ecall
 ret
    1288:	8082                	ret

000000000000128a <read>:
.global read
read:
 li a7, SYS_read
    128a:	4895                	li	a7,5
 ecall
    128c:	00000073          	ecall
 ret
    1290:	8082                	ret

0000000000001292 <write>:
.global write
write:
 li a7, SYS_write
    1292:	48c1                	li	a7,16
 ecall
    1294:	00000073          	ecall
 ret
    1298:	8082                	ret

000000000000129a <close>:
.global close
close:
 li a7, SYS_close
    129a:	48d5                	li	a7,21
 ecall
    129c:	00000073          	ecall
 ret
    12a0:	8082                	ret

00000000000012a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
    12a2:	4899                	li	a7,6
 ecall
    12a4:	00000073          	ecall
 ret
    12a8:	8082                	ret

00000000000012aa <exec>:
.global exec
exec:
 li a7, SYS_exec
    12aa:	489d                	li	a7,7
 ecall
    12ac:	00000073          	ecall
 ret
    12b0:	8082                	ret

00000000000012b2 <open>:
.global open
open:
 li a7, SYS_open
    12b2:	48bd                	li	a7,15
 ecall
    12b4:	00000073          	ecall
 ret
    12b8:	8082                	ret

00000000000012ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    12ba:	48c5                	li	a7,17
 ecall
    12bc:	00000073          	ecall
 ret
    12c0:	8082                	ret

00000000000012c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    12c2:	48c9                	li	a7,18
 ecall
    12c4:	00000073          	ecall
 ret
    12c8:	8082                	ret

00000000000012ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    12ca:	48a1                	li	a7,8
 ecall
    12cc:	00000073          	ecall
 ret
    12d0:	8082                	ret

00000000000012d2 <link>:
.global link
link:
 li a7, SYS_link
    12d2:	48cd                	li	a7,19
 ecall
    12d4:	00000073          	ecall
 ret
    12d8:	8082                	ret

00000000000012da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    12da:	48d1                	li	a7,20
 ecall
    12dc:	00000073          	ecall
 ret
    12e0:	8082                	ret

00000000000012e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    12e2:	48a5                	li	a7,9
 ecall
    12e4:	00000073          	ecall
 ret
    12e8:	8082                	ret

00000000000012ea <dup>:
.global dup
dup:
 li a7, SYS_dup
    12ea:	48a9                	li	a7,10
 ecall
    12ec:	00000073          	ecall
 ret
    12f0:	8082                	ret

00000000000012f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    12f2:	48ad                	li	a7,11
 ecall
    12f4:	00000073          	ecall
 ret
    12f8:	8082                	ret

00000000000012fa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    12fa:	48b1                	li	a7,12
 ecall
    12fc:	00000073          	ecall
 ret
    1300:	8082                	ret

0000000000001302 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1302:	48b5                	li	a7,13
 ecall
    1304:	00000073          	ecall
 ret
    1308:	8082                	ret

000000000000130a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    130a:	48b9                	li	a7,14
 ecall
    130c:	00000073          	ecall
 ret
    1310:	8082                	ret

0000000000001312 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1312:	48d9                	li	a7,22
 ecall
    1314:	00000073          	ecall
 ret
    1318:	8082                	ret

000000000000131a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    131a:	48dd                	li	a7,23
 ecall
    131c:	00000073          	ecall
 ret
    1320:	8082                	ret

0000000000001322 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1322:	48e1                	li	a7,24
 ecall
    1324:	00000073          	ecall
 ret
    1328:	8082                	ret

000000000000132a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    132a:	1101                	addi	sp,sp,-32
    132c:	ec06                	sd	ra,24(sp)
    132e:	e822                	sd	s0,16(sp)
    1330:	1000                	addi	s0,sp,32
    1332:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1336:	4605                	li	a2,1
    1338:	fef40593          	addi	a1,s0,-17
    133c:	00000097          	auipc	ra,0x0
    1340:	f56080e7          	jalr	-170(ra) # 1292 <write>
}
    1344:	60e2                	ld	ra,24(sp)
    1346:	6442                	ld	s0,16(sp)
    1348:	6105                	addi	sp,sp,32
    134a:	8082                	ret

000000000000134c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    134c:	7139                	addi	sp,sp,-64
    134e:	fc06                	sd	ra,56(sp)
    1350:	f822                	sd	s0,48(sp)
    1352:	f426                	sd	s1,40(sp)
    1354:	f04a                	sd	s2,32(sp)
    1356:	ec4e                	sd	s3,24(sp)
    1358:	0080                	addi	s0,sp,64
    135a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    135c:	c299                	beqz	a3,1362 <printint+0x16>
    135e:	0805c963          	bltz	a1,13f0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1362:	2581                	sext.w	a1,a1
  neg = 0;
    1364:	4881                	li	a7,0
    1366:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    136a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    136c:	2601                	sext.w	a2,a2
    136e:	00000517          	auipc	a0,0x0
    1372:	62a50513          	addi	a0,a0,1578 # 1998 <digits>
    1376:	883a                	mv	a6,a4
    1378:	2705                	addiw	a4,a4,1
    137a:	02c5f7bb          	remuw	a5,a1,a2
    137e:	1782                	slli	a5,a5,0x20
    1380:	9381                	srli	a5,a5,0x20
    1382:	97aa                	add	a5,a5,a0
    1384:	0007c783          	lbu	a5,0(a5)
    1388:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    138c:	0005879b          	sext.w	a5,a1
    1390:	02c5d5bb          	divuw	a1,a1,a2
    1394:	0685                	addi	a3,a3,1
    1396:	fec7f0e3          	bgeu	a5,a2,1376 <printint+0x2a>
  if(neg)
    139a:	00088c63          	beqz	a7,13b2 <printint+0x66>
    buf[i++] = '-';
    139e:	fd070793          	addi	a5,a4,-48
    13a2:	00878733          	add	a4,a5,s0
    13a6:	02d00793          	li	a5,45
    13aa:	fef70823          	sb	a5,-16(a4)
    13ae:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    13b2:	02e05863          	blez	a4,13e2 <printint+0x96>
    13b6:	fc040793          	addi	a5,s0,-64
    13ba:	00e78933          	add	s2,a5,a4
    13be:	fff78993          	addi	s3,a5,-1
    13c2:	99ba                	add	s3,s3,a4
    13c4:	377d                	addiw	a4,a4,-1
    13c6:	1702                	slli	a4,a4,0x20
    13c8:	9301                	srli	a4,a4,0x20
    13ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    13ce:	fff94583          	lbu	a1,-1(s2)
    13d2:	8526                	mv	a0,s1
    13d4:	00000097          	auipc	ra,0x0
    13d8:	f56080e7          	jalr	-170(ra) # 132a <putc>
  while(--i >= 0)
    13dc:	197d                	addi	s2,s2,-1
    13de:	ff3918e3          	bne	s2,s3,13ce <printint+0x82>
}
    13e2:	70e2                	ld	ra,56(sp)
    13e4:	7442                	ld	s0,48(sp)
    13e6:	74a2                	ld	s1,40(sp)
    13e8:	7902                	ld	s2,32(sp)
    13ea:	69e2                	ld	s3,24(sp)
    13ec:	6121                	addi	sp,sp,64
    13ee:	8082                	ret
    x = -xx;
    13f0:	40b005bb          	negw	a1,a1
    neg = 1;
    13f4:	4885                	li	a7,1
    x = -xx;
    13f6:	bf85                	j	1366 <printint+0x1a>

00000000000013f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    13f8:	715d                	addi	sp,sp,-80
    13fa:	e486                	sd	ra,72(sp)
    13fc:	e0a2                	sd	s0,64(sp)
    13fe:	fc26                	sd	s1,56(sp)
    1400:	f84a                	sd	s2,48(sp)
    1402:	f44e                	sd	s3,40(sp)
    1404:	f052                	sd	s4,32(sp)
    1406:	ec56                	sd	s5,24(sp)
    1408:	e85a                	sd	s6,16(sp)
    140a:	e45e                	sd	s7,8(sp)
    140c:	e062                	sd	s8,0(sp)
    140e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1410:	0005c903          	lbu	s2,0(a1)
    1414:	18090c63          	beqz	s2,15ac <vprintf+0x1b4>
    1418:	8aaa                	mv	s5,a0
    141a:	8bb2                	mv	s7,a2
    141c:	00158493          	addi	s1,a1,1
  state = 0;
    1420:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1422:	02500a13          	li	s4,37
    1426:	4b55                	li	s6,21
    1428:	a839                	j	1446 <vprintf+0x4e>
        putc(fd, c);
    142a:	85ca                	mv	a1,s2
    142c:	8556                	mv	a0,s5
    142e:	00000097          	auipc	ra,0x0
    1432:	efc080e7          	jalr	-260(ra) # 132a <putc>
    1436:	a019                	j	143c <vprintf+0x44>
    } else if(state == '%'){
    1438:	01498d63          	beq	s3,s4,1452 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    143c:	0485                	addi	s1,s1,1
    143e:	fff4c903          	lbu	s2,-1(s1)
    1442:	16090563          	beqz	s2,15ac <vprintf+0x1b4>
    if(state == 0){
    1446:	fe0999e3          	bnez	s3,1438 <vprintf+0x40>
      if(c == '%'){
    144a:	ff4910e3          	bne	s2,s4,142a <vprintf+0x32>
        state = '%';
    144e:	89d2                	mv	s3,s4
    1450:	b7f5                	j	143c <vprintf+0x44>
      if(c == 'd'){
    1452:	13490263          	beq	s2,s4,1576 <vprintf+0x17e>
    1456:	f9d9079b          	addiw	a5,s2,-99
    145a:	0ff7f793          	zext.b	a5,a5
    145e:	12fb6563          	bltu	s6,a5,1588 <vprintf+0x190>
    1462:	f9d9079b          	addiw	a5,s2,-99
    1466:	0ff7f713          	zext.b	a4,a5
    146a:	10eb6f63          	bltu	s6,a4,1588 <vprintf+0x190>
    146e:	00271793          	slli	a5,a4,0x2
    1472:	00000717          	auipc	a4,0x0
    1476:	4ce70713          	addi	a4,a4,1230 # 1940 <malloc+0x296>
    147a:	97ba                	add	a5,a5,a4
    147c:	439c                	lw	a5,0(a5)
    147e:	97ba                	add	a5,a5,a4
    1480:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1482:	008b8913          	addi	s2,s7,8
    1486:	4685                	li	a3,1
    1488:	4629                	li	a2,10
    148a:	000ba583          	lw	a1,0(s7)
    148e:	8556                	mv	a0,s5
    1490:	00000097          	auipc	ra,0x0
    1494:	ebc080e7          	jalr	-324(ra) # 134c <printint>
    1498:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    149a:	4981                	li	s3,0
    149c:	b745                	j	143c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    149e:	008b8913          	addi	s2,s7,8
    14a2:	4681                	li	a3,0
    14a4:	4629                	li	a2,10
    14a6:	000ba583          	lw	a1,0(s7)
    14aa:	8556                	mv	a0,s5
    14ac:	00000097          	auipc	ra,0x0
    14b0:	ea0080e7          	jalr	-352(ra) # 134c <printint>
    14b4:	8bca                	mv	s7,s2
      state = 0;
    14b6:	4981                	li	s3,0
    14b8:	b751                	j	143c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    14ba:	008b8913          	addi	s2,s7,8
    14be:	4681                	li	a3,0
    14c0:	4641                	li	a2,16
    14c2:	000ba583          	lw	a1,0(s7)
    14c6:	8556                	mv	a0,s5
    14c8:	00000097          	auipc	ra,0x0
    14cc:	e84080e7          	jalr	-380(ra) # 134c <printint>
    14d0:	8bca                	mv	s7,s2
      state = 0;
    14d2:	4981                	li	s3,0
    14d4:	b7a5                	j	143c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    14d6:	008b8c13          	addi	s8,s7,8
    14da:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    14de:	03000593          	li	a1,48
    14e2:	8556                	mv	a0,s5
    14e4:	00000097          	auipc	ra,0x0
    14e8:	e46080e7          	jalr	-442(ra) # 132a <putc>
  putc(fd, 'x');
    14ec:	07800593          	li	a1,120
    14f0:	8556                	mv	a0,s5
    14f2:	00000097          	auipc	ra,0x0
    14f6:	e38080e7          	jalr	-456(ra) # 132a <putc>
    14fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    14fc:	00000b97          	auipc	s7,0x0
    1500:	49cb8b93          	addi	s7,s7,1180 # 1998 <digits>
    1504:	03c9d793          	srli	a5,s3,0x3c
    1508:	97de                	add	a5,a5,s7
    150a:	0007c583          	lbu	a1,0(a5)
    150e:	8556                	mv	a0,s5
    1510:	00000097          	auipc	ra,0x0
    1514:	e1a080e7          	jalr	-486(ra) # 132a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1518:	0992                	slli	s3,s3,0x4
    151a:	397d                	addiw	s2,s2,-1
    151c:	fe0914e3          	bnez	s2,1504 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1520:	8be2                	mv	s7,s8
      state = 0;
    1522:	4981                	li	s3,0
    1524:	bf21                	j	143c <vprintf+0x44>
        s = va_arg(ap, char*);
    1526:	008b8993          	addi	s3,s7,8
    152a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    152e:	02090163          	beqz	s2,1550 <vprintf+0x158>
        while(*s != 0){
    1532:	00094583          	lbu	a1,0(s2)
    1536:	c9a5                	beqz	a1,15a6 <vprintf+0x1ae>
          putc(fd, *s);
    1538:	8556                	mv	a0,s5
    153a:	00000097          	auipc	ra,0x0
    153e:	df0080e7          	jalr	-528(ra) # 132a <putc>
          s++;
    1542:	0905                	addi	s2,s2,1
        while(*s != 0){
    1544:	00094583          	lbu	a1,0(s2)
    1548:	f9e5                	bnez	a1,1538 <vprintf+0x140>
        s = va_arg(ap, char*);
    154a:	8bce                	mv	s7,s3
      state = 0;
    154c:	4981                	li	s3,0
    154e:	b5fd                	j	143c <vprintf+0x44>
          s = "(null)";
    1550:	00000917          	auipc	s2,0x0
    1554:	3e890913          	addi	s2,s2,1000 # 1938 <malloc+0x28e>
        while(*s != 0){
    1558:	02800593          	li	a1,40
    155c:	bff1                	j	1538 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    155e:	008b8913          	addi	s2,s7,8
    1562:	000bc583          	lbu	a1,0(s7)
    1566:	8556                	mv	a0,s5
    1568:	00000097          	auipc	ra,0x0
    156c:	dc2080e7          	jalr	-574(ra) # 132a <putc>
    1570:	8bca                	mv	s7,s2
      state = 0;
    1572:	4981                	li	s3,0
    1574:	b5e1                	j	143c <vprintf+0x44>
        putc(fd, c);
    1576:	02500593          	li	a1,37
    157a:	8556                	mv	a0,s5
    157c:	00000097          	auipc	ra,0x0
    1580:	dae080e7          	jalr	-594(ra) # 132a <putc>
      state = 0;
    1584:	4981                	li	s3,0
    1586:	bd5d                	j	143c <vprintf+0x44>
        putc(fd, '%');
    1588:	02500593          	li	a1,37
    158c:	8556                	mv	a0,s5
    158e:	00000097          	auipc	ra,0x0
    1592:	d9c080e7          	jalr	-612(ra) # 132a <putc>
        putc(fd, c);
    1596:	85ca                	mv	a1,s2
    1598:	8556                	mv	a0,s5
    159a:	00000097          	auipc	ra,0x0
    159e:	d90080e7          	jalr	-624(ra) # 132a <putc>
      state = 0;
    15a2:	4981                	li	s3,0
    15a4:	bd61                	j	143c <vprintf+0x44>
        s = va_arg(ap, char*);
    15a6:	8bce                	mv	s7,s3
      state = 0;
    15a8:	4981                	li	s3,0
    15aa:	bd49                	j	143c <vprintf+0x44>
    }
  }
}
    15ac:	60a6                	ld	ra,72(sp)
    15ae:	6406                	ld	s0,64(sp)
    15b0:	74e2                	ld	s1,56(sp)
    15b2:	7942                	ld	s2,48(sp)
    15b4:	79a2                	ld	s3,40(sp)
    15b6:	7a02                	ld	s4,32(sp)
    15b8:	6ae2                	ld	s5,24(sp)
    15ba:	6b42                	ld	s6,16(sp)
    15bc:	6ba2                	ld	s7,8(sp)
    15be:	6c02                	ld	s8,0(sp)
    15c0:	6161                	addi	sp,sp,80
    15c2:	8082                	ret

00000000000015c4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    15c4:	715d                	addi	sp,sp,-80
    15c6:	ec06                	sd	ra,24(sp)
    15c8:	e822                	sd	s0,16(sp)
    15ca:	1000                	addi	s0,sp,32
    15cc:	e010                	sd	a2,0(s0)
    15ce:	e414                	sd	a3,8(s0)
    15d0:	e818                	sd	a4,16(s0)
    15d2:	ec1c                	sd	a5,24(s0)
    15d4:	03043023          	sd	a6,32(s0)
    15d8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    15dc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    15e0:	8622                	mv	a2,s0
    15e2:	00000097          	auipc	ra,0x0
    15e6:	e16080e7          	jalr	-490(ra) # 13f8 <vprintf>
}
    15ea:	60e2                	ld	ra,24(sp)
    15ec:	6442                	ld	s0,16(sp)
    15ee:	6161                	addi	sp,sp,80
    15f0:	8082                	ret

00000000000015f2 <printf>:

void
printf(const char *fmt, ...)
{
    15f2:	711d                	addi	sp,sp,-96
    15f4:	ec06                	sd	ra,24(sp)
    15f6:	e822                	sd	s0,16(sp)
    15f8:	1000                	addi	s0,sp,32
    15fa:	e40c                	sd	a1,8(s0)
    15fc:	e810                	sd	a2,16(s0)
    15fe:	ec14                	sd	a3,24(s0)
    1600:	f018                	sd	a4,32(s0)
    1602:	f41c                	sd	a5,40(s0)
    1604:	03043823          	sd	a6,48(s0)
    1608:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    160c:	00840613          	addi	a2,s0,8
    1610:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1614:	85aa                	mv	a1,a0
    1616:	4505                	li	a0,1
    1618:	00000097          	auipc	ra,0x0
    161c:	de0080e7          	jalr	-544(ra) # 13f8 <vprintf>
}
    1620:	60e2                	ld	ra,24(sp)
    1622:	6442                	ld	s0,16(sp)
    1624:	6125                	addi	sp,sp,96
    1626:	8082                	ret

0000000000001628 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    1628:	1141                	addi	sp,sp,-16
    162a:	e422                	sd	s0,8(sp)
    162c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    162e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1632:	00001797          	auipc	a5,0x1
    1636:	9f67b783          	ld	a5,-1546(a5) # 2028 <freep>
    163a:	a02d                	j	1664 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    163c:	4618                	lw	a4,8(a2)
    163e:	9f2d                	addw	a4,a4,a1
    1640:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    1644:	6398                	ld	a4,0(a5)
    1646:	6310                	ld	a2,0(a4)
    1648:	a83d                	j	1686 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    164a:	ff852703          	lw	a4,-8(a0)
    164e:	9f31                	addw	a4,a4,a2
    1650:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    1652:	ff053683          	ld	a3,-16(a0)
    1656:	a091                	j	169a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1658:	6398                	ld	a4,0(a5)
    165a:	00e7e463          	bltu	a5,a4,1662 <free+0x3a>
    165e:	00e6ea63          	bltu	a3,a4,1672 <free+0x4a>
{
    1662:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1664:	fed7fae3          	bgeu	a5,a3,1658 <free+0x30>
    1668:	6398                	ld	a4,0(a5)
    166a:	00e6e463          	bltu	a3,a4,1672 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    166e:	fee7eae3          	bltu	a5,a4,1662 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    1672:	ff852583          	lw	a1,-8(a0)
    1676:	6390                	ld	a2,0(a5)
    1678:	02059813          	slli	a6,a1,0x20
    167c:	01c85713          	srli	a4,a6,0x1c
    1680:	9736                	add	a4,a4,a3
    1682:	fae60de3          	beq	a2,a4,163c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    1686:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    168a:	4790                	lw	a2,8(a5)
    168c:	02061593          	slli	a1,a2,0x20
    1690:	01c5d713          	srli	a4,a1,0x1c
    1694:	973e                	add	a4,a4,a5
    1696:	fae68ae3          	beq	a3,a4,164a <free+0x22>
        p->s.ptr = bp->s.ptr;
    169a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    169c:	00001717          	auipc	a4,0x1
    16a0:	98f73623          	sd	a5,-1652(a4) # 2028 <freep>
}
    16a4:	6422                	ld	s0,8(sp)
    16a6:	0141                	addi	sp,sp,16
    16a8:	8082                	ret

00000000000016aa <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    16aa:	7139                	addi	sp,sp,-64
    16ac:	fc06                	sd	ra,56(sp)
    16ae:	f822                	sd	s0,48(sp)
    16b0:	f426                	sd	s1,40(sp)
    16b2:	f04a                	sd	s2,32(sp)
    16b4:	ec4e                	sd	s3,24(sp)
    16b6:	e852                	sd	s4,16(sp)
    16b8:	e456                	sd	s5,8(sp)
    16ba:	e05a                	sd	s6,0(sp)
    16bc:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    16be:	02051493          	slli	s1,a0,0x20
    16c2:	9081                	srli	s1,s1,0x20
    16c4:	04bd                	addi	s1,s1,15
    16c6:	8091                	srli	s1,s1,0x4
    16c8:	0014899b          	addiw	s3,s1,1
    16cc:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    16ce:	00001517          	auipc	a0,0x1
    16d2:	95a53503          	ld	a0,-1702(a0) # 2028 <freep>
    16d6:	c515                	beqz	a0,1702 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    16d8:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    16da:	4798                	lw	a4,8(a5)
    16dc:	02977f63          	bgeu	a4,s1,171a <malloc+0x70>
    if (nu < 4096)
    16e0:	8a4e                	mv	s4,s3
    16e2:	0009871b          	sext.w	a4,s3
    16e6:	6685                	lui	a3,0x1
    16e8:	00d77363          	bgeu	a4,a3,16ee <malloc+0x44>
    16ec:	6a05                	lui	s4,0x1
    16ee:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    16f2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    16f6:	00001917          	auipc	s2,0x1
    16fa:	93290913          	addi	s2,s2,-1742 # 2028 <freep>
    if (p == (char *)-1)
    16fe:	5afd                	li	s5,-1
    1700:	a895                	j	1774 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    1702:	00001797          	auipc	a5,0x1
    1706:	a2678793          	addi	a5,a5,-1498 # 2128 <base>
    170a:	00001717          	auipc	a4,0x1
    170e:	90f73f23          	sd	a5,-1762(a4) # 2028 <freep>
    1712:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    1714:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    1718:	b7e1                	j	16e0 <malloc+0x36>
            if (p->s.size == nunits)
    171a:	02e48c63          	beq	s1,a4,1752 <malloc+0xa8>
                p->s.size -= nunits;
    171e:	4137073b          	subw	a4,a4,s3
    1722:	c798                	sw	a4,8(a5)
                p += p->s.size;
    1724:	02071693          	slli	a3,a4,0x20
    1728:	01c6d713          	srli	a4,a3,0x1c
    172c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    172e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    1732:	00001717          	auipc	a4,0x1
    1736:	8ea73b23          	sd	a0,-1802(a4) # 2028 <freep>
            return (void *)(p + 1);
    173a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    173e:	70e2                	ld	ra,56(sp)
    1740:	7442                	ld	s0,48(sp)
    1742:	74a2                	ld	s1,40(sp)
    1744:	7902                	ld	s2,32(sp)
    1746:	69e2                	ld	s3,24(sp)
    1748:	6a42                	ld	s4,16(sp)
    174a:	6aa2                	ld	s5,8(sp)
    174c:	6b02                	ld	s6,0(sp)
    174e:	6121                	addi	sp,sp,64
    1750:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    1752:	6398                	ld	a4,0(a5)
    1754:	e118                	sd	a4,0(a0)
    1756:	bff1                	j	1732 <malloc+0x88>
    hp->s.size = nu;
    1758:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    175c:	0541                	addi	a0,a0,16
    175e:	00000097          	auipc	ra,0x0
    1762:	eca080e7          	jalr	-310(ra) # 1628 <free>
    return freep;
    1766:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    176a:	d971                	beqz	a0,173e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    176c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    176e:	4798                	lw	a4,8(a5)
    1770:	fa9775e3          	bgeu	a4,s1,171a <malloc+0x70>
        if (p == freep)
    1774:	00093703          	ld	a4,0(s2)
    1778:	853e                	mv	a0,a5
    177a:	fef719e3          	bne	a4,a5,176c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    177e:	8552                	mv	a0,s4
    1780:	00000097          	auipc	ra,0x0
    1784:	b7a080e7          	jalr	-1158(ra) # 12fa <sbrk>
    if (p == (char *)-1)
    1788:	fd5518e3          	bne	a0,s5,1758 <malloc+0xae>
                return 0;
    178c:	4501                	li	a0,0
    178e:	bf45                	j	173e <malloc+0x94>
