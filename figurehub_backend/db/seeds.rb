User.create!([
               { name: "admin", nickname: "管理员", kind: 0, password: "hhhhhh" },
               { name: "normal", nickname: "普通人", kind: 1, password: "hhhhhh" },
               { name: "bandai", nickname: "万代", kind: 2, password: "hhhhhh" },
               { name: "eye", nickname: "眼镜厂", kind: 2, password: "hhhhhh" }
             ])
Origin.create!([
                 { name: "fate", kind: 0, info: "Fate（フェイト）是TYPE-MOON原作的系列作品，于2004年1月30日发售的PC平台18禁文字冒险游戏《Fate/stay night》，同时也是TYPE-MOON商业化后初次亮相的作品。由于广受欢迎，吸引了一些作家参与制作，由本篇衍生诸多人气作品。" },
                 { name: "从零开始的异世界生活", kind: 0, info: "《Re：从零开始的异世界生活》是轻小说家长月达平著作，插画家大冢真一郎负责插画，MF文库J所属的轻小说。" },
                 { name: "刀剑神域", kind: 3, info: "《刀剑神域》是川原砾著作、abec负责插画、电击文库所属的轻小说，也是作者继《加速世界》后又一文库化的作品。小说单行本由ASCII Media Works出版，繁体中文版由台湾角川发行，简体中文版由天闻角川发行，并授权爱奇艺轻小说、SF轻小说、咪咕阅读在其平台上发布电子版。" },
                 { name: "约会大作战", kind: 2, info: "《约会大作战》是轻小说家橘公司著作，插画家Tsunako负责插画，富士见Fantasia文库所属的轻小说。" },
                 { name: "虚拟歌手", kind: 0, info: "虚拟歌手并不是真实存在的歌手,而是在电脑上用音乐软件制作的歌手。虚拟歌手当中最有名的就是VOCALOID家族里的虚拟歌手。" }
               ])
