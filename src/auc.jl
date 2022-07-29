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
Adapted from MATLAB code by Dr. Gavin C. Cawley.

http://theoval.cmp.uea.ac.uk/matlab/#roc

The original code looked roughly like this:

```matlab
function A = auroc(tp, fp)
    n = size(tp, 1);
    A = sum((fp(2:n) - fp(1:n-1)).*(tp(2:n)+tp(1:n-1)))/2;
endfunction
```

The comments in the original MATLAB source, this was developed
or released around 2001-03-22:

- 2001-03-22: v1.00
- 2004-11-10: v1.01 - minor improvements to comments etc.

Cawley's motivation included the description:

> An ROC (receiver operator characteristic) curve is a plot of the true
> positive rate as a function of the false positive rate of a classifier
> system. The area under the ROC curve is a reasonable performance
> statistic for classifier systems assuming no knowledge of the true ratio
> of misclassification costs.
>
> A = AUROC(TP, FP) computes the area under the ROC curve, where TP and FP
> are column vectors defining the ROC or ROCCH curve of a classifier system.

References
----------

[1] Fawcett, T., "ROC graphs: Notes and practical considerations for
    researchers", Technical report, HP Laboratories, MS 1143, 1501
    Page Mill Road, Palo Alto CA 94304, USA, April 2004.
"""

module CawleyAUC

export auc

function auc(tp::Matrix{Float64}, fp::Matrix{Float64})
    n = size(tp, 1)
    return sum((fp[2:n] - fp[1:n-1]) .* (tp[2:n] + tp[1:n-1]))/2
end

end # module
