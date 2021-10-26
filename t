
Tampermonkey® by Jan Biniok
v4.13
	
Polska Mowa 2.0
by Jan (jxn_30) modded by Crazycake / Wersja Polska by : Matt998
1
// ==UserScript==
2
// @name         Polska Mowa 2.0
3
// @version      1.0.2
4
// @description  Polskie dzwięki.
5
// @author       Jan (jxn_30) modded by Crazycake / Wersja Polska by : Matt998
6
// @include      *://www.operatorratunkowy.pl/*
7
// @include      *://www.operatorratunkowy.pl/missions/\d+//*
8
// @include      https://www.operatorratunkowy.pl/missions/\d+/
9
// @grant        none
10
// ==/UserScript==
11
​
12
(function() {
13
    'use strict';
14
​
15
    const useVehicleType = true;
16
    const playGong = false;
17
    const gongUrl = '';
18
    const renamedVariables = [
19
        ["-", " "], ["KSRG", " "], ["PC", " "], [" FIRE 1", " "], ["HZS Královéhradeckého kraje - ÚO NÁCHOD", "HZS Nachud"], ["TECH 1", " "], ["TECH 2", " "], ["TECH 3", " "], ["POL 1", " "], ["POL 2", " "], ["POL 3", " "], ["FIRE 2", " "], ["FIRE 3", " "], ["KMP", "Komenda Miejska Policji"], ["KPP", "Komenda Powiatowa Policji"], ["KP PSP", " "], ["FuStW", "Funkstreife"], ["2/16", "Dwa Na szesnaście"], ["GBARt", "Gaśniczy"], ["LPR", "Śmigłowiec Lotniczego Pogotowia Ratunkowego"], ["MAN", "M A N"], ["GBM", "Gaśniczy"], ["POLICJA", "Radiowóz Ogniwa Patrolowo-Interwencyjnego"], [",", " -  oraz -  "], ["MB", "Mercedes benz"], ["RT", ""], ["25", "25"], ["/", "Na"], ["(S)", "Specjalistyczna"], ["(P)", "Podstawowa"], ["VW", "volkswagen"], ["AMZ", "A M Z"], ["WAS", ""], ["Y", "Igrek"], ["GLM", "Lekki Gaśniczy"], ["Spec. ", "Specjalistyczne"], ["26", "dwadzieścia sześć"], ["Św.", "świętego "], ["SD", "Drabina"], ["SHD", "Podnośnik Hydrauliczny"], ["SH", "Podnośnik Hydrauliczny"], ["SLOp", "Samochód Operacyjny"], ["GBA", "Gaśniczy"], ["GCBA", "Ciężki gaśniczy"], ["GLBM", "Lekki Gaśniczy"], ["SLRt", "Techniczny"], ["SLRt (RT)", "Techniczny"], ["SRt", "Techniczny"], ["SCZ", "Cysterna"], ["GCBM", "Cysterna"], ["SPGaz", "Samochód ze sprzętem ochrony dróg oddechowych"], ["RChem", "Chemiczny"], ["SRd", "Ratownictwo drogowe"], ["SLRd", "Ratownictwo drogowe"], ["SLRr", "Rozpoznawczo Ratunkowy"], ["GCBA", "Ciężki gaśniczy"], ["WRD", "radiowóz Wydziału Ruchu Drogowego"], ["T 4", "Te Cztery"], ["SHD-25", "S H D Dwadzieścia Pięć"], ["SD-30", "S D Trzydzieści"], ["SD-53", "S D Piędziesiąt Trzy"], ["244", "Dwa cztery cztery"], ["Star 266", "Star Dwa Sześć sześć"], ["422", "Cztery dwa dwa"], ["TGE", "T G E"], ["SLwys", "Ratownictwo Wysokościowe"], ["ZOZ", "Zespół Opieki Zdrowotnej"],
20
    ];    
21
​
22
    const alarmBtns = document.getElementById('mission_alliance_share_btn').parentElement.children;
23
    Array.from(alarmBtns).forEach(btn => btn.addEventListener('click', () => {
24
        const vehicles = Array.from(document.querySelectorAll('#vehicle_show_table_body_all .vehicle_select_table_tr')).filter(r => r.querySelector('.vehicle_checkbox:checked'));
25
        const buildings = {};
26
        vehicles.forEach(vehicle => {
27
            const building = vehicle.querySelector('a[href^="/buildings/"]');
28
            if (!building) return;
29
            const buildingCaption = building.textContent.trim();
30
            const buildingId = building.href.match(/\d+$/)[0];
31
            if (!buildings.hasOwnProperty(buildingId)) buildings[buildingId] = {caption: buildingCaption, vehicles: []};
32
            //buildings[buildingId].vehicles.push(vehicle.querySelector('.mission_vehicle_label').textContent.trim());
33
            buildings[buildingId].vehicles.push(useVehicleType ? vehicle.getAttribute('vehicle_type') : vehicle.querySelector('.mission_vehicle_label').textContent.trim());
34
        });
35
        let speech = 'ALARM : ' + Object.values(buildings).map(b => ` :  ${b.caption}: :- ${b.vehicles}!`).join(' ') + ': ' + document.getElementById('missionH1').textContent.trim();
36
        for(var i = 0; i < renamedVariables.length; i++)
37
    {
38
         speech = speech.replaceAll(renamedVariables[i][0], renamedVariables[i][1]);
39
    }
40
        tellParent(`const alarmt2s = new SpeechSynthesisUtterance();alarmt2s.text = ${JSON.stringify(speech)};alarmt2s.lang = speechSynthesis.getVoices().find(voice => voice.lang === 'pl');alarmt2s.rate = 1;${playGong ? `const gong = new Audio('${gongUrl}');gong.addEventListener('ended', () => ` : ''}speechSynthesis.speak(alarmt2s)${playGong ? `);gong.play();` : ''}`);
41
    }));
42
})();
43
​
