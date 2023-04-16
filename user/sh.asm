
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
      16:	7fe58593          	addi	a1,a1,2046 # 1810 <malloc+0xf0>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	2ec080e7          	jalr	748(ra) # 1308 <write>
    memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	0c4080e7          	jalr	196(ra) # 10ee <memset>
    gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	0fe080e7          	jalr	254(ra) # 1134 <gets>
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
      64:	7b858593          	addi	a1,a1,1976 # 1818 <malloc+0xf8>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	5d0080e7          	jalr	1488(ra) # 163a <fprintf>
    exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	274080e7          	jalr	628(ra) # 12e8 <exit>

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
      88:	25c080e7          	jalr	604(ra) # 12e0 <fork>
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
      9e:	78650513          	addi	a0,a0,1926 # 1820 <malloc+0x100>
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
      c6:	00002717          	auipc	a4,0x2
      ca:	86670713          	addi	a4,a4,-1946 # 192c <malloc+0x20c>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
        exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	210080e7          	jalr	528(ra) # 12e8 <exit>
        panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	74850513          	addi	a0,a0,1864 # 1828 <malloc+0x108>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
        if (ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
        exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	228080e7          	jalr	552(ra) # 1320 <exec>
        fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	72e58593          	addi	a1,a1,1838 # 1830 <malloc+0x110>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	52e080e7          	jalr	1326(ra) # 163a <fprintf>
    exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	1d2080e7          	jalr	466(ra) # 12e8 <exit>
            exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	1c8080e7          	jalr	456(ra) # 12e8 <exit>
        close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	1e6080e7          	jalr	486(ra) # 1310 <close>
        if (open(rcmd->file, rcmd->mode) < 0)
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	1f2080e7          	jalr	498(ra) # 1328 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
        runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
            fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	6f258593          	addi	a1,a1,1778 # 1840 <malloc+0x120>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	4e2080e7          	jalr	1250(ra) # 163a <fprintf>
            exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	186080e7          	jalr	390(ra) # 12e8 <exit>
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
     184:	170080e7          	jalr	368(ra) # 12f0 <wait>
        runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
        if (pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	162080e7          	jalr	354(ra) # 12f8 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
        if (fork1() == 0)
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	e529                	bnez	a0,1f4 <runcmd+0x14a>
            close(1);
     1ac:	4505                	li	a0,1
     1ae:	00001097          	auipc	ra,0x1
     1b2:	162080e7          	jalr	354(ra) # 1310 <close>
            dup(p[1]);
     1b6:	fdc42503          	lw	a0,-36(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	1a6080e7          	jalr	422(ra) # 1360 <dup>
            close(p[0]);
     1c2:	fd842503          	lw	a0,-40(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	14a080e7          	jalr	330(ra) # 1310 <close>
            close(p[1]);
     1ce:	fdc42503          	lw	a0,-36(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	13e080e7          	jalr	318(ra) # 1310 <close>
            runcmd(pcmd->left);
     1da:	6488                	ld	a0,8(s1)
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ece080e7          	jalr	-306(ra) # aa <runcmd>
            panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	66c50513          	addi	a0,a0,1644 # 1850 <malloc+0x130>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
        if (fork1() == 0)
     1f4:	00000097          	auipc	ra,0x0
     1f8:	e88080e7          	jalr	-376(ra) # 7c <fork1>
     1fc:	ed05                	bnez	a0,234 <runcmd+0x18a>
            close(0);
     1fe:	00001097          	auipc	ra,0x1
     202:	112080e7          	jalr	274(ra) # 1310 <close>
            dup(p[0]);
     206:	fd842503          	lw	a0,-40(s0)
     20a:	00001097          	auipc	ra,0x1
     20e:	156080e7          	jalr	342(ra) # 1360 <dup>
            close(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	0fa080e7          	jalr	250(ra) # 1310 <close>
            close(p[1]);
     21e:	fdc42503          	lw	a0,-36(s0)
     222:	00001097          	auipc	ra,0x1
     226:	0ee080e7          	jalr	238(ra) # 1310 <close>
            runcmd(pcmd->right);
     22a:	6888                	ld	a0,16(s1)
     22c:	00000097          	auipc	ra,0x0
     230:	e7e080e7          	jalr	-386(ra) # aa <runcmd>
        close(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	0d8080e7          	jalr	216(ra) # 1310 <close>
        close(p[1]);
     240:	fdc42503          	lw	a0,-36(s0)
     244:	00001097          	auipc	ra,0x1
     248:	0cc080e7          	jalr	204(ra) # 1310 <close>
        wait(0);
     24c:	4501                	li	a0,0
     24e:	00001097          	auipc	ra,0x1
     252:	0a2080e7          	jalr	162(ra) # 12f0 <wait>
        wait(0);
     256:	4501                	li	a0,0
     258:	00001097          	auipc	ra,0x1
     25c:	098080e7          	jalr	152(ra) # 12f0 <wait>
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
     28a:	49a080e7          	jalr	1178(ra) # 1720 <malloc>
     28e:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	e58080e7          	jalr	-424(ra) # 10ee <memset>
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
     2d4:	450080e7          	jalr	1104(ra) # 1720 <malloc>
     2d8:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	e0e080e7          	jalr	-498(ra) # 10ee <memset>
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
     32e:	3f6080e7          	jalr	1014(ra) # 1720 <malloc>
     332:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	db6080e7          	jalr	-586(ra) # 10ee <memset>
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
     374:	3b0080e7          	jalr	944(ra) # 1720 <malloc>
     378:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	d70080e7          	jalr	-656(ra) # 10ee <memset>
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
     3b6:	36e080e7          	jalr	878(ra) # 1720 <malloc>
     3ba:	84aa                	mv	s1,a0
    memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	d2e080e7          	jalr	-722(ra) # 10ee <memset>
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
     412:	d02080e7          	jalr	-766(ra) # 1110 <strchr>
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
     478:	c9c080e7          	jalr	-868(ra) # 1110 <strchr>
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
     4ec:	c28080e7          	jalr	-984(ra) # 1110 <strchr>
     4f0:	e50d                	bnez	a0,51a <gettoken+0x13c>
     4f2:	0004c583          	lbu	a1,0(s1)
     4f6:	8556                	mv	a0,s5
     4f8:	00001097          	auipc	ra,0x1
     4fc:	c18080e7          	jalr	-1000(ra) # 1110 <strchr>
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
     55a:	bba080e7          	jalr	-1094(ra) # 1110 <strchr>
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
     58c:	b88080e7          	jalr	-1144(ra) # 1110 <strchr>
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
     5ba:	2c2b8b93          	addi	s7,s7,706 # 1878 <malloc+0x158>
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
     5cc:	29050513          	addi	a0,a0,656 # 1858 <malloc+0x138>
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
     6b4:	1d060613          	addi	a2,a2,464 # 1880 <malloc+0x160>
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
     6e4:	1c0b0b13          	addi	s6,s6,448 # 18a0 <malloc+0x180>
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
     71e:	16e50513          	addi	a0,a0,366 # 1888 <malloc+0x168>
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
     780:	11450513          	addi	a0,a0,276 # 1890 <malloc+0x170>
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
     7ba:	0f260613          	addi	a2,a2,242 # 18a8 <malloc+0x188>
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
     82a:	08aa0a13          	addi	s4,s4,138 # 18b0 <malloc+0x190>
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
     860:	05c60613          	addi	a2,a2,92 # 18b8 <malloc+0x198>
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
     8c6:	fbe60613          	addi	a2,a2,-66 # 1880 <malloc+0x160>
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
     8f6:	fde60613          	addi	a2,a2,-34 # 18d0 <malloc+0x1b0>
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
     938:	f8c50513          	addi	a0,a0,-116 # 18c0 <malloc+0x1a0>
     93c:	fffff097          	auipc	ra,0xfffff
     940:	71a080e7          	jalr	1818(ra) # 56 <panic>
        panic("syntax - missing )");
     944:	00001517          	auipc	a0,0x1
     948:	f9450513          	addi	a0,a0,-108 # 18d8 <malloc+0x1b8>
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
     974:	fd470713          	addi	a4,a4,-44 # 1944 <malloc+0x224>
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
     a02:	6c6080e7          	jalr	1734(ra) # 10c4 <strlen>
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
     a20:	03c60613          	addi	a2,a2,60 # 1a58 <malloc+0x338>
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
     a56:	e9e58593          	addi	a1,a1,-354 # 18f0 <malloc+0x1d0>
     a5a:	4509                	li	a0,2
     a5c:	00001097          	auipc	ra,0x1
     a60:	bde080e7          	jalr	-1058(ra) # 163a <fprintf>
        panic("syntax");
     a64:	00001517          	auipc	a0,0x1
     a68:	e2450513          	addi	a0,a0,-476 # 1888 <malloc+0x168>
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
     aac:	00001097          	auipc	ra,0x1
     ab0:	844080e7          	jalr	-1980(ra) # 12f0 <wait>
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
     ada:	5ee080e7          	jalr	1518(ra) # 10c4 <strlen>
     ade:	fff5079b          	addiw	a5,a0,-1
     ae2:	1782                	slli	a5,a5,0x20
     ae4:	9381                	srli	a5,a5,0x20
     ae6:	97a6                	add	a5,a5,s1
     ae8:	00078023          	sb	zero,0(a5)
        if (chdir(buf + 3) < 0)
     aec:	048d                	addi	s1,s1,3
     aee:	8526                	mv	a0,s1
     af0:	00001097          	auipc	ra,0x1
     af4:	868080e7          	jalr	-1944(ra) # 1358 <chdir>
     af8:	fa055ee3          	bgez	a0,ab4 <parse_buffer+0x40>
            fprintf(2, "cannot cd %s\n", buf + 3);
     afc:	8626                	mv	a2,s1
     afe:	00001597          	auipc	a1,0x1
     b02:	e0258593          	addi	a1,a1,-510 # 1900 <malloc+0x1e0>
     b06:	4509                	li	a0,2
     b08:	00001097          	auipc	ra,0x1
     b0c:	b32080e7          	jalr	-1230(ra) # 163a <fprintf>
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
     b30:	7bc080e7          	jalr	1980(ra) # 12e8 <exit>
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
     b5c:	db848493          	addi	s1,s1,-584 # 1910 <malloc+0x1f0>
     b60:	4589                	li	a1,2
     b62:	8526                	mv	a0,s1
     b64:	00000097          	auipc	ra,0x0
     b68:	7c4080e7          	jalr	1988(ra) # 1328 <open>
     b6c:	00054963          	bltz	a0,b7e <main+0x38>
        if (fd >= 3)
     b70:	4789                	li	a5,2
     b72:	fea7d7e3          	bge	a5,a0,b60 <main+0x1a>
            close(fd);
     b76:	00000097          	auipc	ra,0x0
     b7a:	79a080e7          	jalr	1946(ra) # 1310 <close>
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
     b98:	794080e7          	jalr	1940(ra) # 1328 <open>
     b9c:	892a                	mv	s2,a0
        if (shfd < 0)
     b9e:	04054663          	bltz	a0,bea <main+0xa4>
        read(shfd, buf, sizeof(buf));
     ba2:	07800613          	li	a2,120
     ba6:	00001597          	auipc	a1,0x1
     baa:	48a58593          	addi	a1,a1,1162 # 2030 <buf.0>
     bae:	00000097          	auipc	ra,0x0
     bb2:	752080e7          	jalr	1874(ra) # 1300 <read>
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
     bd4:	730080e7          	jalr	1840(ra) # 1300 <read>
     bd8:	07800793          	li	a5,120
     bdc:	fef501e3          	beq	a0,a5,bbe <main+0x78>
        exit(0);
     be0:	4501                	li	a0,0
     be2:	00000097          	auipc	ra,0x0
     be6:	706080e7          	jalr	1798(ra) # 12e8 <exit>
            printf("Failed to open %s\n", shell_script_file);
     bea:	85a6                	mv	a1,s1
     bec:	00001517          	auipc	a0,0x1
     bf0:	d2c50513          	addi	a0,a0,-724 # 1918 <malloc+0x1f8>
     bf4:	00001097          	auipc	ra,0x1
     bf8:	a74080e7          	jalr	-1420(ra) # 1668 <printf>
            exit(1);
     bfc:	4505                	li	a0,1
     bfe:	00000097          	auipc	ra,0x0
     c02:	6ea080e7          	jalr	1770(ra) # 12e8 <exit>
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
     c28:	6c4080e7          	jalr	1732(ra) # 12e8 <exit>

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
     c60:	2dc080e7          	jalr	732(ra) # f38 <twhoami>
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
     cac:	cb850513          	addi	a0,a0,-840 # 1960 <malloc+0x240>
     cb0:	00001097          	auipc	ra,0x1
     cb4:	9b8080e7          	jalr	-1608(ra) # 1668 <printf>
        exit(-1);
     cb8:	557d                	li	a0,-1
     cba:	00000097          	auipc	ra,0x0
     cbe:	62e080e7          	jalr	1582(ra) # 12e8 <exit>
    {
        // give up the cpu for other threads
        tyield();
     cc2:	00000097          	auipc	ra,0x0
     cc6:	252080e7          	jalr	594(ra) # f14 <tyield>
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
     ce0:	25c080e7          	jalr	604(ra) # f38 <twhoami>
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
     d24:	1f4080e7          	jalr	500(ra) # f14 <tyield>
}
     d28:	60e2                	ld	ra,24(sp)
     d2a:	6442                	ld	s0,16(sp)
     d2c:	64a2                	ld	s1,8(sp)
     d2e:	6105                	addi	sp,sp,32
     d30:	8082                	ret
        printf("releasing lock we are not holding");
     d32:	00001517          	auipc	a0,0x1
     d36:	c5650513          	addi	a0,a0,-938 # 1988 <malloc+0x268>
     d3a:	00001097          	auipc	ra,0x1
     d3e:	92e080e7          	jalr	-1746(ra) # 1668 <printf>
        exit(-1);
     d42:	557d                	li	a0,-1
     d44:	00000097          	auipc	ra,0x0
     d48:	5a4080e7          	jalr	1444(ra) # 12e8 <exit>

0000000000000d4c <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
     d4c:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d4e:	00001617          	auipc	a2,0x1
     d52:	35a60613          	addi	a2,a2,858 # 20a8 <threads>
     d56:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
     d58:	45c1                	li	a1,16
     d5a:	a021                	j	d62 <tsched+0x16>
     d5c:	2685                	addiw	a3,a3,1
     d5e:	08b68c63          	beq	a3,a1,df6 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
     d62:	41f6d71b          	sraiw	a4,a3,0x1f
     d66:	01c7571b          	srliw	a4,a4,0x1c
     d6a:	00d707bb          	addw	a5,a4,a3
     d6e:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
     d70:	9f99                	subw	a5,a5,a4
     d72:	078e                	slli	a5,a5,0x3
     d74:	97b2                	add	a5,a5,a2
     d76:	639c                	ld	a5,0(a5)
     d78:	d3f5                	beqz	a5,d5c <tsched+0x10>
     d7a:	5fb8                	lw	a4,120(a5)
     d7c:	fea710e3          	bne	a4,a0,d5c <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
     d80:	00001717          	auipc	a4,0x1
     d84:	32873703          	ld	a4,808(a4) # 20a8 <threads>
     d88:	5f30                	lw	a2,120(a4)
     d8a:	468d                	li	a3,3
     d8c:	06d60363          	beq	a2,a3,df2 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
     d90:	c3a5                	beqz	a5,df0 <tsched+0xa4>
{
     d92:	1101                	addi	sp,sp,-32
     d94:	ec06                	sd	ra,24(sp)
     d96:	e822                	sd	s0,16(sp)
     d98:	e426                	sd	s1,8(sp)
     d9a:	e04a                	sd	s2,0(sp)
     d9c:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
     d9e:	00001497          	auipc	s1,0x1
     da2:	28248493          	addi	s1,s1,642 # 2020 <current_thread>
     da6:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
     daa:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
     dac:	0007c603          	lbu	a2,0(a5)
     db0:	00094583          	lbu	a1,0(s2)
     db4:	00001517          	auipc	a0,0x1
     db8:	bfc50513          	addi	a0,a0,-1028 # 19b0 <malloc+0x290>
     dbc:	00001097          	auipc	ra,0x1
     dc0:	8ac080e7          	jalr	-1876(ra) # 1668 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
     dc4:	608c                	ld	a1,0(s1)
     dc6:	05a1                	addi	a1,a1,8
     dc8:	00890513          	addi	a0,s2,8
     dcc:	00000097          	auipc	ra,0x0
     dd0:	184080e7          	jalr	388(ra) # f50 <tswtch>
        printf("Thread switch complete\n");
     dd4:	00001517          	auipc	a0,0x1
     dd8:	c0450513          	addi	a0,a0,-1020 # 19d8 <malloc+0x2b8>
     ddc:	00001097          	auipc	ra,0x1
     de0:	88c080e7          	jalr	-1908(ra) # 1668 <printf>
    }
}
     de4:	60e2                	ld	ra,24(sp)
     de6:	6442                	ld	s0,16(sp)
     de8:	64a2                	ld	s1,8(sp)
     dea:	6902                	ld	s2,0(sp)
     dec:	6105                	addi	sp,sp,32
     dee:	8082                	ret
     df0:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
     df2:	87ba                	mv	a5,a4
     df4:	bf79                	j	d92 <tsched+0x46>
     df6:	00001797          	auipc	a5,0x1
     dfa:	2b27b783          	ld	a5,690(a5) # 20a8 <threads>
     dfe:	5fb4                	lw	a3,120(a5)
     e00:	470d                	li	a4,3
     e02:	f8e688e3          	beq	a3,a4,d92 <tsched+0x46>
     e06:	8082                	ret

0000000000000e08 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
     e08:	7179                	addi	sp,sp,-48
     e0a:	f406                	sd	ra,40(sp)
     e0c:	f022                	sd	s0,32(sp)
     e0e:	ec26                	sd	s1,24(sp)
     e10:	e84a                	sd	s2,16(sp)
     e12:	e44e                	sd	s3,8(sp)
     e14:	1800                	addi	s0,sp,48
     e16:	84aa                	mv	s1,a0
     e18:	89b2                	mv	s3,a2
     e1a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
     e1c:	09000513          	li	a0,144
     e20:	00001097          	auipc	ra,0x1
     e24:	900080e7          	jalr	-1792(ra) # 1720 <malloc>
     e28:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
     e2a:	478d                	li	a5,3
     e2c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
     e2e:	609c                	ld	a5,0(s1)
     e30:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
     e34:	609c                	ld	a5,0(s1)
     e36:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
     e3a:	00001717          	auipc	a4,0x1
     e3e:	1d670713          	addi	a4,a4,470 # 2010 <next_tid>
     e42:	431c                	lw	a5,0(a4)
     e44:	0017869b          	addiw	a3,a5,1
     e48:	c314                	sw	a3,0(a4)
     e4a:	6098                	ld	a4,0(s1)
     e4c:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
     e50:	00001717          	auipc	a4,0x1
     e54:	25870713          	addi	a4,a4,600 # 20a8 <threads>
     e58:	4781                	li	a5,0
     e5a:	4641                	li	a2,16
    if (threads[i] == NULL) {
     e5c:	6314                	ld	a3,0(a4)
     e5e:	ce81                	beqz	a3,e76 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
     e60:	2785                	addiw	a5,a5,1
     e62:	0721                	addi	a4,a4,8
     e64:	fec79ce3          	bne	a5,a2,e5c <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
     e68:	70a2                	ld	ra,40(sp)
     e6a:	7402                	ld	s0,32(sp)
     e6c:	64e2                	ld	s1,24(sp)
     e6e:	6942                	ld	s2,16(sp)
     e70:	69a2                	ld	s3,8(sp)
     e72:	6145                	addi	sp,sp,48
     e74:	8082                	ret
        threads[i] = *thread;
     e76:	6094                	ld	a3,0(s1)
     e78:	078e                	slli	a5,a5,0x3
     e7a:	00001717          	auipc	a4,0x1
     e7e:	22e70713          	addi	a4,a4,558 # 20a8 <threads>
     e82:	97ba                	add	a5,a5,a4
     e84:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
     e86:	0006c583          	lbu	a1,0(a3)
     e8a:	00001517          	auipc	a0,0x1
     e8e:	b6650513          	addi	a0,a0,-1178 # 19f0 <malloc+0x2d0>
     e92:	00000097          	auipc	ra,0x0
     e96:	7d6080e7          	jalr	2006(ra) # 1668 <printf>
        break;
     e9a:	b7f9                	j	e68 <tcreate+0x60>

0000000000000e9c <tjoin>:

int tjoin(int tid, void *status, uint size)
{
     e9c:	7179                	addi	sp,sp,-48
     e9e:	f406                	sd	ra,40(sp)
     ea0:	f022                	sd	s0,32(sp)
     ea2:	ec26                	sd	s1,24(sp)
     ea4:	e84a                	sd	s2,16(sp)
     ea6:	e44e                	sd	s3,8(sp)
     ea8:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
     eaa:	00001797          	auipc	a5,0x1
     eae:	1fe78793          	addi	a5,a5,510 # 20a8 <threads>
     eb2:	00001697          	auipc	a3,0x1
     eb6:	27668693          	addi	a3,a3,630 # 2128 <base>
     eba:	a021                	j	ec2 <tjoin+0x26>
     ebc:	07a1                	addi	a5,a5,8
     ebe:	04d78763          	beq	a5,a3,f0c <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
     ec2:	6384                	ld	s1,0(a5)
     ec4:	dce5                	beqz	s1,ebc <tjoin+0x20>
     ec6:	0004c703          	lbu	a4,0(s1)
     eca:	fea719e3          	bne	a4,a0,ebc <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
     ece:	5cb8                	lw	a4,120(s1)
     ed0:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     ed2:	00001997          	auipc	s3,0x1
     ed6:	b4e98993          	addi	s3,s3,-1202 # 1a20 <malloc+0x300>
    while (target_thread->state != EXITED) {
     eda:	4919                	li	s2,6
     edc:	02f70a63          	beq	a4,a5,f10 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
     ee0:	0004c583          	lbu	a1,0(s1)
     ee4:	854e                	mv	a0,s3
     ee6:	00000097          	auipc	ra,0x0
     eea:	782080e7          	jalr	1922(ra) # 1668 <printf>
        tsched();
     eee:	00000097          	auipc	ra,0x0
     ef2:	e5e080e7          	jalr	-418(ra) # d4c <tsched>
    while (target_thread->state != EXITED) {
     ef6:	5cbc                	lw	a5,120(s1)
     ef8:	ff2794e3          	bne	a5,s2,ee0 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
     efc:	4501                	li	a0,0
}
     efe:	70a2                	ld	ra,40(sp)
     f00:	7402                	ld	s0,32(sp)
     f02:	64e2                	ld	s1,24(sp)
     f04:	6942                	ld	s2,16(sp)
     f06:	69a2                	ld	s3,8(sp)
     f08:	6145                	addi	sp,sp,48
     f0a:	8082                	ret
        return -1;
     f0c:	557d                	li	a0,-1
     f0e:	bfc5                	j	efe <tjoin+0x62>
    return 0;
     f10:	4501                	li	a0,0
     f12:	b7f5                	j	efe <tjoin+0x62>

0000000000000f14 <tyield>:


void tyield()
{
     f14:	1141                	addi	sp,sp,-16
     f16:	e406                	sd	ra,8(sp)
     f18:	e022                	sd	s0,0(sp)
     f1a:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
     f1c:	00001797          	auipc	a5,0x1
     f20:	1047b783          	ld	a5,260(a5) # 2020 <current_thread>
     f24:	470d                	li	a4,3
     f26:	dfb8                	sw	a4,120(a5)
    tsched();
     f28:	00000097          	auipc	ra,0x0
     f2c:	e24080e7          	jalr	-476(ra) # d4c <tsched>
}
     f30:	60a2                	ld	ra,8(sp)
     f32:	6402                	ld	s0,0(sp)
     f34:	0141                	addi	sp,sp,16
     f36:	8082                	ret

0000000000000f38 <twhoami>:

uint8 twhoami()
{
     f38:	1141                	addi	sp,sp,-16
     f3a:	e422                	sd	s0,8(sp)
     f3c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
     f3e:	00001797          	auipc	a5,0x1
     f42:	0e27b783          	ld	a5,226(a5) # 2020 <current_thread>
     f46:	0007c503          	lbu	a0,0(a5)
     f4a:	6422                	ld	s0,8(sp)
     f4c:	0141                	addi	sp,sp,16
     f4e:	8082                	ret

0000000000000f50 <tswtch>:
     f50:	00153023          	sd	ra,0(a0)
     f54:	00253423          	sd	sp,8(a0)
     f58:	e900                	sd	s0,16(a0)
     f5a:	ed04                	sd	s1,24(a0)
     f5c:	03253023          	sd	s2,32(a0)
     f60:	03353423          	sd	s3,40(a0)
     f64:	03453823          	sd	s4,48(a0)
     f68:	03553c23          	sd	s5,56(a0)
     f6c:	05653023          	sd	s6,64(a0)
     f70:	05753423          	sd	s7,72(a0)
     f74:	05853823          	sd	s8,80(a0)
     f78:	05953c23          	sd	s9,88(a0)
     f7c:	07a53023          	sd	s10,96(a0)
     f80:	07b53423          	sd	s11,104(a0)
     f84:	0005b083          	ld	ra,0(a1)
     f88:	0085b103          	ld	sp,8(a1)
     f8c:	6980                	ld	s0,16(a1)
     f8e:	6d84                	ld	s1,24(a1)
     f90:	0205b903          	ld	s2,32(a1)
     f94:	0285b983          	ld	s3,40(a1)
     f98:	0305ba03          	ld	s4,48(a1)
     f9c:	0385ba83          	ld	s5,56(a1)
     fa0:	0405bb03          	ld	s6,64(a1)
     fa4:	0485bb83          	ld	s7,72(a1)
     fa8:	0505bc03          	ld	s8,80(a1)
     fac:	0585bc83          	ld	s9,88(a1)
     fb0:	0605bd03          	ld	s10,96(a1)
     fb4:	0685bd83          	ld	s11,104(a1)
     fb8:	8082                	ret

0000000000000fba <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
     fba:	715d                	addi	sp,sp,-80
     fbc:	e486                	sd	ra,72(sp)
     fbe:	e0a2                	sd	s0,64(sp)
     fc0:	fc26                	sd	s1,56(sp)
     fc2:	f84a                	sd	s2,48(sp)
     fc4:	f44e                	sd	s3,40(sp)
     fc6:	f052                	sd	s4,32(sp)
     fc8:	ec56                	sd	s5,24(sp)
     fca:	e85a                	sd	s6,16(sp)
     fcc:	e45e                	sd	s7,8(sp)
     fce:	0880                	addi	s0,sp,80
     fd0:	892a                	mv	s2,a0
     fd2:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
     fd4:	00001517          	auipc	a0,0x1
     fd8:	a6c50513          	addi	a0,a0,-1428 # 1a40 <malloc+0x320>
     fdc:	00000097          	auipc	ra,0x0
     fe0:	68c080e7          	jalr	1676(ra) # 1668 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
     fe4:	09000513          	li	a0,144
     fe8:	00000097          	auipc	ra,0x0
     fec:	738080e7          	jalr	1848(ra) # 1720 <malloc>

    main_thread->tid = 0;
     ff0:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
     ff4:	4791                	li	a5,4
     ff6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
     ff8:	00001797          	auipc	a5,0x1
     ffc:	02a7b423          	sd	a0,40(a5) # 2020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
    1000:	00001a17          	auipc	s4,0x1
    1004:	0a8a0a13          	addi	s4,s4,168 # 20a8 <threads>
    1008:	00001497          	auipc	s1,0x1
    100c:	12048493          	addi	s1,s1,288 # 2128 <base>
    current_thread = main_thread;
    1010:	87d2                	mv	a5,s4
        threads[i] = NULL;
    1012:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
    1016:	07a1                	addi	a5,a5,8
    1018:	fe979de3          	bne	a5,s1,1012 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
    101c:	00001797          	auipc	a5,0x1
    1020:	08a7b623          	sd	a0,140(a5) # 20a8 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
    1024:	85ce                	mv	a1,s3
    1026:	854a                	mv	a0,s2
    1028:	00000097          	auipc	ra,0x0
    102c:	b1e080e7          	jalr	-1250(ra) # b46 <main>
    1030:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
    1032:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
    1034:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
    1036:	00001a97          	auipc	s5,0x1
    103a:	a2aa8a93          	addi	s5,s5,-1494 # 1a60 <malloc+0x340>
    103e:	a03d                	j	106c <_main+0xb2>
        for (int i = 0; i < 16; i++) {
    1040:	07a1                	addi	a5,a5,8
    1042:	00978963          	beq	a5,s1,1054 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
    1046:	6398                	ld	a4,0(a5)
    1048:	df65                	beqz	a4,1040 <_main+0x86>
    104a:	5f38                	lw	a4,120(a4)
    104c:	ff370ae3          	beq	a4,s3,1040 <_main+0x86>
                running_threads++;
    1050:	2905                	addiw	s2,s2,1
    1052:	b7fd                	j	1040 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
    1054:	85ca                	mv	a1,s2
    1056:	8556                	mv	a0,s5
    1058:	00000097          	auipc	ra,0x0
    105c:	610080e7          	jalr	1552(ra) # 1668 <printf>
        if (running_threads > 0) {
    1060:	01205963          	blez	s2,1072 <_main+0xb8>
            tsched(); // Schedule another thread to run
    1064:	00000097          	auipc	ra,0x0
    1068:	ce8080e7          	jalr	-792(ra) # d4c <tsched>
    current_thread = main_thread;
    106c:	87d2                	mv	a5,s4
        running_threads = 0;
    106e:	895a                	mv	s2,s6
    1070:	bfd9                	j	1046 <_main+0x8c>
        }
    }

    exit(res);
    1072:	855e                	mv	a0,s7
    1074:	00000097          	auipc	ra,0x0
    1078:	274080e7          	jalr	628(ra) # 12e8 <exit>

000000000000107c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    107c:	1141                	addi	sp,sp,-16
    107e:	e422                	sd	s0,8(sp)
    1080:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1082:	87aa                	mv	a5,a0
    1084:	0585                	addi	a1,a1,1
    1086:	0785                	addi	a5,a5,1
    1088:	fff5c703          	lbu	a4,-1(a1)
    108c:	fee78fa3          	sb	a4,-1(a5)
    1090:	fb75                	bnez	a4,1084 <strcpy+0x8>
        ;
    return os;
}
    1092:	6422                	ld	s0,8(sp)
    1094:	0141                	addi	sp,sp,16
    1096:	8082                	ret

0000000000001098 <strcmp>:

int strcmp(const char *p, const char *q)
{
    1098:	1141                	addi	sp,sp,-16
    109a:	e422                	sd	s0,8(sp)
    109c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    109e:	00054783          	lbu	a5,0(a0)
    10a2:	cb91                	beqz	a5,10b6 <strcmp+0x1e>
    10a4:	0005c703          	lbu	a4,0(a1)
    10a8:	00f71763          	bne	a4,a5,10b6 <strcmp+0x1e>
        p++, q++;
    10ac:	0505                	addi	a0,a0,1
    10ae:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    10b0:	00054783          	lbu	a5,0(a0)
    10b4:	fbe5                	bnez	a5,10a4 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    10b6:	0005c503          	lbu	a0,0(a1)
}
    10ba:	40a7853b          	subw	a0,a5,a0
    10be:	6422                	ld	s0,8(sp)
    10c0:	0141                	addi	sp,sp,16
    10c2:	8082                	ret

00000000000010c4 <strlen>:

uint strlen(const char *s)
{
    10c4:	1141                	addi	sp,sp,-16
    10c6:	e422                	sd	s0,8(sp)
    10c8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    10ca:	00054783          	lbu	a5,0(a0)
    10ce:	cf91                	beqz	a5,10ea <strlen+0x26>
    10d0:	0505                	addi	a0,a0,1
    10d2:	87aa                	mv	a5,a0
    10d4:	86be                	mv	a3,a5
    10d6:	0785                	addi	a5,a5,1
    10d8:	fff7c703          	lbu	a4,-1(a5)
    10dc:	ff65                	bnez	a4,10d4 <strlen+0x10>
    10de:	40a6853b          	subw	a0,a3,a0
    10e2:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    10e4:	6422                	ld	s0,8(sp)
    10e6:	0141                	addi	sp,sp,16
    10e8:	8082                	ret
    for (n = 0; s[n]; n++)
    10ea:	4501                	li	a0,0
    10ec:	bfe5                	j	10e4 <strlen+0x20>

00000000000010ee <memset>:

void *
memset(void *dst, int c, uint n)
{
    10ee:	1141                	addi	sp,sp,-16
    10f0:	e422                	sd	s0,8(sp)
    10f2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
    10f4:	ca19                	beqz	a2,110a <memset+0x1c>
    10f6:	87aa                	mv	a5,a0
    10f8:	1602                	slli	a2,a2,0x20
    10fa:	9201                	srli	a2,a2,0x20
    10fc:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
    1100:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
    1104:	0785                	addi	a5,a5,1
    1106:	fee79de3          	bne	a5,a4,1100 <memset+0x12>
    }
    return dst;
}
    110a:	6422                	ld	s0,8(sp)
    110c:	0141                	addi	sp,sp,16
    110e:	8082                	ret

0000000000001110 <strchr>:

char *
strchr(const char *s, char c)
{
    1110:	1141                	addi	sp,sp,-16
    1112:	e422                	sd	s0,8(sp)
    1114:	0800                	addi	s0,sp,16
    for (; *s; s++)
    1116:	00054783          	lbu	a5,0(a0)
    111a:	cb99                	beqz	a5,1130 <strchr+0x20>
        if (*s == c)
    111c:	00f58763          	beq	a1,a5,112a <strchr+0x1a>
    for (; *s; s++)
    1120:	0505                	addi	a0,a0,1
    1122:	00054783          	lbu	a5,0(a0)
    1126:	fbfd                	bnez	a5,111c <strchr+0xc>
            return (char *)s;
    return 0;
    1128:	4501                	li	a0,0
}
    112a:	6422                	ld	s0,8(sp)
    112c:	0141                	addi	sp,sp,16
    112e:	8082                	ret
    return 0;
    1130:	4501                	li	a0,0
    1132:	bfe5                	j	112a <strchr+0x1a>

0000000000001134 <gets>:

char *
gets(char *buf, int max)
{
    1134:	711d                	addi	sp,sp,-96
    1136:	ec86                	sd	ra,88(sp)
    1138:	e8a2                	sd	s0,80(sp)
    113a:	e4a6                	sd	s1,72(sp)
    113c:	e0ca                	sd	s2,64(sp)
    113e:	fc4e                	sd	s3,56(sp)
    1140:	f852                	sd	s4,48(sp)
    1142:	f456                	sd	s5,40(sp)
    1144:	f05a                	sd	s6,32(sp)
    1146:	ec5e                	sd	s7,24(sp)
    1148:	1080                	addi	s0,sp,96
    114a:	8baa                	mv	s7,a0
    114c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
    114e:	892a                	mv	s2,a0
    1150:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    1152:	4aa9                	li	s5,10
    1154:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
    1156:	89a6                	mv	s3,s1
    1158:	2485                	addiw	s1,s1,1
    115a:	0344d863          	bge	s1,s4,118a <gets+0x56>
        cc = read(0, &c, 1);
    115e:	4605                	li	a2,1
    1160:	faf40593          	addi	a1,s0,-81
    1164:	4501                	li	a0,0
    1166:	00000097          	auipc	ra,0x0
    116a:	19a080e7          	jalr	410(ra) # 1300 <read>
        if (cc < 1)
    116e:	00a05e63          	blez	a0,118a <gets+0x56>
        buf[i++] = c;
    1172:	faf44783          	lbu	a5,-81(s0)
    1176:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    117a:	01578763          	beq	a5,s5,1188 <gets+0x54>
    117e:	0905                	addi	s2,s2,1
    1180:	fd679be3          	bne	a5,s6,1156 <gets+0x22>
    for (i = 0; i + 1 < max;)
    1184:	89a6                	mv	s3,s1
    1186:	a011                	j	118a <gets+0x56>
    1188:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    118a:	99de                	add	s3,s3,s7
    118c:	00098023          	sb	zero,0(s3)
    return buf;
}
    1190:	855e                	mv	a0,s7
    1192:	60e6                	ld	ra,88(sp)
    1194:	6446                	ld	s0,80(sp)
    1196:	64a6                	ld	s1,72(sp)
    1198:	6906                	ld	s2,64(sp)
    119a:	79e2                	ld	s3,56(sp)
    119c:	7a42                	ld	s4,48(sp)
    119e:	7aa2                	ld	s5,40(sp)
    11a0:	7b02                	ld	s6,32(sp)
    11a2:	6be2                	ld	s7,24(sp)
    11a4:	6125                	addi	sp,sp,96
    11a6:	8082                	ret

00000000000011a8 <stat>:

int stat(const char *n, struct stat *st)
{
    11a8:	1101                	addi	sp,sp,-32
    11aa:	ec06                	sd	ra,24(sp)
    11ac:	e822                	sd	s0,16(sp)
    11ae:	e426                	sd	s1,8(sp)
    11b0:	e04a                	sd	s2,0(sp)
    11b2:	1000                	addi	s0,sp,32
    11b4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    11b6:	4581                	li	a1,0
    11b8:	00000097          	auipc	ra,0x0
    11bc:	170080e7          	jalr	368(ra) # 1328 <open>
    if (fd < 0)
    11c0:	02054563          	bltz	a0,11ea <stat+0x42>
    11c4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    11c6:	85ca                	mv	a1,s2
    11c8:	00000097          	auipc	ra,0x0
    11cc:	178080e7          	jalr	376(ra) # 1340 <fstat>
    11d0:	892a                	mv	s2,a0
    close(fd);
    11d2:	8526                	mv	a0,s1
    11d4:	00000097          	auipc	ra,0x0
    11d8:	13c080e7          	jalr	316(ra) # 1310 <close>
    return r;
}
    11dc:	854a                	mv	a0,s2
    11de:	60e2                	ld	ra,24(sp)
    11e0:	6442                	ld	s0,16(sp)
    11e2:	64a2                	ld	s1,8(sp)
    11e4:	6902                	ld	s2,0(sp)
    11e6:	6105                	addi	sp,sp,32
    11e8:	8082                	ret
        return -1;
    11ea:	597d                	li	s2,-1
    11ec:	bfc5                	j	11dc <stat+0x34>

00000000000011ee <atoi>:

int atoi(const char *s)
{
    11ee:	1141                	addi	sp,sp,-16
    11f0:	e422                	sd	s0,8(sp)
    11f2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    11f4:	00054683          	lbu	a3,0(a0)
    11f8:	fd06879b          	addiw	a5,a3,-48
    11fc:	0ff7f793          	zext.b	a5,a5
    1200:	4625                	li	a2,9
    1202:	02f66863          	bltu	a2,a5,1232 <atoi+0x44>
    1206:	872a                	mv	a4,a0
    n = 0;
    1208:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    120a:	0705                	addi	a4,a4,1
    120c:	0025179b          	slliw	a5,a0,0x2
    1210:	9fa9                	addw	a5,a5,a0
    1212:	0017979b          	slliw	a5,a5,0x1
    1216:	9fb5                	addw	a5,a5,a3
    1218:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    121c:	00074683          	lbu	a3,0(a4)
    1220:	fd06879b          	addiw	a5,a3,-48
    1224:	0ff7f793          	zext.b	a5,a5
    1228:	fef671e3          	bgeu	a2,a5,120a <atoi+0x1c>
    return n;
}
    122c:	6422                	ld	s0,8(sp)
    122e:	0141                	addi	sp,sp,16
    1230:	8082                	ret
    n = 0;
    1232:	4501                	li	a0,0
    1234:	bfe5                	j	122c <atoi+0x3e>

0000000000001236 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    1236:	1141                	addi	sp,sp,-16
    1238:	e422                	sd	s0,8(sp)
    123a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
    123c:	02b57463          	bgeu	a0,a1,1264 <memmove+0x2e>
    {
        while (n-- > 0)
    1240:	00c05f63          	blez	a2,125e <memmove+0x28>
    1244:	1602                	slli	a2,a2,0x20
    1246:	9201                	srli	a2,a2,0x20
    1248:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    124c:	872a                	mv	a4,a0
            *dst++ = *src++;
    124e:	0585                	addi	a1,a1,1
    1250:	0705                	addi	a4,a4,1
    1252:	fff5c683          	lbu	a3,-1(a1)
    1256:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    125a:	fee79ae3          	bne	a5,a4,124e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    125e:	6422                	ld	s0,8(sp)
    1260:	0141                	addi	sp,sp,16
    1262:	8082                	ret
        dst += n;
    1264:	00c50733          	add	a4,a0,a2
        src += n;
    1268:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    126a:	fec05ae3          	blez	a2,125e <memmove+0x28>
    126e:	fff6079b          	addiw	a5,a2,-1
    1272:	1782                	slli	a5,a5,0x20
    1274:	9381                	srli	a5,a5,0x20
    1276:	fff7c793          	not	a5,a5
    127a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    127c:	15fd                	addi	a1,a1,-1
    127e:	177d                	addi	a4,a4,-1
    1280:	0005c683          	lbu	a3,0(a1)
    1284:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    1288:	fee79ae3          	bne	a5,a4,127c <memmove+0x46>
    128c:	bfc9                	j	125e <memmove+0x28>

000000000000128e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    128e:	1141                	addi	sp,sp,-16
    1290:	e422                	sd	s0,8(sp)
    1292:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
    1294:	ca05                	beqz	a2,12c4 <memcmp+0x36>
    1296:	fff6069b          	addiw	a3,a2,-1
    129a:	1682                	slli	a3,a3,0x20
    129c:	9281                	srli	a3,a3,0x20
    129e:	0685                	addi	a3,a3,1
    12a0:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
    12a2:	00054783          	lbu	a5,0(a0)
    12a6:	0005c703          	lbu	a4,0(a1)
    12aa:	00e79863          	bne	a5,a4,12ba <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
    12ae:	0505                	addi	a0,a0,1
        p2++;
    12b0:	0585                	addi	a1,a1,1
    while (n-- > 0)
    12b2:	fed518e3          	bne	a0,a3,12a2 <memcmp+0x14>
    }
    return 0;
    12b6:	4501                	li	a0,0
    12b8:	a019                	j	12be <memcmp+0x30>
            return *p1 - *p2;
    12ba:	40e7853b          	subw	a0,a5,a4
}
    12be:	6422                	ld	s0,8(sp)
    12c0:	0141                	addi	sp,sp,16
    12c2:	8082                	ret
    return 0;
    12c4:	4501                	li	a0,0
    12c6:	bfe5                	j	12be <memcmp+0x30>

00000000000012c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    12c8:	1141                	addi	sp,sp,-16
    12ca:	e406                	sd	ra,8(sp)
    12cc:	e022                	sd	s0,0(sp)
    12ce:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    12d0:	00000097          	auipc	ra,0x0
    12d4:	f66080e7          	jalr	-154(ra) # 1236 <memmove>
}
    12d8:	60a2                	ld	ra,8(sp)
    12da:	6402                	ld	s0,0(sp)
    12dc:	0141                	addi	sp,sp,16
    12de:	8082                	ret

00000000000012e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    12e0:	4885                	li	a7,1
 ecall
    12e2:	00000073          	ecall
 ret
    12e6:	8082                	ret

00000000000012e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    12e8:	4889                	li	a7,2
 ecall
    12ea:	00000073          	ecall
 ret
    12ee:	8082                	ret

00000000000012f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    12f0:	488d                	li	a7,3
 ecall
    12f2:	00000073          	ecall
 ret
    12f6:	8082                	ret

00000000000012f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    12f8:	4891                	li	a7,4
 ecall
    12fa:	00000073          	ecall
 ret
    12fe:	8082                	ret

0000000000001300 <read>:
.global read
read:
 li a7, SYS_read
    1300:	4895                	li	a7,5
 ecall
    1302:	00000073          	ecall
 ret
    1306:	8082                	ret

0000000000001308 <write>:
.global write
write:
 li a7, SYS_write
    1308:	48c1                	li	a7,16
 ecall
    130a:	00000073          	ecall
 ret
    130e:	8082                	ret

0000000000001310 <close>:
.global close
close:
 li a7, SYS_close
    1310:	48d5                	li	a7,21
 ecall
    1312:	00000073          	ecall
 ret
    1316:	8082                	ret

0000000000001318 <kill>:
.global kill
kill:
 li a7, SYS_kill
    1318:	4899                	li	a7,6
 ecall
    131a:	00000073          	ecall
 ret
    131e:	8082                	ret

0000000000001320 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1320:	489d                	li	a7,7
 ecall
    1322:	00000073          	ecall
 ret
    1326:	8082                	ret

0000000000001328 <open>:
.global open
open:
 li a7, SYS_open
    1328:	48bd                	li	a7,15
 ecall
    132a:	00000073          	ecall
 ret
    132e:	8082                	ret

0000000000001330 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1330:	48c5                	li	a7,17
 ecall
    1332:	00000073          	ecall
 ret
    1336:	8082                	ret

0000000000001338 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    1338:	48c9                	li	a7,18
 ecall
    133a:	00000073          	ecall
 ret
    133e:	8082                	ret

0000000000001340 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1340:	48a1                	li	a7,8
 ecall
    1342:	00000073          	ecall
 ret
    1346:	8082                	ret

0000000000001348 <link>:
.global link
link:
 li a7, SYS_link
    1348:	48cd                	li	a7,19
 ecall
    134a:	00000073          	ecall
 ret
    134e:	8082                	ret

0000000000001350 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1350:	48d1                	li	a7,20
 ecall
    1352:	00000073          	ecall
 ret
    1356:	8082                	ret

0000000000001358 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1358:	48a5                	li	a7,9
 ecall
    135a:	00000073          	ecall
 ret
    135e:	8082                	ret

0000000000001360 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1360:	48a9                	li	a7,10
 ecall
    1362:	00000073          	ecall
 ret
    1366:	8082                	ret

0000000000001368 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1368:	48ad                	li	a7,11
 ecall
    136a:	00000073          	ecall
 ret
    136e:	8082                	ret

0000000000001370 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1370:	48b1                	li	a7,12
 ecall
    1372:	00000073          	ecall
 ret
    1376:	8082                	ret

0000000000001378 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1378:	48b5                	li	a7,13
 ecall
    137a:	00000073          	ecall
 ret
    137e:	8082                	ret

0000000000001380 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1380:	48b9                	li	a7,14
 ecall
    1382:	00000073          	ecall
 ret
    1386:	8082                	ret

0000000000001388 <ps>:
.global ps
ps:
 li a7, SYS_ps
    1388:	48d9                	li	a7,22
 ecall
    138a:	00000073          	ecall
 ret
    138e:	8082                	ret

0000000000001390 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
    1390:	48dd                	li	a7,23
 ecall
    1392:	00000073          	ecall
 ret
    1396:	8082                	ret

0000000000001398 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
    1398:	48e1                	li	a7,24
 ecall
    139a:	00000073          	ecall
 ret
    139e:	8082                	ret

00000000000013a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    13a0:	1101                	addi	sp,sp,-32
    13a2:	ec06                	sd	ra,24(sp)
    13a4:	e822                	sd	s0,16(sp)
    13a6:	1000                	addi	s0,sp,32
    13a8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    13ac:	4605                	li	a2,1
    13ae:	fef40593          	addi	a1,s0,-17
    13b2:	00000097          	auipc	ra,0x0
    13b6:	f56080e7          	jalr	-170(ra) # 1308 <write>
}
    13ba:	60e2                	ld	ra,24(sp)
    13bc:	6442                	ld	s0,16(sp)
    13be:	6105                	addi	sp,sp,32
    13c0:	8082                	ret

00000000000013c2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13c2:	7139                	addi	sp,sp,-64
    13c4:	fc06                	sd	ra,56(sp)
    13c6:	f822                	sd	s0,48(sp)
    13c8:	f426                	sd	s1,40(sp)
    13ca:	f04a                	sd	s2,32(sp)
    13cc:	ec4e                	sd	s3,24(sp)
    13ce:	0080                	addi	s0,sp,64
    13d0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13d2:	c299                	beqz	a3,13d8 <printint+0x16>
    13d4:	0805c963          	bltz	a1,1466 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13d8:	2581                	sext.w	a1,a1
  neg = 0;
    13da:	4881                	li	a7,0
    13dc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    13e0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    13e2:	2601                	sext.w	a2,a2
    13e4:	00000517          	auipc	a0,0x0
    13e8:	6fc50513          	addi	a0,a0,1788 # 1ae0 <digits>
    13ec:	883a                	mv	a6,a4
    13ee:	2705                	addiw	a4,a4,1
    13f0:	02c5f7bb          	remuw	a5,a1,a2
    13f4:	1782                	slli	a5,a5,0x20
    13f6:	9381                	srli	a5,a5,0x20
    13f8:	97aa                	add	a5,a5,a0
    13fa:	0007c783          	lbu	a5,0(a5)
    13fe:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1402:	0005879b          	sext.w	a5,a1
    1406:	02c5d5bb          	divuw	a1,a1,a2
    140a:	0685                	addi	a3,a3,1
    140c:	fec7f0e3          	bgeu	a5,a2,13ec <printint+0x2a>
  if(neg)
    1410:	00088c63          	beqz	a7,1428 <printint+0x66>
    buf[i++] = '-';
    1414:	fd070793          	addi	a5,a4,-48
    1418:	00878733          	add	a4,a5,s0
    141c:	02d00793          	li	a5,45
    1420:	fef70823          	sb	a5,-16(a4)
    1424:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    1428:	02e05863          	blez	a4,1458 <printint+0x96>
    142c:	fc040793          	addi	a5,s0,-64
    1430:	00e78933          	add	s2,a5,a4
    1434:	fff78993          	addi	s3,a5,-1
    1438:	99ba                	add	s3,s3,a4
    143a:	377d                	addiw	a4,a4,-1
    143c:	1702                	slli	a4,a4,0x20
    143e:	9301                	srli	a4,a4,0x20
    1440:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1444:	fff94583          	lbu	a1,-1(s2)
    1448:	8526                	mv	a0,s1
    144a:	00000097          	auipc	ra,0x0
    144e:	f56080e7          	jalr	-170(ra) # 13a0 <putc>
  while(--i >= 0)
    1452:	197d                	addi	s2,s2,-1
    1454:	ff3918e3          	bne	s2,s3,1444 <printint+0x82>
}
    1458:	70e2                	ld	ra,56(sp)
    145a:	7442                	ld	s0,48(sp)
    145c:	74a2                	ld	s1,40(sp)
    145e:	7902                	ld	s2,32(sp)
    1460:	69e2                	ld	s3,24(sp)
    1462:	6121                	addi	sp,sp,64
    1464:	8082                	ret
    x = -xx;
    1466:	40b005bb          	negw	a1,a1
    neg = 1;
    146a:	4885                	li	a7,1
    x = -xx;
    146c:	bf85                	j	13dc <printint+0x1a>

000000000000146e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    146e:	715d                	addi	sp,sp,-80
    1470:	e486                	sd	ra,72(sp)
    1472:	e0a2                	sd	s0,64(sp)
    1474:	fc26                	sd	s1,56(sp)
    1476:	f84a                	sd	s2,48(sp)
    1478:	f44e                	sd	s3,40(sp)
    147a:	f052                	sd	s4,32(sp)
    147c:	ec56                	sd	s5,24(sp)
    147e:	e85a                	sd	s6,16(sp)
    1480:	e45e                	sd	s7,8(sp)
    1482:	e062                	sd	s8,0(sp)
    1484:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1486:	0005c903          	lbu	s2,0(a1)
    148a:	18090c63          	beqz	s2,1622 <vprintf+0x1b4>
    148e:	8aaa                	mv	s5,a0
    1490:	8bb2                	mv	s7,a2
    1492:	00158493          	addi	s1,a1,1
  state = 0;
    1496:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1498:	02500a13          	li	s4,37
    149c:	4b55                	li	s6,21
    149e:	a839                	j	14bc <vprintf+0x4e>
        putc(fd, c);
    14a0:	85ca                	mv	a1,s2
    14a2:	8556                	mv	a0,s5
    14a4:	00000097          	auipc	ra,0x0
    14a8:	efc080e7          	jalr	-260(ra) # 13a0 <putc>
    14ac:	a019                	j	14b2 <vprintf+0x44>
    } else if(state == '%'){
    14ae:	01498d63          	beq	s3,s4,14c8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    14b2:	0485                	addi	s1,s1,1
    14b4:	fff4c903          	lbu	s2,-1(s1)
    14b8:	16090563          	beqz	s2,1622 <vprintf+0x1b4>
    if(state == 0){
    14bc:	fe0999e3          	bnez	s3,14ae <vprintf+0x40>
      if(c == '%'){
    14c0:	ff4910e3          	bne	s2,s4,14a0 <vprintf+0x32>
        state = '%';
    14c4:	89d2                	mv	s3,s4
    14c6:	b7f5                	j	14b2 <vprintf+0x44>
      if(c == 'd'){
    14c8:	13490263          	beq	s2,s4,15ec <vprintf+0x17e>
    14cc:	f9d9079b          	addiw	a5,s2,-99
    14d0:	0ff7f793          	zext.b	a5,a5
    14d4:	12fb6563          	bltu	s6,a5,15fe <vprintf+0x190>
    14d8:	f9d9079b          	addiw	a5,s2,-99
    14dc:	0ff7f713          	zext.b	a4,a5
    14e0:	10eb6f63          	bltu	s6,a4,15fe <vprintf+0x190>
    14e4:	00271793          	slli	a5,a4,0x2
    14e8:	00000717          	auipc	a4,0x0
    14ec:	5a070713          	addi	a4,a4,1440 # 1a88 <malloc+0x368>
    14f0:	97ba                	add	a5,a5,a4
    14f2:	439c                	lw	a5,0(a5)
    14f4:	97ba                	add	a5,a5,a4
    14f6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    14f8:	008b8913          	addi	s2,s7,8
    14fc:	4685                	li	a3,1
    14fe:	4629                	li	a2,10
    1500:	000ba583          	lw	a1,0(s7)
    1504:	8556                	mv	a0,s5
    1506:	00000097          	auipc	ra,0x0
    150a:	ebc080e7          	jalr	-324(ra) # 13c2 <printint>
    150e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1510:	4981                	li	s3,0
    1512:	b745                	j	14b2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1514:	008b8913          	addi	s2,s7,8
    1518:	4681                	li	a3,0
    151a:	4629                	li	a2,10
    151c:	000ba583          	lw	a1,0(s7)
    1520:	8556                	mv	a0,s5
    1522:	00000097          	auipc	ra,0x0
    1526:	ea0080e7          	jalr	-352(ra) # 13c2 <printint>
    152a:	8bca                	mv	s7,s2
      state = 0;
    152c:	4981                	li	s3,0
    152e:	b751                	j	14b2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    1530:	008b8913          	addi	s2,s7,8
    1534:	4681                	li	a3,0
    1536:	4641                	li	a2,16
    1538:	000ba583          	lw	a1,0(s7)
    153c:	8556                	mv	a0,s5
    153e:	00000097          	auipc	ra,0x0
    1542:	e84080e7          	jalr	-380(ra) # 13c2 <printint>
    1546:	8bca                	mv	s7,s2
      state = 0;
    1548:	4981                	li	s3,0
    154a:	b7a5                	j	14b2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    154c:	008b8c13          	addi	s8,s7,8
    1550:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1554:	03000593          	li	a1,48
    1558:	8556                	mv	a0,s5
    155a:	00000097          	auipc	ra,0x0
    155e:	e46080e7          	jalr	-442(ra) # 13a0 <putc>
  putc(fd, 'x');
    1562:	07800593          	li	a1,120
    1566:	8556                	mv	a0,s5
    1568:	00000097          	auipc	ra,0x0
    156c:	e38080e7          	jalr	-456(ra) # 13a0 <putc>
    1570:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1572:	00000b97          	auipc	s7,0x0
    1576:	56eb8b93          	addi	s7,s7,1390 # 1ae0 <digits>
    157a:	03c9d793          	srli	a5,s3,0x3c
    157e:	97de                	add	a5,a5,s7
    1580:	0007c583          	lbu	a1,0(a5)
    1584:	8556                	mv	a0,s5
    1586:	00000097          	auipc	ra,0x0
    158a:	e1a080e7          	jalr	-486(ra) # 13a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    158e:	0992                	slli	s3,s3,0x4
    1590:	397d                	addiw	s2,s2,-1
    1592:	fe0914e3          	bnez	s2,157a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1596:	8be2                	mv	s7,s8
      state = 0;
    1598:	4981                	li	s3,0
    159a:	bf21                	j	14b2 <vprintf+0x44>
        s = va_arg(ap, char*);
    159c:	008b8993          	addi	s3,s7,8
    15a0:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    15a4:	02090163          	beqz	s2,15c6 <vprintf+0x158>
        while(*s != 0){
    15a8:	00094583          	lbu	a1,0(s2)
    15ac:	c9a5                	beqz	a1,161c <vprintf+0x1ae>
          putc(fd, *s);
    15ae:	8556                	mv	a0,s5
    15b0:	00000097          	auipc	ra,0x0
    15b4:	df0080e7          	jalr	-528(ra) # 13a0 <putc>
          s++;
    15b8:	0905                	addi	s2,s2,1
        while(*s != 0){
    15ba:	00094583          	lbu	a1,0(s2)
    15be:	f9e5                	bnez	a1,15ae <vprintf+0x140>
        s = va_arg(ap, char*);
    15c0:	8bce                	mv	s7,s3
      state = 0;
    15c2:	4981                	li	s3,0
    15c4:	b5fd                	j	14b2 <vprintf+0x44>
          s = "(null)";
    15c6:	00000917          	auipc	s2,0x0
    15ca:	4ba90913          	addi	s2,s2,1210 # 1a80 <malloc+0x360>
        while(*s != 0){
    15ce:	02800593          	li	a1,40
    15d2:	bff1                	j	15ae <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    15d4:	008b8913          	addi	s2,s7,8
    15d8:	000bc583          	lbu	a1,0(s7)
    15dc:	8556                	mv	a0,s5
    15de:	00000097          	auipc	ra,0x0
    15e2:	dc2080e7          	jalr	-574(ra) # 13a0 <putc>
    15e6:	8bca                	mv	s7,s2
      state = 0;
    15e8:	4981                	li	s3,0
    15ea:	b5e1                	j	14b2 <vprintf+0x44>
        putc(fd, c);
    15ec:	02500593          	li	a1,37
    15f0:	8556                	mv	a0,s5
    15f2:	00000097          	auipc	ra,0x0
    15f6:	dae080e7          	jalr	-594(ra) # 13a0 <putc>
      state = 0;
    15fa:	4981                	li	s3,0
    15fc:	bd5d                	j	14b2 <vprintf+0x44>
        putc(fd, '%');
    15fe:	02500593          	li	a1,37
    1602:	8556                	mv	a0,s5
    1604:	00000097          	auipc	ra,0x0
    1608:	d9c080e7          	jalr	-612(ra) # 13a0 <putc>
        putc(fd, c);
    160c:	85ca                	mv	a1,s2
    160e:	8556                	mv	a0,s5
    1610:	00000097          	auipc	ra,0x0
    1614:	d90080e7          	jalr	-624(ra) # 13a0 <putc>
      state = 0;
    1618:	4981                	li	s3,0
    161a:	bd61                	j	14b2 <vprintf+0x44>
        s = va_arg(ap, char*);
    161c:	8bce                	mv	s7,s3
      state = 0;
    161e:	4981                	li	s3,0
    1620:	bd49                	j	14b2 <vprintf+0x44>
    }
  }
}
    1622:	60a6                	ld	ra,72(sp)
    1624:	6406                	ld	s0,64(sp)
    1626:	74e2                	ld	s1,56(sp)
    1628:	7942                	ld	s2,48(sp)
    162a:	79a2                	ld	s3,40(sp)
    162c:	7a02                	ld	s4,32(sp)
    162e:	6ae2                	ld	s5,24(sp)
    1630:	6b42                	ld	s6,16(sp)
    1632:	6ba2                	ld	s7,8(sp)
    1634:	6c02                	ld	s8,0(sp)
    1636:	6161                	addi	sp,sp,80
    1638:	8082                	ret

000000000000163a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    163a:	715d                	addi	sp,sp,-80
    163c:	ec06                	sd	ra,24(sp)
    163e:	e822                	sd	s0,16(sp)
    1640:	1000                	addi	s0,sp,32
    1642:	e010                	sd	a2,0(s0)
    1644:	e414                	sd	a3,8(s0)
    1646:	e818                	sd	a4,16(s0)
    1648:	ec1c                	sd	a5,24(s0)
    164a:	03043023          	sd	a6,32(s0)
    164e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1652:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1656:	8622                	mv	a2,s0
    1658:	00000097          	auipc	ra,0x0
    165c:	e16080e7          	jalr	-490(ra) # 146e <vprintf>
}
    1660:	60e2                	ld	ra,24(sp)
    1662:	6442                	ld	s0,16(sp)
    1664:	6161                	addi	sp,sp,80
    1666:	8082                	ret

0000000000001668 <printf>:

void
printf(const char *fmt, ...)
{
    1668:	711d                	addi	sp,sp,-96
    166a:	ec06                	sd	ra,24(sp)
    166c:	e822                	sd	s0,16(sp)
    166e:	1000                	addi	s0,sp,32
    1670:	e40c                	sd	a1,8(s0)
    1672:	e810                	sd	a2,16(s0)
    1674:	ec14                	sd	a3,24(s0)
    1676:	f018                	sd	a4,32(s0)
    1678:	f41c                	sd	a5,40(s0)
    167a:	03043823          	sd	a6,48(s0)
    167e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1682:	00840613          	addi	a2,s0,8
    1686:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    168a:	85aa                	mv	a1,a0
    168c:	4505                	li	a0,1
    168e:	00000097          	auipc	ra,0x0
    1692:	de0080e7          	jalr	-544(ra) # 146e <vprintf>
}
    1696:	60e2                	ld	ra,24(sp)
    1698:	6442                	ld	s0,16(sp)
    169a:	6125                	addi	sp,sp,96
    169c:	8082                	ret

000000000000169e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
    169e:	1141                	addi	sp,sp,-16
    16a0:	e422                	sd	s0,8(sp)
    16a2:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    16a4:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a8:	00001797          	auipc	a5,0x1
    16ac:	9807b783          	ld	a5,-1664(a5) # 2028 <freep>
    16b0:	a02d                	j	16da <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
    16b2:	4618                	lw	a4,8(a2)
    16b4:	9f2d                	addw	a4,a4,a1
    16b6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    16ba:	6398                	ld	a4,0(a5)
    16bc:	6310                	ld	a2,0(a4)
    16be:	a83d                	j	16fc <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
    16c0:	ff852703          	lw	a4,-8(a0)
    16c4:	9f31                	addw	a4,a4,a2
    16c6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    16c8:	ff053683          	ld	a3,-16(a0)
    16cc:	a091                	j	1710 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16ce:	6398                	ld	a4,0(a5)
    16d0:	00e7e463          	bltu	a5,a4,16d8 <free+0x3a>
    16d4:	00e6ea63          	bltu	a3,a4,16e8 <free+0x4a>
{
    16d8:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16da:	fed7fae3          	bgeu	a5,a3,16ce <free+0x30>
    16de:	6398                	ld	a4,0(a5)
    16e0:	00e6e463          	bltu	a3,a4,16e8 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16e4:	fee7eae3          	bltu	a5,a4,16d8 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
    16e8:	ff852583          	lw	a1,-8(a0)
    16ec:	6390                	ld	a2,0(a5)
    16ee:	02059813          	slli	a6,a1,0x20
    16f2:	01c85713          	srli	a4,a6,0x1c
    16f6:	9736                	add	a4,a4,a3
    16f8:	fae60de3          	beq	a2,a4,16b2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    16fc:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
    1700:	4790                	lw	a2,8(a5)
    1702:	02061593          	slli	a1,a2,0x20
    1706:	01c5d713          	srli	a4,a1,0x1c
    170a:	973e                	add	a4,a4,a5
    170c:	fae68ae3          	beq	a3,a4,16c0 <free+0x22>
        p->s.ptr = bp->s.ptr;
    1710:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
    1712:	00001717          	auipc	a4,0x1
    1716:	90f73b23          	sd	a5,-1770(a4) # 2028 <freep>
}
    171a:	6422                	ld	s0,8(sp)
    171c:	0141                	addi	sp,sp,16
    171e:	8082                	ret

0000000000001720 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
    1720:	7139                	addi	sp,sp,-64
    1722:	fc06                	sd	ra,56(sp)
    1724:	f822                	sd	s0,48(sp)
    1726:	f426                	sd	s1,40(sp)
    1728:	f04a                	sd	s2,32(sp)
    172a:	ec4e                	sd	s3,24(sp)
    172c:	e852                	sd	s4,16(sp)
    172e:	e456                	sd	s5,8(sp)
    1730:	e05a                	sd	s6,0(sp)
    1732:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    1734:	02051493          	slli	s1,a0,0x20
    1738:	9081                	srli	s1,s1,0x20
    173a:	04bd                	addi	s1,s1,15
    173c:	8091                	srli	s1,s1,0x4
    173e:	0014899b          	addiw	s3,s1,1
    1742:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
    1744:	00001517          	auipc	a0,0x1
    1748:	8e453503          	ld	a0,-1820(a0) # 2028 <freep>
    174c:	c515                	beqz	a0,1778 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    174e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
    1750:	4798                	lw	a4,8(a5)
    1752:	02977f63          	bgeu	a4,s1,1790 <malloc+0x70>
    if (nu < 4096)
    1756:	8a4e                	mv	s4,s3
    1758:	0009871b          	sext.w	a4,s3
    175c:	6685                	lui	a3,0x1
    175e:	00d77363          	bgeu	a4,a3,1764 <malloc+0x44>
    1762:	6a05                	lui	s4,0x1
    1764:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    1768:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    176c:	00001917          	auipc	s2,0x1
    1770:	8bc90913          	addi	s2,s2,-1860 # 2028 <freep>
    if (p == (char *)-1)
    1774:	5afd                	li	s5,-1
    1776:	a895                	j	17ea <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
    1778:	00001797          	auipc	a5,0x1
    177c:	9b078793          	addi	a5,a5,-1616 # 2128 <base>
    1780:	00001717          	auipc	a4,0x1
    1784:	8af73423          	sd	a5,-1880(a4) # 2028 <freep>
    1788:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    178a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
    178e:	b7e1                	j	1756 <malloc+0x36>
            if (p->s.size == nunits)
    1790:	02e48c63          	beq	s1,a4,17c8 <malloc+0xa8>
                p->s.size -= nunits;
    1794:	4137073b          	subw	a4,a4,s3
    1798:	c798                	sw	a4,8(a5)
                p += p->s.size;
    179a:	02071693          	slli	a3,a4,0x20
    179e:	01c6d713          	srli	a4,a3,0x1c
    17a2:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    17a4:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    17a8:	00001717          	auipc	a4,0x1
    17ac:	88a73023          	sd	a0,-1920(a4) # 2028 <freep>
            return (void *)(p + 1);
    17b0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
    17b4:	70e2                	ld	ra,56(sp)
    17b6:	7442                	ld	s0,48(sp)
    17b8:	74a2                	ld	s1,40(sp)
    17ba:	7902                	ld	s2,32(sp)
    17bc:	69e2                	ld	s3,24(sp)
    17be:	6a42                	ld	s4,16(sp)
    17c0:	6aa2                	ld	s5,8(sp)
    17c2:	6b02                	ld	s6,0(sp)
    17c4:	6121                	addi	sp,sp,64
    17c6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
    17c8:	6398                	ld	a4,0(a5)
    17ca:	e118                	sd	a4,0(a0)
    17cc:	bff1                	j	17a8 <malloc+0x88>
    hp->s.size = nu;
    17ce:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    17d2:	0541                	addi	a0,a0,16
    17d4:	00000097          	auipc	ra,0x0
    17d8:	eca080e7          	jalr	-310(ra) # 169e <free>
    return freep;
    17dc:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    17e0:	d971                	beqz	a0,17b4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    17e2:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
    17e4:	4798                	lw	a4,8(a5)
    17e6:	fa9775e3          	bgeu	a4,s1,1790 <malloc+0x70>
        if (p == freep)
    17ea:	00093703          	ld	a4,0(s2)
    17ee:	853e                	mv	a0,a5
    17f0:	fef719e3          	bne	a4,a5,17e2 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
    17f4:	8552                	mv	a0,s4
    17f6:	00000097          	auipc	ra,0x0
    17fa:	b7a080e7          	jalr	-1158(ra) # 1370 <sbrk>
    if (p == (char *)-1)
    17fe:	fd5518e3          	bne	a0,s5,17ce <malloc+0xae>
                return 0;
    1802:	4501                	li	a0,0
    1804:	bf45                	j	17b4 <malloc+0x94>
