function [] = plotMfs(fis)
    fis = readfis('fuzzysystem.fis');
    plotmf(fis,'input',1); saveas(gca,'../Report/images/mf_L.png');
    plotmf(fis,'input',2); saveas(gca,'../Report/images/mf_c.png');
    plotmf(fis,'input',3); saveas(gca,'../Report/images/mf_h.png');
    plotmf(fis,'input',4); saveas(gca,'../Report/images/mf_de.png');
end

