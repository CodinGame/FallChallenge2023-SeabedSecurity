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
            This challenge is based on a system of <b>leagues</b>.
        </p>
        <div class="statement-league-alert-content">
            For this challenge, multiple leagues for the same game will be available. Once you have proven your worth
            against the first Boss, you will access the higher league and unlock new opponents.<br>
            <br>
        </div>
    </div>

    <!-- GOAL -->
    <div class="statement-section statement-goal">
        <h2 style="font-size: 20px;">
            <span class="icon icon-goal">&nbsp;</span>
            <span>Goal</span>
        </h2>
        Win more points than your opponent by <b>scanning the most fish</b>.
        <center style="margin: 20px">
            <img src="/servlet/fileservlet?id=114469062682609" style="height: 180px; margin-bottom: 5px">
        </center>
        <p>To protect marine life, it is crucial to understand it. Explore <b>the ocean floor</b> using your

            <!-- BEGIN level2 -->
            drone
            <!-- END -->

            <!-- BEGIN level3 level4 level5 -->
            drones
            <!-- END -->

            to
            scan as many fish as possible to better understand them!</p>
    </div>

    <!-- RULES -->
    <div class="statement-section statement-rules">
        <h2 style="font-size: 20px;">
            <span class="icon icon-rules">&nbsp;</span>
            <span>Rules</span>
        </h2>
        <div class="statement-rules-content">


            <p>The game is played turn by turn. Each turn, each player gives an action for their
                <!-- BEGIN level1 level2 -->
                drone
                <!-- END -->

                <!-- BEGIN level3 level4 level5 -->
                drones
                <!-- END -->
                to perform.</p>
            <h3 style="font-size: 16px;
            font-weight: 700;
            padding-top: 20px;
            color: #838891;
            padding-bottom: 15px;">The Map</h3>
            <p>The map is a <b>square</b> of <const>10,000</const> units on each side. Length units will be denoted as "
                <const>u</const>" in the
                rest of the statement. The coordinate <const>(0, 0)</const> is located at the <b>top left</b> corner of
                the
                map.</p>

            <h3 style="font-size: 16px;
            font-weight: 700;
            padding-top: 20px;
            color: #838891;
            padding-bottom: 15px;">Drones</h3>
            <p>Each player has

                <!-- BEGIN level2 -->
                a drone
                <!-- END -->

                <!-- BEGIN level3 level4 level5 -->
                two drones
                <!-- END -->

                to explore the ocean floor and scan the fish. Each turn, the player can decide to
                move their drone in a direction or not activate its motors.</p>

            <center style="margin: 20px">
                <img style="height: 80px;" src="/servlet/fileservlet?id=114468666528236">
                <img style="height: 80px;" src="/servlet/fileservlet?id=114468648281865">
            </center>

            <p>Your drone continuously emits light around it. If a fish is within this <b>light radius</b>, it is
                automatically scanned. You can increase the <b>power</b> of your light (and thus your scan radius), but
                this will drain your <b>battery</b>.</p>
            <!-- BEGIN level2 level3 level4 level5 -->
            <p>In order to <b>save your scans</b> and score points, you will need to resurface with your drone.</p>
            <!-- END -->
            <h3 style="font-size: 16px;
            font-weight: 700;
            padding-top: 20px;
            color: #838891;
            padding-bottom: 15px;">Fish</h3>
            <p>On the map, different fish are present. Each fish has a specific
                <var>type</var> and <var>color</var>. In addition to the points earned if you scan a fish and bring the
                scan
                back to the surface, <b>bonuses</b> will be awarded if you scan all the fish of the <b>same type</b> or
                <b>same color</b>, or if you are the <b>first</b> to do so.</p>
            <center style="margin: 20px">
                <img src="/servlet/fileservlet?id=114468927072229" style="height: 180px; margin-bottom: 5px">
            </center>
            <!-- BEGIN level2 level3 level4 level5 -->

            <p>Each fish moves within a <b>habitat zone</b>, depending on its <b>type</b>. Only fish within the
                <strong>light radius</strong> of

                <!-- BEGIN level2 -->
                your drone
                <!-- END -->

                <!-- BEGIN level3 level4 level5 -->
                one of your drones
                <!-- END -->

                will be visible to you.</p>

            <!-- BEGIN level4 level5 -->
            <!-- BEGIN level4 -->
            <div class="statement-new-league-rule">
                <!-- END -->
                <h3 style="font-size: 16px;
        font-weight: 700;
        padding-top: 20px;
        color: #838891;
        padding-bottom: 15px;">Depth Monsters</h3>
                <p><b>Depth monsters</b> lurk! If they are blinded by the <b>lights</b> of a passing drone, they will
                    start
                    chasing it.</p>
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
    padding-bottom: 15px;">Unit Details</h3>
            <h4 style="font-size: 14px;
        font-weight: 700;
        padding-top: 5px;
        padding-bottom: 15px;">Drones</h4>
            <p>Drones move towards the given point, with a maximum distance per turn of <const>600u</const>. If the
                <strong>motors</strong> are not activated in a turn, the drone will <b>sink</b> by <const>300u</const>.
            </p>
            <p>At the end of the turn, fish within a radius of <const>800u</const> will be <b>automatically scanned</b>.
            </p>
            <p>If you have increased the <b>power of your light</b>, this radius becomes <const>2000u</const>, but the
                <b>battery</b> drains by <const>5</const> points. If the powerful light is not activated, the battery
                recharges
                by <const>1</const>. The battery has a capacity of <const>30</const> and
                is <b>fully charged</b> at the beginning of the game.</p>

            <!-- BEGIN level2 level3 level4 level5 -->
            <p>If the drone is near the <b>surface</b> (y ≤ <const>500u</const>), the scans will be automatically saved,
                and
                points will be awarded.</p>

            <h4 style="font-size: 14px;
        font-weight: 700;
        padding-top: 5px;
        padding-bottom: 15px;">Radar</h4>
            <p>To better navigate the dark depths, drones are equipped with <strong>radars</strong>.
                For each <strong>creature</strong> (fish or monster) in the game zone, the radar will indicate:</p>
            <ul>
                <li><strong>TL:</strong> if the entity is somewhere <strong>top left</strong> of the
                    drone.</li>
                <li><strong>TR:</strong> if the entity is somewhere <strong>top right</strong> of the
                    drone.</li>
                <li><strong>BR:</strong> if the entity is somewhere <strong>bottom right</strong> of the
                    drone.</li>
                <li><strong>BL:</strong> if the entity is somewhere <strong>bottom left</strong> of the
                    drone.</li>
            </ul>
            <center style="margin: 20px">
                <img src="/servlet/fileservlet?id=114469004608499" style="height: 180px; margin-bottom: 5px">
            </center>
            <p><em>Note: If the entity shares the same x-coordinate as the drone, it will be considered as being on the
                    left. If the entity shares the same y-coordinate as the drone, it will be considered as being on the
                    top.</em></p>
            <h4 style="font-size: 14px;
        font-weight: 700;
        padding-top: 5px;
        padding-bottom: 15px;">Fish</h4>
            <p>Fish move <const>200u</const> each turn, in a randomly chosen direction at the
                beginning of the game. Each fish moves within a habitat zone based on its type. If it reaches the edge
                of its
                habitat zone, it will <b>rebound</b> off the edge.</p>

            <table style="margin-bottom: 20px">
                <thead>
                    <tr>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Fish</th>
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
            <p>If a fish comes within <const>600u</const> of another, it will begin to swim in the opposite direction to
                the
                nearest fish.</p>
            <!-- END -->
            <!-- BEGIN level3 -->
            <div class="statement-new-league-rule">
                <!-- END -->
                <!-- BEGIN level3 level4 level5 -->

                <p>If a drone has its <b>motors activated</b> within a distance of less than <const>1400u</const>, the
                    fish will
                    enter <b>“frightened” mode</b> in the next turn: in this mode, the fish will start swimming in the
                    direction
                    opposite to the nearest drone at a speed of <const>400u</const> per turn. While frightened, the fish
                    cannot
                    <b>exit</b> its habitat on the y-coordinate (it will stay at that y-coordinate without bouncing),
                    but if its
                    x-coordinate becomes negative or greater than 9999, it will <b>permanently leave</b> the map and
                    cannot be
                    scanned anymore.</p>
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
                padding-bottom: 15px;">Monsters</h4>
                <p>If a monster is within a radius of <const>500u</const> from a drone during a turn (so not necessarily
                    at the
                    end of the turn), the drone will enter <b>“emergency” mode</b>. In this mode, all <b>unsaved
                        scans</b> will
                    be lost. The drone will activate its buoys and start ascending at a speed of <const>300u</const> per
                    turn.
                    Until the drone reaches the surface (y=<const>0</const>), the drone will continue to ascend, and
                    actions will
                    be ignored</p>
                <center style="margin: 20px">
                    <img src="/servlet/fileservlet?id=114469224715874"
                        style="max-width: 400px; width: 100%; margin-bottom: 5px">
                </center>
                <p>Monsters are detectable a bit <b>farther</b> than your light radius (<const>300u</const> more than
                    your light).</p>
                <p>Monsters start the game with a <b>zero speed</b>. If a monster is within the <b>light radius</b> of a
                    drone at the end of a turn, it enters <b>“aggressive” mode</b> and will dash in the direction of the
                    nearest drone in the next turn at a speed of <const>540u</const>.</p>
                <p>If it is no longer within a light radius, it will continue swimming in that direction at a speed of
                    <const>270u</const>. During this <b>non-aggressive swim</b>, the monster will change direction if:
                </p>
                <ul>
                    <li>it is at y = <const>2500u</const> or at the lateral edges of the map, the limit of its habitat
                        that it can never cross.</li>
                    <li>it is within <const>600u</const> of another monster, in which case it will go in the opposite
                        direction of the nearest monster.</li>
                </ul>

                <table style="margin-bottom: 20px">
                    <thead>
                        <tr>
                            <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Creature</th>
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
	padding-bottom: 15px;">Score Details</h3>
            <p>Points are awarded for <b>each scan</b> depending on the type of scanned fish. Being the <b>first</b> to
                
                <!-- BEGIN level1 -->
                perform
                <!-- END -->
                <!-- BEGIN level2 level3 level4 level5 -->
                save
                <!-- END -->
                
                a <b>scan</b> or a <b>combination</b> allows you to earn <b>double</b> the points.</p>
            <table style="margin-bottom: 20px; ">
                <thead>
                    <tr>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Scan</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Points</th>
                        <th style="text-align: center; padding: 5px; outline: 1px solid #838891;">Points if first to
                            <!-- BEGIN level2 level3 level4 level5 -->
                            save
                            <!-- END -->
                            <!-- BEGIN level1 -->
                            scan
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
                        <td style="padding: 5px;outline: 1px solid #838891;">All fish of one color
                            <img src="/servlet/fileservlet?id=114496147291356" style="height: 16px; margin-left: 2px" />
                            <img src="/servlet/fileservlet?id=114496185299235" style="height: 16px" />
                            <img src="/servlet/fileservlet?id=114496165564766" style="height: 16px" />
                        </td>
                        <td style="padding: 5px;outline: 1px solid #838891;">3</td>
                        <td style="padding: 5px;outline: 1px solid #838891;">6</td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;outline: 1px solid #838891;">All fish of one type
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

            <p>At the end of the game, <strong>all unsaved scans</strong> are <strong>automatically saved</strong>, and
                associated points are awarded.</p>
            <!-- END -->
        </div>
        <!-- Victory conditions -->
        <div class="statement-victory-conditions">
            <div class="icon victory"></div>
            <div class="blk">
                <div class="title">Victory Conditions</div>
                <div class="text">
                    <ul style="padding-top:0; padding-bottom: 0;">
                        <li>The game reaches <const>200</const> turns</li>
                        <li>A player has earned enough points that their opponent cannot catch up</li>
                        <li>Both players have saved the scans of <b>all remaining fish</b> on the map</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Lose conditions -->
        <div class="statement-lose-conditions">
            <div class="icon lose"></div>
            <div class="blk">
                <div class="title">Defeat Conditions</div>
                <div class="text">
                    <ul style="padding-top:0; padding-bottom: 0;">
                        <!-- BEGIN level1 level2 -->
                        <li>Your program does not respond within the given time or provides an unrecognized command.
                        </li>
                        <!-- END -->
                        <!-- BEGIN level3 -->
                        <li>Your program does not return a valid command within the given time for each of your drones.
                        </li>
                        <!-- END -->
                        <!-- BEGIN level4 level5 -->
                        <li>Your program does not return a valid command within the given time for each of your drones,
                            including those in <b>emergency</b> mode.</li>
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
            🐞 Debugging Tips</h3>
        <ul>
            <li>Hover over an entity to see more information about it.</li>
            <li>Add text at the end of an instruction to display that text above your drone.</li>
            <li>Click on the gear icon to display additional visual options.</li>
            <li>Use the keyboard to control actions: space for play/pause, arrows for step-by-step forward movement.
            </li>
        </ul>
    </div>

    <!-- BEGIN level4 level5 -->
    <!-- EXPERT RULES -->
    <div class="statement-section statement-expertrules">
        <h2 style="font-size: 20px;">
            <span class="icon icon-expertrules">&nbsp;</span>
            <span>Technical Details</span>
        </h2>
        <div class="statement-expert-rules-content">

            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">Physics Engine</h3>
            <ul>
                <li>Velocity vectors are rounded to the nearest integer.</li>
                <li>Collision between drones and monsters can occur between two turns, calculated based on entity
                    velocity vectors.</li>
                <li>When selecting the closest entity to a fish or monster, in case of a tie, the average of the
                    positions is taken.</li>
            </ul>


            <h3 style="font-size: 16px;
			font-weight: 700;
			padding-top: 20px;
			color: #838891;
			padding-bottom: 15px;">
                Order of Actions</h3>
            <ul style="padding-left: 20px;padding-bottom: 0">
                <li>Turning on / off drone lights</li>
                <li>Draining or recharging drone batteries</li>
                <li>Movement of drones, fishes, monsters</li>
                <li>Drone ↔ monster collision management</li>
                <li>Updating monster targets</li>
                <li>Fish scans</li>
                <li>Saving drone scans at y ≤ <const>500</const>
                </li>
                <li>Emergency repairs for drones at y = <const>0</const>
                </li>
                <li>Updating fish speed</li>
                <li>Updating monster speed according to their targets</li>

            </ul>
        </div>
    </div>
    <!-- END -->


    <!-- PROTOCOL -->
    <div class="statement-section statement-protocol">
        <h2 style="font-size: 20px;">
            <span class="icon icon-protocol">&nbsp;</span>
            <span>Game Protocol</span>
        </h2>

        <!-- Protocol block -->
        <div class="blk">
            <div class="title">Initialization Input</div>
            <span class="statement-lineno">First line:</span> <var>creatureCount</var> an integer for the number of
            creatures in
            the game zone. Will always be <const>12</const>.<br>
            <span class="statement-lineno">Next <var>creatureCount</var> lines:</span> 3 integers describing each
            creature:
            <ul>
                <li><var>creatureId</var> for this creature's unique id.</li>
                <!-- BEGIN level1 level2 level3 -->
                <li><var>color</var>
                    <const>(0 to 3)</const> and <var>type</var>
                    <const>(0 to 2)</const>.
                </li>
                <!-- END -->
                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                    <!-- END -->
                    <!-- BEGIN level5 -->
                <li>
                    <!-- END -->
                    <!-- BEGIN level4 level5 -->
                    <var>color</var>
                    <const>(0 to 3)</const> and <var>type</var>
                    <const>(0 to 2)</const>.
                    Monsters will be shown as <const>-1 -1</const>.
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

            <div class="title">Input for One Game Turn</div>
            <var>myScore</var> for you current score.<br />
            <var>foeScore</var> for you opponent's score.<br />
            <br />
            <var>myScanCount</var> for your amount of <b>scans</b><br />
            <span class="statement-lineno">Next <var>myScanCount</var> lines:</span> <var>creatureId</var> for each
            scan.<br />
            <br />
            <var>foeScanCount</var> for your opponent's amount of
            <b>scans</b>.<br />
            <span class="statement-lineno">Next <var>foeScanCount</var> lines:</span> <var>creatureId</var> for each
            scan of your opponent.<br />
            <br />
            <span class="statement-lineno">For your drone:</span>
            <ul>
                <li><var>droneId</var>: this drone's unique id.</li>
                <li><var>droneX</var> and <var>droneY</var>: this drone's position.</li>
                <li><var>battery</var>: this drone's current battery level.
            </ul>

            <span class="statement-lineno">Next, for your opponent's drone:</span>
            <ul>
                <li><var>droneId</var>: this drone's unique id.</li>
                <li><var>droneX</var> and <var>droneY</var>: this drone's position.</li>


                <li><var>battery</var>: this drone's current battery level.
            </ul>
            <br />

            <span class="statement-lineno">For every fish:</span>
            <ul>
                <li><var>creatureId</var>: this creature's unique id.</li>
                <li><var>creatureX</var> and <var>creatureY</var>: this creature's position.</li>
                <li><var>creatureVx</var> and <var>creatureVy</var>: this creature's current speed.</li>
            </ul>
            The rest of the variables can be ignored and will be used in later leagues.
            <!-- END -->


            <!-- BEGIN level2 level3 level4 level5 -->
            <div class="title">Input for One Game Turn</div>

            <span class="statement-lineno">Next line:</span> <var>myScore</var> for you current score.<br />
            <span class="statement-lineno">Next line:</span> <var>foeScore</var> for you opponent's score.<br />
            <br />
            <span class="statement-lineno">Next line:</span> <var>myScanCount</var> for your amount of <b>saved</b>
            scans.<br />
            <span class="statement-lineno">Next <var>myScanCount</var> lines:</span> <var>creatureId</var> for each
            scan
            scored.<br />
            <br />
            <span class="statement-lineno">Next line:</span> <var>foeScanCount</var> for your opponent's amount of
            <b>saved</b> scans.<br />
            <span class="statement-lineno">Next <var>foeScanCount</var> lines:</span> <var>creatureId</var> for each
            scan scored by your opponent.<br />
            <br />
            <span class="statement-lineno">Next line:</span> <var>myDroneCount</var> for the number of drones you
            control.<br />
            <span class="statement-lineno">Next <var>myDroneCount</var> lines:</span>
            <ul>
                <li><var>droneId</var>: this drone's unique id.</li>
                <li><var>droneX</var> and <var>droneY</var>: this drone's position.</li>
                <!-- BEGIN level2 level3 -->
                <li><var>emergency</var>: unused in this league.</li>
                <!-- END -->


                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                    <!-- END -->
                    <!-- BEGIN level5 -->
                <li>
                    <!-- END -->
                    <!-- BEGIN level4 level5 -->
                    <var>emergency</var>: <const>1</const>
                    if
                    the drone is in emergency mode, <const>0</const> otherwise.
                    <!-- END -->
                    <!-- BEGIN level4 -->
                </li>
                <!-- END -->
                <!-- BEGIN level5 -->
                </li>
                <!-- END -->



                <li><var>battery</var>: this drone's current battery level.
            </ul>
            <span class="statement-lineno">Next line:</span> <var>foeDroneCount</var> for the number of drones your
            opponent controls.<br />
            <span class="statement-lineno">Next <var>foeDroneCount</var> lines:</span>
            <ul>
                <li><var>droneId</var>: this drone's unique id.</li>
                <li><var>droneX</var> and <var>droneY</var>: this drone's position.</li>
                <!-- BEGIN level2 level3 -->
                <li><var>emergency</var>: unused in this league.</li>
                <!-- END -->

                <!-- BEGIN level4 -->
                <li class="statement-new-league-rule" style="margin-left: 0;">
                    <!-- END -->
                    <!-- BEGIN level5 -->
                <li>
                    <!-- END -->
                    <!-- BEGIN level4 level5 -->
                    <var>emergency</var>: <const>1</const>
                    if
                    the drone is in emergency mode, <const>0</const> otherwise.
                    <!-- END -->
                    <!-- BEGIN level4 -->
                </li>
                <!-- END -->
                <!-- BEGIN level5 -->
                </li>
                <!-- END -->

                <li><var>battery</var>: this drone's current battery level.
            </ul>


            

            <span class="statement-lineno">Next line:</span> <var>droneScanCount</var> for the amount of scans
            currently
            within a drone.<br />
            <span class="statement-lineno">Next <var>droneScanCount</var> lines:</span> <var>droneId</var> and
            <var>creatureId</var> describing which drone contains a scan of which fish.<br />
            <br />
            <span class="statement-lineno">Next line:</span> <var>visibleCreatureCount</var> the number of creatures
            within the light radius of your drones.<br />
            <span class="statement-lineno">Next <var>visibleCreatureCount</var> lines:</span>
            <ul>
                <li><var>creatureId</var>: this creature's unique id.</li>
                <li><var>creatureX</var> and <var>creatureY</var>: this creature's position.</li>
                <li><var>creatureVx</var> and <var>creatureVy</var>: this creature's current speed.</li>
            </ul>
            <span class="statement-lineno">Next line:</span> <var>radarBlipCount</var>.<br />
            <span class="statement-lineno">Next <var>radarBlipCount</var> lines:</span>
            Two integers <var>droneId</var>, <var>creatureId</var> and a string <var>radar</var> indicating the
            relative
            position between each creature and each one of your drones. <var>radar</var> can be:<ul>
                <li>
                    <const>TL</const>: the creature is to the top-left of the drone.
                </li>
                <li>
                    <const>TR</const>: the creature is to the top-right of the drone.
                </li>
                <li>
                    <const>BR</const>: the creature is to the bottom-right of the drone.
                </li>
                <li>
                    <const>BL</const>: the creature is to the bottom-left of the drone.
                </li>
            </ul>
            
            <!-- END -->
        </div>

        <div class="blk">
            <div class="title">Output</div>
            <div class="text">

                <!-- BEGIN level1 level2 -->
                <span class="statement-lineno">One line:</span> one valid instruction for your drone:
                <!-- END -->

                <!-- BEGIN level3 -->
                <div class="statement-new-league-rule">
                    <!-- END -->
                    <!-- BEGIN level3 level4 level5 -->

                    <span class="statement-lineno">Next <var>myDroneCount</var> lines:</span> one valid instruction
                    for
                    each
                    of your drones, in the same order the drones were provided to you:
                    <!-- END -->
                    <!-- BEGIN level3 -->
                </div>
                <!-- END -->

                <ul>
                    <li>
                        <action>MOVE <var>x</var> <var>y</var> <var>light</var></action>: makes the drone move
                        towards
                        <var>(x,y)</var>, engines on.
                    </li>
                    <li>
                        <action>WAIT <var>light</var></action>. Switches engines off. The drone will sink but can
                        still
                        use light to scan nearby creatures.
                    </li>
                </ul>
                Set <var>light</var> to <const>1</const> to activate the
                powerful light, <const>0</const> otherwise.

                
            </div>
        </div>



        <div class="blk">
            <div class="title">Constraints</div>
            <div class="text">
                <!-- BEGIN level1 level2 level3 -->
                <var>creatureCount</var> = <const>12</const> in this league<br />
                <!-- END -->

                <!-- BEGIN level4 -->
                <div class="statement-new-league-rule">
                    <!-- END -->
                    <!-- BEGIN level4 level5 -->
                    <const>13</const> &le; <var>creatureCount</var> &le; <const>20</const> depending on the number of
                    monsters on the map.<br />
                    <!-- END -->
                    <!-- BEGIN level4 -->
                </div>
                <!-- END -->

                <!-- BEGIN level1 level2 -->
                <var>myDroneCount</var> = <const>1</const> in this league<br>
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
                Response time per turn ≤ <const>50</const>ms<br>
                Response time for the first turn ≤ <const>1000</const>ms
            </div>
        </div>
    </div>

    <!-- BEGIN level1 level2 level3 -->
    <!-- LEAGUE ALERT -->
    <div
        style="color: #7cc576; background-color: rgba(124, 197, 118, .1); padding: 20px; margin-top: 10px; text-align: left;">
        <div style="text-align: center; margin-bottom: 6px">
            <img src="//cdn.codingame.com/smash-the-code/statement/league_wood_04.png" />
        </div>
        <div style="text-align: center; font-weight: 700; margin-bottom: 6px;">
            What awaits me in the following leagues?
        </div>
        <ul>
            <!-- BEGIN level1 -->
            <li>Only close by fish will be visible</li>
            <!-- END -->
            <!-- BEGIN level1 level2 -->
            <li>You will be able to control 2 drones</li>
            <!-- END -->
            <!-- BEGIN level1 level2 level3 -->
            <li>Deep sea monsters will roam</li>
            <!-- END -->
        </ul>
    </div>
    <!-- END -->

    <!-- STORY -->
    <div class="statement-story-background">
        <div class="statement-story-cover"
            style="background-size: cover; background-image: url(/servlet/fileservlet?id=113029027506177)">
            <div class="statement-story" style="min-height: 300px; position: relative">
                <h2><span style="color: #b3b9ad">To Start</span></h2>
                <div class="story-text">
                    Why not start the battle with one of these <b>IA Starters</b>, provided by the team:
                    <p>
                        <a style="color: #f2bb13; border-bottom: 1px dotted #f2bb13;" rel="nofollow" target="_blank"
                                href="https://github.com/CodinGame/FallChallenge2023-SeabedSecurity/tree/main/starterAIs">https://github.com/CodinGame/FallChallenge2023-SeabedSecurity/tree/main/starterAIs</a>
</p>
                   
                    <p>
                        You can modify them to match your style or take them as an example to code everything from
                        scratch.
                    </p>

                    <p>You can view the source code of this game on <a rel="nofollow" style="color: #f2bb13; border-bottom: 1px dotted #f2bb13;" target="_blank"
		href="https://github.com/CodinGame/FallChallenge2023-SeabedSecurity">this GitHub repo</a>.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- SHOW_SAVE_PDF_BUTTON -->