function [ fig ] = displayPhaseSpace( focusedMask, numOfParticles, exitR, entryRvec, ...
                                    startGamma, startBetaR, endGamma, endBetaR, notFocusedMask, plotNotFocused, params_str)
%PLOTPHASESPACE Summary of this function goes here
%   Detailed explanation goes here
passMask = logical(focusedMask + notFocusedMask);
entryPhase = startGamma.*startBetaR;
endPhase   = endGamma.*endBetaR;
if(sum(passMask) == 0 )
    fig = 0;
    return
end

fig = figure();
    ax1 = axes('Position',[0 0.05 0.5 0.815],'Visible','off');
    ax2 = axes('Position',[0.17 0.1 0.8 0.8],'Visible','off');
    axes(ax1);
    text(.025,0.55, params_str);
    axes(ax2);
    
    legPlot(1) = plot(NaN,NaN,'r+');    hold on;
    legPlot(2) = plot(NaN,NaN,'b+');
    plot(exitR(focusedMask),  endPhase(focusedMask), 'r+')
    plot(entryRvec(focusedMask),entryPhase(focusedMask), 'b+')
    i=1;
    if(plotNotFocused)
        legPlot(3) = plot(NaN,NaN, '-');
        legPlot(4) = plot(NaN,NaN,'--');
        plot(exitR(notFocusedMask), endPhase(notFocusedMask), 'r+')
        plot(entryRvec(notFocusedMask), entryPhase(notFocusedMask), 'b+')
        while i <= numOfParticles
                while ((focusedMask(i) == 0) && (notFocusedMask(i) == 0) && i<= numOfParticles)
                    i=i+1;
                    if(i>numOfParticles); break; end
                end
                if (i>numOfParticles); break; end
                if (focusedMask(i) == 1)
                    plot([exitR(i), entryRvec(i)],[endPhase(i), entryPhase(i)])
                else
                    plot([exitR(i), entryRvec(i)],[endPhase(i), entryPhase(i)],'--')
                end
                i=i+1;
        end
        hold off
        leg = legend (legPlot,'Exit Phase', 'Start Phase', 'Focused', 'Not Focused');
        leg.Location = 'northeast';
        xl = max(abs([min(min(exitR(passMask)),     min(entryRvec (passMask)))  max(max(exitR(passMask)),     max(entryRvec(passMask)))]));
        yl = max(abs([min(min(min(endPhase(passMask))), min(entryPhase(passMask)))  max(max(max(endPhase(passMask))), max(entryPhase(passMask)))]));
        xlim(1.1.*[-xl xl]);
        ylim(1.1.*[-yl yl]); 
    else
        while i <= numOfParticles
                while ((focusedMask(i) == 0) && i<= numOfParticles)
                    i=i+1;
                    if(i>numOfParticles); break; end
                end
                if (i>numOfParticles); break; end
                plot([exitR(i), entryRvec(i)],[endPhase(i), entryPhase(i)])
                i=i+1;
        end
        hold off
        leg = legend (legPlot,'Exit Phase', 'Start Phase');
        leg.Location = 'northeast';
        xl = max(abs([min(min(exitR(focusedMask)),     min(entryRvec (focusedMask)))  max(max(exitR(focusedMask)),     max(entryRvec(focusedMask)))]));
        yl = max(abs([min(min(min(endPhase(focusedMask))), min(entryPhase(focusedMask)))  max(max(max(endPhase(focusedMask))), max(entryPhase(focusedMask)))]));
        xlim(1.1.*[-xl xl]);
        ylim(1.1.*[-yl yl]);   
    end 
    xlabel('Entry/Exit X')
    ylabel('\gamma\beta_x')
    title('Particle Phase Space')

    
end