Character.create!([
                    { name: "亚斯娜", gender: 2, info: "结城明日奈，轻小说《刀剑神域》及其衍生作品中的女主角。因好奇借用哥哥结城浩一郎的NERvGear进入SAO的网络游戏新手，并用真名取游戏角色名字。卷入了死亡游戏后内心一直恐惧而感到害怕，一直想尽快突破100层回到现实世界，被攻略组称为顶级公会的攻略之鬼，因为和桐人不和而决斗，后开始注意起桐人，直到认识“活在”SAO里的桐谷和人后改变想法，也因此喜欢上桐谷和人并在游戏里结婚。", origin_id: 3 },
                    { name: "初音未来", gender: 2, info: "初音未来（初音ミク/Hatsune Miku），是2007年8月31日由CRYPTON FUTURE MEDIA以Yamaha的VOCALOID系列语音合成程序为基础开发的音源库，音源数据资料采样于日本声优藤田咲。", origin_id: 5 },
                    { name: "吉尔伽美什", gender: 1, info: "最初古代诸神为了抑制人类过度繁衍之后力量的壮大，将人间王族与女神相结合，创造出众神制约人类的“楔子”——吉尔伽美什。是诞生于神与人之间的英雄，拥有“三分之二为神，三分之一为人”的极高神格以及神明与人类的双方视点。", origin_id: 1 },
                    { name: "夜刀神十香", gender: 2, info: "轻小说《约会大作战》及其衍生作品中女主角之一。在五河士道面前现身的第一个精灵，识别代号〈公主（Princess）〉。拥有一头及膝的黑色长发与水晶般不可思议色彩的眼睛。由于每次出现都遭到人类攻击，使她对人类充满恐惧与敌意，但在与士道相遇后逐渐改变她对人的观感，变得非常喜爱人类的世界。个性天然、喜欢士道，在士道和其他女孩子亲密时会吃醋暴走，但在得知士道行动的真意后会宣布支持士道。", origin_id: 4 },
                    { name: "尼禄", gender: 2, info: "尼禄·克劳狄乌斯·凯萨·奥古斯都·日耳曼尼库斯，日本对战游戏《Fate/EXTRA》及其衍生作品中角色。生前为古罗马正式帝政后的第五代皇帝。", origin_id: 1 },
                    { name: "拉姆", gender: 2, info: "拉姆是长月达平所创作的轻小说《Re:从零开始的异世界生活》及其衍生作品的登场角色。曾是鬼族的天才及最强存在，但由于保护妹妹雷姆而失去唯一的角而不能持久战斗，号称“无角的‘鬼神’”。名字取自传说中的大陆米特拉姆。", origin_id: 2 },
                    { name: "时崎狂三", gender: 2, info: "时崎狂三是轻小说《约会大作战》及其衍生作品中的登场角色。是士道所遭遇的唯一没有在初次就封印灵力的“最恶的精灵”，在偶然现身于人间的众多精灵当中，是能够从邻界以自己的意志现身的特异存在，甚至会有意地去杀人。为了有足够的灵力能让<刻刻帝>的“十二之弹”发动，回到三十年前始源精灵的出现并亲自解决她，而不停地杀人和吸收别人的时间。", origin_id: 4 },
                    { name: "玛修", gender: 2, info: "玛修·基列莱特，游戏《Fate/Grand Order》及其衍生作品的登场角色。人理保障机构迦勒底的成员。在执行前往特异点的拟似灵子转移时卷入管制室爆炸奄奄一息，被迦勒底预先准备的从者附身，凭依融合的姿态，被称作「亚从者」。凭依于玛修的英灵留下了自己的灵基与武装「十字大盾」。", origin_id: 1 },
                    { name: "艾米利亚", gender: 2, info: "爱蜜莉雅是轻小说《Re：从零开始的异世界生活》及其衍生作品中的第一女主角。有着银色长发和绀紫瞳的半精灵少女，搭档为大精灵帕克（同时也是爱蜜莉雅父亲般的存在）。露格尼卡王国第42代王位候选人。因其为混血的银发半精灵，和曾经险些毁灭大陆的嫉妒魔女莎缇拉相貌相同，故被许多人所厌恶。", origin_id: 2 },
                    { name: "莉法", gender: 2, info: "桐谷直叶，轻小说《刀剑神域》及其衍生作品中的女主角之一。桐谷和人的表妹，剑道少女，从小毫不间断地挥舞了8年竹刀的努力女孩。自从七岁的时候和人放弃了剑道后，两人之间便逐渐出现很深的代沟。事实上喜欢着桐谷和人，并为了桐人坚持不懈练习剑技。", origin_id: 3 },
                    { name: "莫德雷德", gender: 2, info: "莫德雷德是圆桌骑士之一，亚瑟王的侄子兼亲生子。同时也是终结了亚瑟王传说的反叛骑士。莫德雷德是亚瑟王阿尔托莉雅的后代——用阿尔托莉雅创造出来的人造人，虽说如此，但她确实是骑士王如假包换的后代。", origin_id: 1 },
                    { name: "诗乃", gender: 2, info: "朝田诗乃，川原砾所作轻小说《刀剑神域》幽灵子弹篇以及其改编动画《刀剑神域Ⅱ》幽灵子弹篇的女主角。为克服童年阴影而登入VRMMO-RPG “Gun Gale Online” 的玩家，称号为“冰之狙击手”。", origin_id: 3 },
                    { name: "谜之女主角X", gender: 2, info: "被称为Servant Universe的从谜之时空来访的陌生人物，自称为Saber职阶的最强版，作为骑士却堂堂正正地出手偷袭的对Saber用决战兵器，行动代号A-X。", origin_id: 1 },
                    { name: "贞德", gender: 2, info: "将奥尔良从百年战争中解放出来的法国英雄。天主教圣人。作为被圣杯战争本身所召唤的英灵，有着正确管理圣杯战争的职责。因此，她和其他Servant不同，会继承这不断重覆的游戏（圣杯战争）中的记忆。以Servant身份相待时，沉默寡言而冷静。另一方面，本来的贞德是个素朴又温顺的16岁女子。虽然将规律放在第一，为了守护规则而挥剑，但基本上她重视全部参与圣杯战争的人类和英灵。", origin_id: 1 },
                    { name: "贞德Alter", gender: 2, info: "如果神明当真存于此世，想必会降天罚于我身吧。", origin_id: 1 },
                    { name: "远坂凛", gender: 2, info: "远坂凛，日本文字冒险游戏《Fate/stay night》及其衍生作品中的角色。魔道之名门·远坂家的现任当主，是第四次圣杯战争参与者远坂时臣的女儿，父亲在战争后期被其弟子言峰绮礼杀害，随后言峰绮礼监护凛。参加第五次圣杯战争，并命运般地将卫宫士郎的未来“卫宫”召唤为Archer。", origin_id: 1 },
                    { name: "阿尔托莉雅", gender: 2, info: "阿尔托莉雅·潘德拉贡（日文：アルトリア・ペンドラゴン；英文：Altria Pendragon）是日本文字冒险游戏《Fate/stay night》及其衍生作品中的主要角色，身份为古不列颠传说中的亚瑟王。性格忠诚正直，谦逊有礼，个性认真。因有圣剑Excalibur的传承，在第四、五次圣杯战争中一直以“Saber”职阶被召唤到现世。", origin_id: 1 },
                    { name: "阿尔托莉雅Alter", gender: 2, info: "阿尔托莉雅·潘德拉贡〔Alter〕，日本游戏以及改编动画《Fate》系列中登场的人物，最早登场于游戏《Fate/stay night》的间桐樱（Heaven's Feel）线路。被圣杯的诅咒侵蚀、显现出的亚瑟王冷酷无情的另一面。又或许、这才是亚瑟王所追求的“理想的王”应有的姿态。阿尔托莉雅很善于抑制自己的力量，不过这个状态的她对于挥舞自己庞大的魔力没有一丝犹豫。", origin_id: 1 },
                    { name: "阿尔托莉雅Lancer", gender: 2, info: "传说中统治了不列颠的骑士王，亚瑟王。作为国王君临天下之后，主武装由圣剑改为圣枪的亚瑟王。不再受到圣剑导致的成长停止的影响，于是肉体年龄成长到了与王的身份相切合的阶段。", origin_id: 1 },
                    { name: "雷姆", gender: 2, info: "雷姆，轻小说《Re：从零开始的异世界生活》及其衍生作品的主要角色，在罗兹沃尔的宅邸中一手担当全部杂务的双胞胎女仆中的妹妹，小时候家人被魔女教所杀，姐姐角被斩断，从而憎恨魔女教，初识昴因其身上有魔女气味不待见昴，之后解开误会被昴拯救，认定昴是她的英雄，一心一意的相信并照顾昴，看似毒舌冷漠，其实内心很坚强，很温柔。", origin_id: 2 }
                  ])
