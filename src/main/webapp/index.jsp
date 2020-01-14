<html>
<head>
    <title>Painikepeli</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        var pelaajanPisteet;
        $(document).ready(function () {

            if (typeof window !== 'undefined') {
                if (localStorage.hasOwnProperty('pelaajanPisteetStorage') !== null) {                                //tatkastetaan onko localstoragessa entisestä sessiosta pisteitä
                    pelaajanPisteet = localStorage.getItem('pelaajanPisteetStorage');
                    document.getElementById("pelaajanPisteetID").innerHTML = localStorage.getItem('pelaajanPisteetStorage');
                }
            } else {                                                                                                 //jos edellisiä pisteitä ei lytynyt, annetaan pelaajalle 20 pistettä
                pelaajanPisteet = 20;
                document.getElementById("pelaajanPisteetID").innerHTML = pelaajanPisteet;
                localStorage.setItem('pelaajanPisteetStorage', pelaajanPisteet);                                      //tallennetaan pisteet localstorageen
            }

        });


        $(document).ready(function () {
            setInterval(fetchkierros, 50);                                               //kutsutaan fetchkierros, joka hakee uusimman kierrosluvun servletistä
        });

        function fetchkierros() {
            $.post('/laskePisteet', function (kierros) {                                //POST ei lisää kierroslukua. Tarkoituksena hakea servletiltä kierrosluku.
                if (pelaajanPisteet <= 0) {                                             //jos pelaajan pisteet 0 kysytään halutaanko käynnistää peli uudelleen
                    if (confirm('Restart game?')) {                                     //ja palautetaan pelaajalle 20 pistettä
                        pelaajanPisteet = 20;
                        document.getElementById("pelaajanPisteetID").innerHTML = pelaajanPisteet;
                    }
                }
                return kierros;
            });
        }


        function clickMethod() {
            if (pelaajanPisteet > 0) {
                $.get('/laskePisteet', function (kierros) {                                 //GET lisätään kierroslaskuriin kierros
                    painalluksiaSeuraavaanVoittoon();
                    pelaajanPisteet--;                                                      //miinustetaan pelaajan pisteitä
                    if (kierros % 10 === 0 && kierros % 100 !== 0 && kierros % 500 !== 0) {     //lasketaan voiton määrä
                        pelaajanPisteet = pelaajanPisteet + 5;
                    } else if (kierros % 100 === 0 && kierros % 500 !== 0) {
                        pelaajanPisteet = pelaajanPisteet + 40;
                    } else if (kierros % 500 === 0) {
                        pelaajanPisteet = pelaajanPisteet + 250;
                    }
                    document.getElementById("pelaajanPisteetID").innerHTML = pelaajanPisteet;
                    localStorage.setItem('pelaajanPisteetStorage', pelaajanPisteet)                                 //tallennetaan localstorageen uudet pisteet
                });
            }
        }

        function painalluksiaSeuraavaanVoittoon() {
            $.post('/laskePisteet', function (kierros) {                                    //haetaan uusin kierroslukumäärä ja lasketaan kuinka paljon painalluksia voittoon
                document.getElementById("painalluksiaVoittoon").innerHTML = (10 - (parseInt(kierros) % 10)).toString();
            });
        }

    </script>
</head>
<body>
<div class="main">


    <h2>Pisteesi: </h2>
    <h2 id="pelaajanPisteetID">20</h2>

    <h2>Painalluksia seuraavaan voittoon: </h2>
    <h2 id="painalluksiaVoittoon"></h2>

    <br>
    <br>

    <button onclick="clickMethod()">Pelaa!</button>
</div>
</body>
