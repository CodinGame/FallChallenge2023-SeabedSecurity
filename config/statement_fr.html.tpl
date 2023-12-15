<!-- LEAGUES level1 level2 level3 level4 level5 -->
<div id="statement_back" class="statement_back" style="display: none"></div>
<div class="statement-body">


    <!-- LEAGUE ALERT -->
    <div style="color: #7cc576; 
	background-color: rgba(124, 197, 118,.1);
	padding: 20px;
	margin-right: 15px;
	margin-left: 15px;
	margin-bottom: 10px;
	text-align: left;">
        <div style="text-align: center; margin-bottom: 6px">
            <img src="//cdn.codingame.com/smash-the-code/statement/league_wood_04.png" />
        </div>
        <p style="text-align: center; font-weight: 700; margin-bottom: 6px;">
            Ce challenge est basé sur un système de <b>ligues</b>.
        </p>
        <div class="statement-league-alert-content">
            Pour ce challenge, plusieurs ligues pour le même jeu seront disponibles. Quand vous aurez prouvé votre
            valeur
            contre le premier Boss, vous accéderez à la ligue supérieure et débloquerez de nouveaux adversaires.<br>
            <br>
        </div>
    </div>

    <!-- GOAL -->
    <div class="statement-section statement-goal">
        <h2 style="font-size: 20px;">
            <span class="icon icon-goal">&nbsp;</span>
            <span>Objectif</span>
        </h2>
        Gagnez plus de points que votre adversaire en <b>scannant le plus de poissons</b>.
        <center style="margin: 20px">
            <img src="/servlet/fileservlet?id=114469062682609" style="height: 180px; margin-bottom: 5px">
        </center>
        <p>Pour protéger la vie marine, il est crucial de la comprendre. Visitez <b>les fonds marins</b> à l'aide de

            <!-- BEGIN level2 -->
            votre        drone
        <!-- END -->
        
        <!-- BEGIN level3 level4 level5 -->
        vos drones
        <!-- END -->

             afin de scanner le plus de poissons pour mieux les connaître&nbsp;!</p>
    </div>

    <!-- RULES -->
    <div class="statement-section statement-rules">
        <h2 style="font-size: 20px;">
            <span class="icon icon-rules">&nbsp;</span>
            <span>Règles</span>
        </h2>
        <div class="statement-rules-content">


            <p>Le jeu se joue au tour par tour. A chaque tour, chaque joueur donne une action que 
                
                <!-- BEGIN level1 level2 -->
        son drone doit
        <!-- END -->
        
        <!-- BEGIN level3 level4 level5 -->
        ses drones doivent
        <!-- END -->

                effectuer.</p>
            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">La carte</h3>
            <p>La carte est un <b>carré</b> de <const>10 000</const> unités de longueur de côté. Les unités de longueur seront
                notées “<const>u</const>” dans la
                suite de l'énoncé. La coordonnée <const>(0, 0)</const> est située au coin <b>haut gauche</b> de la
                carte.</p>

            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Drones</h3>
            <p>Chaque joueur possède 

                <!-- BEGIN level2 -->
                        un drone 
        <!-- END -->
        
        <!-- BEGIN level3 level4 level5 -->
        deux drones
        <!-- END -->

                pour explorer les fonds marins et scanner les poissons. A chaque tour, le
                joueur peut décider de faire bouger son drone dans une direction, ou de ne pas activer ses moteurs. </p>

            <center style="margin: 20px">
                <img style="height: 80px;" src="/servlet/fileservlet?id=114468666528236">
                <img style="height: 80px;" src="/servlet/fileservlet?id=114468648281865">
            </center>

            <p>Votre drone émet en continu de la lumière autour de lui : si un poisson se trouve dans ce <b>rayon de
                    lumière</b>, il est automatiquement scanné. Vous pouvez augmenter la <b>puissance</b> de votre
                lumière (et donc
                votre rayon de scan), mais cela drainera votre <b>batterie</b>.</p>

            <!-- BEGIN level2 level3 level4 level5 -->
            <p>Afin de <b>sauvegarder vos scans</b> et marquer des points, vous devrez remonter à la <b>surface</b> avec
                votre drone.
            </p>
            <!-- END -->

            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Poissons</h3>
            <p>Sur la carte sont répartis les différents poissons que vous devrez scanner. Chaque poisson possède un
                <b>type</b> et une <b>couleur</b> spécifiques. En plus des points gagnés si vous scannez un poisson et
                ramenez le scan
                à la surface, des <b>bonus</b> seront attribués si vous scannez tous les poissons d'un <b>même type</b>
                ou d'une
                <b>même couleur</b>, ou si vous êtes <b>le premier</b> à y parvenir.</p>
            <center style="margin: 20px">
                <img src="/servlet/fileservlet?id=114468927072229" style="height: 180px; margin-bottom: 5px">
            </center>
        <!-- BEGIN level3 level4 level5 -->
            <p>Chaque poisson se déplace dans une <b>zone d'habitat</b>, en fonction de son <b>type</b>. Seuls les
                poissons se trouvant dans le <strong>rayon de lumière</strong> 
        <!-- BEGIN level2 -->
        de votre drone
        <!-- END -->
        
        <!-- BEGIN level3 level4 level5 -->
        d'un de vos drones
        <!-- END -->

        vous seront visibles.</p>


            <!-- BEGIN level4 level5 -->
            <!-- BEGIN level4 -->
            <div class="statement-new-league-rule">
                <!-- END -->
                <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Monstres des profondeurs</h3>
                <p>Des <b>montres des profondeurs</b> rôdent ! S'ils sont éblouis par les <b>lumières</b> d'un drone
                    passant par là, ils se mettront à le pourchasser.</p>
                <center style="margin: 20px">
                    <img src="/servlet/fileservlet?id=114468944243732" style="height: 180px; margin-bottom: 5px">
                </center>
            <!-- BEGIN level4 -->
            </div>
            <!-- END -->
            <!-- END -->
            <!-- END -->



            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Détail des unités</h3>
            <h4 style="font-size: 14px;
				font-weight: 700;
				padding-top: 5px;
				padding-bottom: 15px;">Drones</h4>
            <p>Les drones se déplacent vers le point donné, à une distance maximale par tour de <const>600u</const>. Si
                les
                <strong>moteurs</strong> ne sont pas activés sur un tour, le drone <b>coulera</b> de <const>300u</const>
                .</p>
            <p>A la fin du tour, les poissons se situant dans un rayon de <const>800u</const> seront <b>scannés
                    automatiquement</b>.</p>
            <p>Si la <b>lumière augmentée</b> est activée, ce rayon passe à <const>2000u</const>, mais la
                <b>batterie</b> se vide de <const>5</const> points. Si la
                lumière puissante n'est pas activée, la batterie se recharge de <const>1</const>. La batterie a une
                capacité de <const>30</const>, et
                est <b>chargée</b> en début de jeu.</p>
            <!-- BEGIN level2 level3 level4 level5 -->
            <p>Si le drone se trouve à la <b>surface</b> (y ≤ <const>500u</const>), les scans seront automatiquement
                sauvegardés, et les
                points seront attribués.</p>

            <h4 style="font-size: 14px;
				font-weight: 700;
				padding-top: 5px;
				padding-bottom: 15px;">Radar</h4>
            <p>Pour mieux vous repérer dans les profondeurs sombres, les drones sont équipés de <strong>radars</strong>.
                Pour chaque <strong>créature</strong> (poisson ou monstre) dans la zone de jeu, le radar indique&nbsp;:
            </p>
            <ul>
                <li><strong>TL :</strong> si l&#39;entité se trouve quelque part en <strong>haut à gauche</strong> du
                    drone.</li>
                <li><strong>TR :</strong> si l&#39;entité se trouve quelque part en <strong>haut à droite</strong> du
                    drone.</li>
                <li><strong>BR :</strong> si l&#39;entité se trouve quelque part en <strong>bas à droite</strong> du
                    drone.</li>
                <li><strong>BL :</strong> si l&#39;entité se trouve quelque part en <strong>bas à gauche</strong> du
                    drone.</li>
            </ul>
            <center style="margin: 20px">
                <img src="/servlet/fileservlet?id=114469004608499" style="height: 180px; margin-bottom: 5px">
            </center>
            <p><em>Note : Si l&#39;entité partage la même coordonnée x que le drone, elle sera considérée comme étant à
                    gauche. Si l&#39;entité partage la même coordonnée y que le drone, elle sera considérée comme étant
                    en haut.</em></p>
            <h4 style="font-size: 14px;
		font-weight: 700;
		padding-top: 5px;
		padding-bottom: 15px;">Poissons</h4>
            <p>Les poissons se déplacent chaque tour de <const>200u</const>, dans une direction choisie aléatoirement au
                début du jeu.
                Chaque poisson se déplace dans une zone d'habitat en fonction de son type. S'il atteint un bord de sa
                zone d'habitat, il <b>rebondira</b> sur le bord.</p>
            <table style="margin-bottom: 20px">
                <thead>
                    <tr>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Poissons</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;"><var>type</var></th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Y min</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Y max</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">
                            <img src="/servlet/fileservlet?id=114496147291356" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496409674780" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496386820367" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496422109909" style="height: 16px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">0</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">2500</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">5000</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">
                            <img src="/servlet/fileservlet?id=114496165564766" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496266808904" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496322570760" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496361666564" style="height: 16px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">1</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">5000</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">7500</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">
                            <img src="/servlet/fileservlet?id=114496185299235" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496300138165" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496289912111" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496341931720" style="height: 20px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">2</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">7500</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">10000</td>
                    </tr>
                </tbody>
            </table>
            <p>Si un poisson arrive à moins de <const>600u</const> d'un autre, il nagera dans la direction opposée au
                poisson le plus
                proche de lui.</p>

            <!-- END -->

            <!-- BEGIN level3 -->
            <div class="statement-new-league-rule">
                <!-- END -->
                <!-- BEGIN level3 level4 level5 -->

                <p>Si un drone a ses <b>moteurs activés</b> à une distance de moins de <const>1400u</const>, le poisson
                    passera en mode <b>“effrayé”</b>
                    au tour suivant : dans ce mode, le poisson se mettra à nager dans la direction opposée au drone le
                    plus
                    proche avec une vitesse de <const>400u</const> par tour. En étant effrayé, le poisson ne peut <b>pas
                        sortir</b> de son habitat
                    sur la coordonnée y (il restera à ce y sans rebondir), mais si sa coordonnée x devient négative ou
                    supérieure à 9999, il <b>sortira définitivement</b> de la carte et ne pourra plus être scanné.</p>
                <center style="margin: 20px">
                    <img src="/servlet/fileservlet?id=114469161976816"
                        style="max-width: 400px; width: 100%; margin-bottom: 5px">
                </center>
                <!-- END -->
                <!-- BEGIN level3 -->
            </div>
            <!-- END -->



            <!-- BEGIN level4 level5 -->
            <!-- BEGIN level4 -->
            <div class="statement-new-league-rule">
                <!-- END -->
                <h4 style="font-size: 14px;
    font-weight: 700;
    padding-top: 5px;
    padding-bottom: 15px;">Monstres</h4>
                <p>Si un monstre se trouve dans un rayon de <const>500u</const> d'un drone au cours d'un tour (donc pas
                    nécessairement à la
                    fin du tour), le drone passera en mode <b>“urgence”</b>. Dans ce mode, tous les
                    <b>scans non
                        sauvegardés</b> seront perdus. Le drone activera ses bouées et se mettra à remonter à une
                    vitesse de <const>300u</const> par
                    tour. Tant que le drone n'a
                    pas atteint la surface (y=<const>0</const>), le drone continuera de remonter et les actions seront
                    ignorées</p>
                <center style="margin: 20px">
                    <img src="/servlet/fileservlet?id=114469224715874"
                        style="max-width: 400px; width: 100%; margin-bottom: 5px">
                </center>
                <p>Les monstres sont détectables un peu <b>plus loin</b> que votre rayon de lumière (<const>300u</const>
                    de plus que votre lumière).</p>
                <p>Les monstres commencent la partie avec une <b>vitesse nulle</b>. Si un monstre se trouve dans le
                    <b>rayon de
                        lumière</b> d'un drone à la fin d'un tour, il passe en mode <b>“agressif”</b> et s'élancera dans
                    la direction du
                    drone le plus proche dès le prochain tour à une vitesse de <const>540u</const>. </p>
                <p>S'il ne se trouve plus dans un rayon lumineux, il continuera à nager dans cette direction à une
                    vitesse
                    de <const>270u</const>. Pendant cette nage <b>non-agressive</b> le monstre changera de direction si :
                </p>
                <ul>
                    <li>il se trouve à y = <const>2500u</const> ou aux bords latéraux de la carte, la limite de son
                        habitat qu'il ne peut
                        <b>jamais franchir</b>.</li>
                    <li>il se trouve à moins de <const>600u</const> d'un autre monstre, auquel cas il ira dans la
                        direction opposée du
                        monstre le plus proche.</li>
                </ul>

                <table style="margin-bottom: 20px">
                    <thead>
                        <tr>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Créature</th>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;"><var>type</var>
                            </th>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Y min</th>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Y max</th>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">start Y min</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding: 5px;outline: 1px solid #838891;">
                                <img src="/servlet/fileservlet?id=114496204211135" style="height: 40px" />

                            </td>
                            <td style="padding: 5px;outline: 1px solid #838891;">-1</td>
                            <td style="padding: 5px;outline: 1px solid #838891;">2500</td>
                            <td style="padding: 5px;outline: 1px solid #838891;">10000</td>
                            <td style="padding: 5px;outline: 1px solid #838891;">5000</td>
                        </tr>

                    </tbody>
                </table>
            <!-- BEGIN level4 -->
            </div>
            <!-- END -->
            <!-- END -->


            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Détail des scores</h3>
            <p>Des points sont attribués pour <b>chaque scan</b> en fonction du type de poisson scanné. Être le
                <b>premier</b> à
                <!-- BEGIN level1 -->
                effectuer
                <!-- END -->
                <!-- BEGIN level2 level3 level4 level5 -->
                sauvegarder
                <!-- END -->
                
                un <b>scan</b> ou une <b>combinaison</b> vous permet de gagner le <b>double</b> des points.
            </p>
            <table style="margin-bottom: 20px; ">
                <thead>
                    <tr>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Scan</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Points</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Points si premier à
                <!-- BEGIN level1 -->
                scanner
                <!-- END -->
                <!-- BEGIN level2 level3 level4 level5 -->
                sauvegarder
                <!-- END -->
                            
                            </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">Type 0
                            <img src="/servlet/fileservlet?id=114496386820367" style="height: 20px; margin-left: 2px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">1</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">2</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">Type 1
                            <img src="/servlet/fileservlet?id=114496266808904" style="height: 20px; margin-left: 2px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">2</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">4</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">Type 2
                            <img src="/servlet/fileservlet?id=114496341931720" style="height: 20px; margin-left: 2px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">3</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">6</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">Tous les poissons d'une couleur
                            <img src="/servlet/fileservlet?id=114496147291356" style="height: 16px; margin-left: 2px" />
                            <img src="/servlet/fileservlet?id=114496185299235" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496165564766" style="height: 16px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">3</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">6</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">Tous les poissons d'un type
                            <img src="/servlet/fileservlet?id=114496165564766" style="height: 16px; margin-left: 2px" />
                            <img src="/servlet/fileservlet?id=114496266808904" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496322570760" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496361666564" style="height: 16px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">4</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">8</td>
                    </tr>
                </tbody>
            </table>
            <!-- BEGIN level2 level3 level4 level5 -->
            <p>À la fin de la partie, <strong>tous les scans non sauvegardés</strong> sont <strong>automatiquement
                    sauvegardés</strong> et les points associés sont attribués.</p>
            <!-- END -->
        </div>
        <!-- Victory conditions -->
        <div class="statement-victory-conditions">
            <div class="icon victory"></div>
            <div class="blk">
                <div class="title">Conditions de victoire</div>
                <div class="text">
                    <ul style="padding-top:0; padding-bottom: 0;">
                        <li>La partie atteint <const>200</const> tours</li>
                        <li>Un joueur a gagné assez de points pour que son adversaire ne puisse plus le rattraper</li>
                        <li>Les deux joueurs ont sauvegardé les scans de <b>tous les poissons restants</b> sur la carte</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Lose conditions -->
        <div class="statement-lose-conditions">
            <div class="icon lose"></div>
            <div class="blk">
                <div class="title">Conditions de défaite</div>
                <div class="text">
                    <ul style="padding-top:0; padding-bottom: 0;">
                        <!-- BEGIN level1 level2 -->
                        <li>Votre programme ne répond pas dans le temps imparti ou il fournit une
                            commande non reconnue.</li>
                        <!-- END -->
                        <!-- BEGIN level3 -->
                        <li>Votre programme ne retourne pas de commande valide dans le temps imparti
                            pour chacun de vos drone.</li>
                        <!-- END -->
                        <!-- BEGIN level4 level5 -->
                        <li>Votre programme ne retourne pas de commande valide dans le temps imparti
                            pour chacun de vos drone, y compris ceux en mode <b>urgence</b>.</li>
                        <!-- END -->
                    </ul>
                </div>
            </div>
        </div>
        <br>
        <h3 style="font-size: 16px;
		font-weight: 700;
		padding-top: 20px;
		color: #838891;
		padding-bottom: 15px;">
            🐞 Conseils de débogage</h3>
        <ul>
            <li>Survolez une entité pour voir plus d'informations sur celle-ci.</li>
            <li>Ajoutez du texte à la fin d'une instruction pour afficher ce texte au dessus de votre drone</li>
            <li>Cliquez sur la roue dentée pour afficher les options visuelles supplémentaires.</li>
            <li>Utilisez le clavier pour contrôler l'action : espace pour play / pause, les flèches pour avancer pas à
                pas.
        </ul>
    </div>

    <!-- BEGIN level4 level5 -->
    <!-- EXPERT RULES -->
    <div class="statement-section statement-expertrules">
        <h2 style="font-size: 20px;">
            <span class="icon icon-expertrules">&nbsp;</span>
            <span>Détails techniques</span>
        </h2>
        <div class="statement-expert-rules-content">

            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Moteur physique</h2>
                <ul>
                    <li>Les vecteurs de vitesses sont arrondis vers l'entier le plus proche.                    </li>
                    <li>La collision entre drone et monstre peut survenir entre deux tours, elle est calculé à
                        partir des
                        vecteurs vitesses des entités.</li>
                        <li>En choisissant l'entité la plus proche d'un poisson ou d'un monstre, en cas d'égalité, on prend la moyenne des positions.</li>
                         
                </ul>


                <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">
                    Ordre des actions</h2>
                    <ul style="padding-left: 20px;padding-bottom: 0">
                        <li>Allumage / extinction des lumières des drones</li>
                        <li>Drain ou recharge de la batterie des drones</li>
                        <li>Déplacement des drones, poissons, monstres</li>
                        <li>Gestion des collisions drone↔monstre</li>
                        <li>Mise à jour de la cible des monstres</li>
                        <li>Scans des poissons</li>
                        <li>Sauvegarde des scans des drones à y ≤ <const>500</const>
                        </li>
                        <li>Réparation des drones en mode urgence à y = <const>0</const>                        </li>
                        <li>Mise à jour de la vitesse des poissons</li>
                        <li>Mise à jour de la vitesse des monstres en fonction de leur cible</li>

                    </ul>
                    
        </div>
    </div>
    <!-- END -->


    <!-- PROTOCOL -->
    <div class="statement-section statement-protocol">
        <h2 style="font-size: 20px;">
            <span class="icon icon-protocol">&nbsp;</span>
            <span>Protocole de jeu</span>
        </h2>

        <!-- Protocol block -->
        <div class="blk">
            <div class="title">Entrées d'Initialisation</div>
            <span class="statement-lineno">Première ligne :</span> <var>creatureCount</var> un entier pour le nombre de
            créature en jeu.<br>
            <span class="statement-lineno">Les <var>creatureCount</var> lignes suivantes :</span> 3 entiers décrivants
            chaque créature :
            <ul>
                <li><var>creatureId</var> l'id unique de la créature.</li>
                <!-- BEGIN level1 level2 level3 -->
                <li><var>color</var> <const>(de 0 à 3)</const> et <var>type</var> <const>(de 0 à 2)</const>.</li>
                <!-- END -->
                
                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                <!-- END -->
                <!-- BEGIN level5 -->
                <li>
                <!-- END -->
                
                <!-- BEGIN level4 level5 -->
                <var>color</var> (de 0 à 3) et <var>type</var> (de 0 à 2).
                    Les monstres seront de couleur et type <const>-1 -1</const>.
                <!-- END -->
                    <!-- BEGIN level4 -->
                    </li>
                    <!-- END -->
                    <!-- BEGIN level5 -->
                    </li>
                    <!-- END -->
            </ul>

        </div>
        <div class="blk">
            <!-- BEGIN level1 -->            
            <div class="title">Entrées pour un tour de Jeu</div>
            <var>myScore</var> pour votre score actuel.<br />
            <var>foeScore</var> pour le score de votre adversaire.<br />
            <br />
            <var>myScanCount</var> pour le nombre de vos <b>scans</b>.<br />
            <span class="statement-lineno">Prochaines <var>myScanCount</var> lignes :</span> <var>creatureId</var> l'identifiant de chaque créature scannée.<br />
            <br />
            <var>foeScanCount</var> pour le nombre de <b>scans</b> de votre adversaire.<br />
            <span class="statement-lineno">Prochaines <var>foeScanCount</var> lignes :</span> <var>creatureId</var> l'identifiant de chaque créature scannée.<br />
            <br />
            <span class="statement-lineno">Pour votre drone :</span>
            <ul>
                <li><var>droneId</var> : l'identifiant de ce drone.</li>
                <li><var>droneX</var> et <var>droneY</var> : la position de ce drone.</li>
                <li><var>battery</var> : le niveau de batterie de ce drone.</li>
            </ul>

            <span class="statement-lineno">Pour le drone de votre adversaire :</span>
            <ul>
                <li><var>droneId</var> : l'identifiant de ce drone.</li>
                <li><var>droneX</var> et <var>droneY</var> : la position de ce drone.</li>
                <li><var>battery</var> : le niveau de batterie de ce drone.</li>
            </ul>
            <br />
            <span class="statement-lineno">Pour chaque poisson :</span>
            <ul>
                <li><var>creatureId</var> : l'id unique de la créature.</li>
                <li><var>creatureX</var> et <var>creatureY</var> : la position de la créature.</li>
                <li><var>creatureVx</var> et <var>creatureVy</var> : la vitesse actuelle de la créature.</li>
            </ul>
            
            Les variables restantes peuvent être ignorées et seront utilisées dans des ligues ultérieures.

            <!-- END -->
            <!-- BEGIN level2 level3 level4 level5 -->
            
            
            <div class="title">Entrées pour un tour de Jeu</div>
            <span class="statement-lineno">Ligne suivante :</span> <var>myScore</var> votre score.<br />
            <span class="statement-lineno">Ligne suivante :</span> <var>foeScore</var> le score de votre
            adversaire.<br />
            <br />
            <span class="statement-lineno">Ligne suivante :</span> <var>myScanCount</var> le nombre de scans
            <b>sauvegardés.</b>
            <br />
            <span class="statement-lineno">Les <var>myScanCount</var> lignes suivantes :</span> <var>creatureId</var>
            pour chaque scan sauvegardé.<br />
            <br />
            <span class="statement-lineno">Ligne suivante :</span> <var>foeScanCount</var> le nombre de scans
            <b>sauvegardés</b> par votre adversaire/<br />
            <span class="statement-lineno">Les <var>foeScanCount</var> lignes suivantes:</span> <var>creatureId</var>
            pour chaque scan sauvegardé par votre adversaire.<br />
            <br />
            <span class="statement-lineno">Ligne suivante :</span> <var>myDroneCount</var> le nombre de drones que vous
            contrôlez.<br />
            <span class="statement-lineno">Les <var>myDroneCount</var> lignes suivantes :</span>
            <ul>
                <li><var>droneId</var> : l'id unique du drone.</li>
                <li><var>droneX</var> et <var>droneY</var> : la position du drone.</li>
                <!-- BEGIN level2 level3 -->
                <li><var>emergency</var> : non utilisé pour cette ligue.</li>
                <!-- END -->

                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                <!-- END -->
                <!-- BEGIN level5 -->
                <li>
                <!-- END -->
                
                <!-- BEGIN level4 level5 -->
                <var>emergency</var> : <const>1</const> si
                    un drone est en mode urgence, <const>0</const> sinon.
                <!-- END -->
                
                <!-- BEGIN level4 -->
                </li>
                <!-- END -->
                <!-- BEGIN level5 -->
                </li>
                <!-- END -->
                

                <li><var>battery</var> : le niveau de batterie du drone.
            </ul>
            
            <br />
            <span class="statement-lineno">Ligne suivante :</span> <var>foeDroneCount</var> le nombre de drones de votre
            adversaire.<br />
            <span class="statement-lineno">Les <var>foeDroneCount</var> lignes suivantes :</span>
            <ul>
                <li><var>droneId</var> : l'id unique du drone.</li>
                <li><var>droneX</var> et <var>droneY</var> : la position du drone.</li>
                <!-- BEGIN level2 level3 -->
                <li><var>emergency</var> : non utilisé pour cette ligue.</li>
                <!-- END -->

                
                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                <!-- END -->
                <!-- BEGIN level5 -->
                <li>
                <!-- END -->
                
                <!-- BEGIN level4 level5 -->
                <var>emergency</var> : <const>1</const> si
                    un drone est en mode urgence, <const>0</const> sinon.
                <!-- END -->
                
                <!-- BEGIN level4 -->
                </li>
                <!-- END -->
                <!-- BEGIN level5 -->
                </li>
                <!-- END -->
                
                <li><var>battery</var> : le niveau de batterie du drone.
            </ul>
            
            <span class="statement-lineno">Ligne suivante :</span> <var>droneScanCount</var> le nombre de scans non
            sauvegardés.<br />
            <span class="statement-lineno">Les <var>droneScanCount</var> lignes suivantes :</span> <var>droneId</var> et
            <var>creatureId</var> décrivant quel drone contient le scan de quel poisson.<br />
            <br />
            <span class="statement-lineno">Ligne suivante :</span> <var>visibleCreatureCount</var> le nombre de
            créatures dans le rayon de lumière de vos drones.<br />
            <span class="statement-lineno">Les <var>visibleCreatureCount</var> lignes suivantes :</span>
            <ul>
                <li><var>creatureId</var> : l'id unique de la créature.</li>
                <li><var>creatureX</var> and <var>creatureY</var> : la position de la créature.</li>
                <li><var>creatureVx</var> and <var>creatureVy</var>  la vitesse actuelle de la créature.</li>
            </ul>
            <span class="statement-lineno">Ligne suivante :</span> <var>radarBlipCount</var>.<br />
            <span class="statement-lineno">Les <var>radarBlipCount</var> lignes suivantes :</span>
            Deux entiers <var>droneId</var>, <var>creatureId</var> et une string <var>radar</var> indiquant la position
            relative entre chaque créature et chacun de vos drones.
            <var>radar</var> peut valoir :<ul>
                <li>
                    <const>TL</const> : la créature est en haut à gauche du drone.
                </li>
                <li>
                    <const>TR</const> : la créature est en haut à droite du drone.
                </li>
                <li>
                    <const>BR</const> : la créature est en bas à droite du drone.
                </li>
                <li>
                    <const>BL</const> : la créature est en bas à gauche du drone.
                </li>
            </ul>
        <!-- END -->
        </div>

        <div class="blk">
            <div class="title">Sortie</div>
            <div class="text">

                <!-- BEGIN level1 level2 -->
                <span class="statement-lineno">Une ligne :</span> une instruction valide pour votre drone :
                <!-- END -->

                <!-- BEGIN level3 -->
                <div class="statement-new-league-rule">
                    <!-- END -->
                    <!-- BEGIN level3 level4 level5 -->

                    <span class="statement-lineno">Les <var>myDroneCount</var> lignes suivantes :</span> une instruction
                    valide pour chaque drone, dans le même ordre dans lequel les drones ont été donnés :
                    <!-- END -->
                    <!-- BEGIN level3 -->
                </div>
                <!-- END -->

                <ul>
                    <li>
                        <action>MOVE <var>x</var> <var>y</var> <var>light</var></action> : fait bouger le drone vers<!-- END -->
                        <var>(x,y)</var>, avec les moteurs allumés.
                    </li>
                    <li>
                        <action>WAIT <var>light</var></action>. Les moteurs sont éteints. Le drone va couler mais peut toujours scanner les poissons aux alentours.
                    </li>
                </ul>
                <var>light</var> à <const>1</const> pour activer la lumière augmentée, <const>0</const> sinon.
                
            </div>
        </div>



        <div class="blk">
            <div class="title">Contraintes</div>
            <div class="text">
                <!-- BEGIN level1 level2 level3 -->
                <var>creatureCount</var> = <const>12</const> pour cette ligue<br>
                <!-- END -->

                <!-- BEGIN level4 level5 -->
                <!-- BEGIN level4 -->
                <div class="statement-new-league-rule">
                <!-- END -->
                    <const>13</const> &le; <var>creatureCount</var> &le; <const>20</const> en fonction du nombre de monstres présents sur la carte.<br>
                <!-- BEGIN level4 -->
                </div>
                <!-- END -->
                <!-- END -->


                <!-- BEGIN level1 level2 -->
                <var>myDroneCount</var> = <const>1</const> pour cette ligue<br>
                <!-- END -->

                <!-- BEGIN level3 -->
                <div class="statement-new-league-rule">
                    <!-- END -->
                    <!-- BEGIN level3 level4 level5 -->
                    <var>myDroneCount</var> = <const>2</const><br>
                    <!-- END -->
                    <!-- BEGIN level3 -->
                </div>
                <!-- END -->

                <br>
                Temps de réponse par tour ≤ <const>50</const>ms<br>
                Temps de réponse pour le premier tour ≤ <const>1000</const>ms
            </div>
        </div>
    </div>

    <!-- BEGIN level1 level2 level3 -->
    <!-- LEAGUE ALERT -->
    <div style="color: #7cc576; 
											background-color: rgba(124, 197, 118,.1);
											padding: 20px;
											margin-top: 10px;
											text-align: left;">
        <div style="text-align: center; margin-bottom: 6px"><img
                src="//cdn.codingame.com/smash-the-code/statement/league_wood_04.png" /></div>

        <div style="text-align: center; font-weight: 700; margin-bottom: 6px;">
            Qu'est-ce qui m'attend dans les ligues suivantes ?
        </div>
        <ul>
            <!-- BEGIN level1 -->
            <li>Seul les poissons proches seront visibles</li>
            <!-- END -->
            <!-- BEGIN level1 level2 -->
            <li>Vous pourrez contrôler 2 drones</li>
            <!-- END -->
            <!-- BEGIN level1 level2 level3 -->
            <li>Des monstres des profondeurs rôderont</li>
            <!-- END -->
        </ul>
    </div>
    <!-- END -->

    <!-- STORY -->
    <div class="statement-story-background">
        <div class="statement-story-cover"
            style="background-size: cover; background-image: url(/servlet/fileservlet?id=113029027506177)">
            <div class="statement-story" style="min-height: 300px; position: relative">
                <h2><span style="color: #b3b9ad">Pour Démarrer</span></h2>
                <div class="story-text">
                    Pourquoi ne pas se lancer dans la bataille avec l'un de ces <b>IA Starters</b>, fournis par
                    l'équipe&nbsp;: 
                    <p> <a style="color: #f2bb13; border-bottom: 1px dotted #f2bb13;"
                                rel="nofollow" target="_blank" href="https://gist.github.com/CGjupoulton/8dda912e519671d440b8929e907e603a">https://gist.github.com/CGjupoulton/8dda912e519671d440b8929e907e603a</a> </p>
                    
                    <p>
                        Vous pouvez les modifier selon votre style, ou les prendre comme exemple pour tout coder à
                        partir de
                        zero.
                    </p>

                    <p>Vous pouvez voir le code source de ce jeu sur <a rel="nofollow" style="color: #f2bb13; border-bottom: 1px dotted #f2bb13;" target="_blank"
					href="https://github.com/CodinGame/FallChallenge2023-SeabedSecurity">ce repo GitHub</a>.</p>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- SHOW_SAVE_PDF_BUTTON -->