Company.create!([
                  { name: "ALTER", link: "https://alter-web.jp/" },
                  { name: "Aniplex", link: "https://www.aniplex.co.jp/" },
                  { name: "Flare", link: "http://www.flare-web.jp/" },
                  { name: "GSC", link: "https://www.goodsmile.info/" },
                  { name: "MaxFactory", link: "https://www.maxfactory.jp/" },
                  { name: "Plusone", link: "http://plusoneservice.jp/" },
                  { name: "SSF", link: "https://ssfigure.stores.jp/" },
                  { name: "Strong", link: "https://stronger.co.jp/" },
                  { name: "寿屋", link: "https://www.kotobukiya.co.jp/" },
                  { name: "眼镜厂", link: "https://www.bandaispirits.co.jp/" }
                ])
Figure.create!([
                 { name: "Fate/Grand Order Saber[Alter] 礼服", kind: 3, price: "1019.0", scale: "1：7", company_id: 1 },
                 { name: "剧场版约会大作战 万由里裁决 时崎狂三", kind: 3, price: "1148.0", scale: "1：7", company_id: 1 },
                 { name: "Fate/Grand Order 贞德・达尔克[Alter] 1段阶目", kind: 3, price: "1728.0", scale: "1：7", company_id: 1 },
                 { name: "Fate/Grand Order Berserker/贞德[Alter]", kind: 3, price: "1148.0", scale: "1：7", company_id: 4 },
                 { name: "黏土人#990-DX Fate / Grand Order 吉尔加美什 Caster 灵基再临Ver.", kind: 6, price: "394.0", scale: "non", company_id: 4 },
                 { name: "VOCALOID 初音未来 Memorial Dress Ver. （10周年 绘图比赛大赏）", kind: 3, price: "2540.0", scale: "1：7", company_id: 4 },
                 { name: "figma#502 Fate/Grand Order 玛修·基列莱特 奥特瑙斯", kind: 4, price: "696.0", scale: "non", company_id: 5 },
                 { name: "figma#SP-133 Type-Moon Racing&GOOD SMILE Racing 贞德・达尔克 赛车女郎Ver.", kind: 4, price: "567.0", scale: "non", company_id: 5 },
                 { name: "figma#SP-129 Type-Moon Racing&GOOD SMILE Racing 尼禄·克劳狄乌斯 赛车女郎Ver.", kind: 4, price: "516.0", scale: "non", company_id: 5 },
                 { name: "Fate / Grand Order 贞德 3段阶目", kind: 3, price: "1664.0", scale: "1：7", company_id: 3 },
                 { name: "Fate / Grand Order SABER bride 2段阶目", kind: 3, price: "954.0", scale: "1：7", company_id: 3 },
                 { name: "Fate / Grand Order 尼禄·克劳狄乌斯 Third Ascension", kind: 3, price: "1277.0", scale: "1：7", company_id: 8 },
                 { name: "Fate / Grand Order Saber〔Alter〕私服ver.", kind: 3, price: "709.0", scale: "1：7", company_id: 9 },
                 { name: "Fate/Grand Order 谜之女主角X Assassin", kind: 3, price: "890.0", scale: "1：7", company_id: 9 },
                 { name: "剧场版 命运之夜[天之杯] Ⅱ 迷失之蝶 Saber Alter", kind: 3, price: "1277.0", scale: "1：7", company_id: 2 },
                 { name: "Fate/Grand Order Ruler /贞德・达尔克 英灵正装ver.", kind: 3, price: "902.0", scale: "1：7", company_id: 2 },
                 { name: "Fate/Grand Order 玛修·加拉哈德 新年ver.", kind: 3, price: "993.0", scale: "1：7", company_id: 2 },
                 { name: "Fate/Apocrypha 莫德雷德&贞德・达尔克 Type-Moon Racing ver.", kind: 3, price: "1793.0", scale: "1：7", company_id: 6 },
                 { name: "Fate/Stay Night 远坂凛 TYPE-MOON RACING ver.", kind: 3, price: "778.0", scale: "1：7", company_id: 6 },
                 { name: "Fate/Stay Night SABER TYPE-MOON RACING ver.", kind: 3, price: "799.0", scale: "1：7", company_id: 6 },
                 { name: "Re：从零开始的异世界生活 蕾姆 偶像 Ver.", kind: 3, price: "1967.0", scale: "1：7", company_id: 7 },
                 { name: "Re：从零开始的异世界生活 拉姆 偶像 Ver.", kind: 3, price: "1967.0", scale: "1：7", company_id: 7 },
                 { name: "Re：从零开始的异世界生活 艾米莉娅 偶像 Ver.", kind: 3, price: "1967.0", scale: "1：7", company_id: 7 },
                 { name: "一番赏 Fate / Grand Order 玛修·加拉哈德", kind: 5, price: "40.0", scale: "1：7", company_id: 10 },
                 { name: "一番赏 刀剑神域 フェイタル・バレット 诗乃", kind: 5, price: "40.0", scale: "1：7", company_id: 10 },
                 { name: "一番赏 Re：ゼロから始める异世界生活 レム", kind: 5, price: "40.0", scale: "1：7", company_id: 10 }
               ])
