# Copyright © 2004-2008 G. C. Cawley
# Copyright © 2022 Alexander L. Hayes
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

"""
Adapted from Matlab code by Dr. Gavin C. Cawley.

http://theoval.cmp.uea.ac.uk/matlab/#roc

```matlab
function [tp, fp] = roc(t, y)
    ntp = size(y,1);
    % sort by classeifier output
    [y,idx] = sort(y, 'descend');
    t = t(idx) > 0;
    % generate ROC
    P = sum(t);
    N = ntp - P;
    fp = zeros(ntp+2,1);
    tp = zeros(ntp+2,1);
    FP = 0;
    TP = 0;
    n = 1;
    yprev = -realmax;
    for i=1:ntp
       if y(i) ~= yprev
          tp(n) = TP/P;
          fp(n) = FP/N;
          yprev = y(i);
          n = n + 1;
       end
       if t(i) == 1
          TP = TP + 1;
       else
          FP = FP + 1;
       end
    end
    tp(n) = 1;
    fp(n) = 1;
    fp = fp(1:n);
    tp = tp(1:n);
endfunction
```

Sample call:

```matlab
>>> [tp, fp] = roc([0, 0, 0, 1, 1, 1]', [0.2 0.3 0.6 0.4  0.7 0.8]')
tp = [0.00000, 0.33333, 0.66667, 0.66667, 1.00000, 1.00000, 1.00000]'
fp = [0.00000, 0.00000, 0.00000, 0.33333, 0.33333, 0.66667, 1.00000]'
```

Based on comments in the original source file, this was developed or
released around Friday, 2005-06-09 and went through several updates:

- 2004-11-10: v1.00
- 2005-06-09: v1.10 - minor recoding
- 2008-09-05: v2.00 - re-write using algorithm from [1]

References
----------

[1] Fawcett, T., "ROC graphs: Notes and practical considerations for
    researchers", Technical report, HP Laboratories, MS 1143, 1501
    Page Mill Road, Palo Alto CA 94304, USA, April 2004.
"""

module CawleyROC

export roc

function roc(y_true::Vector{Int64}, y_pred::Vector{Float64})

    n_tp = size(y_pred, 1)

    y = sortperm(y_pred, rev=true)
    t = y_true[y]

    P = sum(t)
    N = n_tp - P

    fp = zeros(n_tp + 1, 1)
    tp = zeros(n_tp + 1, 1)

    FP = TP = 0
    n = 1

    yprev = -Inf

    for i in 1:n_tp

        if y[i] != yprev
            tp[n] = TP/P
            fp[n] = FP/N
            yprev = y[i]
            n += 1
        end

        if t[i] == 1
            TP += 1
        else
            FP += 1
        end
    end

    tp[n] = 1.0
    fp[n] = 1.0

    return tp, fp
end

end # module
