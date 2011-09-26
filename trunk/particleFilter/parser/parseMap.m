function MAP = parseMap()

%compile c parser
dos('gcc parser/bee-map.c -o parser/mapParser');

%use parser on map data
dos('rm data/maps/MAP.txt');
dos('./parser/mapParser data/maps/wean.dat >> data/maps/MAP.txt');

%load parsed map
load MAP.txt;
MAP = reshape(MAP,800,800);