FigureCharacterAssociation.create!([
                                     { figure_id: 1, character_id: 17 },
                                     { figure_id: 2, character_id: 7 },
                                     { figure_id: 3, character_id: 14 },
                                     { figure_id: 4, character_id: 15 },
                                     { figure_id: 18, character_id: 11 },
                                     { figure_id: 18, character_id: 14 },
                                     { figure_id: 5, character_id: 3 },
                                     { figure_id: 6, character_id: 2 },
                                     { figure_id: 7, character_id: 8 },
                                     { figure_id: 22, character_id: 6 },
                                     { figure_id: 21, character_id: 20 },
                                     { figure_id: 23, character_id: 9 },
                                     { figure_id: 7, character_id: 8 },
                                     { figure_id: 24, character_id: 8 },
                                     { figure_id: 19, character_id: 16 },
                                     { figure_id: 16, character_id: 14 }
                                   ])
FigureComment.create!([
                        { figure_id: 5, content: "太好看了吧，我们一起唱好不好", user_id: 1 },
                        { figure_id: 2, content: "角色表格不能添加的 Bug 还没有修复，但我不想改了", user_id: 1 },
                        { figure_id: 2, content: "目前在创建角色时，不管选择什么作品，都会变成该作品下的角色", user_id: 1 },
                        { figure_id: 6, content: "自己可以买自己的商品，虽然不合逻辑，但是方便测试", user_id: 1 },
                        { figure_id: 18, content: "角色与手办为多对多关系，这就是一个例子", user_id: 1 },
                        { figure_id: 12, content: "未关联角色的手办，无法跳转到对应的百科页面，需要由管理员或厂商用户添加角色与手办的多对多关系", user_id: 1 },
                        { figure_id: 3, content: "当你在评论时，其实是评论在手办对象上", user_id: 1 },
                        { figure_id: 5, content: "购买的商品库存为 0 时，购买将不会成功", user_id: 1 },
                        { figure_id: 23, content: "点击标签，可以跳转到对应的百科、公司主页等资讯页面", user_id: 1 },
                        { figure_id: 2, content: "这件商品已经卖光了，但你直到付款前才会知道，像极了每年的双十一", user_id: 1 },
                        { figure_id: 5, content: "啊对对对，说什么我都开摆！", user_id: 2 },
                        { figure_id: 22, content: "希望你对你的人生也是这种态度", user_id: 2 },
                        { figure_id: 6, content: "到时候别人问：“啊？你怎么没有车？”你：“啊对对对～”就开摆就完了呗，对不对？", user_id: 2 },
                        { figure_id: 19, content: "在 Ruby 里头，人家问：“诶？你怎么不写单元测试？”，你：“啊对对对～”", user_id: 2 }
                      ])
