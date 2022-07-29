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

The original code looked roughly like this:

```matlab
function A = auroc(tp, fp)
    n = size(tp, 1);
    A = sum((fp(2:n) - fp(1:n-1)).*(tp(2:n)+tp(1:n-1)))/2;
endfunction
```
"""

module CawleyAUC

export auc

function auc(tp::Matrix{Float64}, fp::Matrix{Float64})
    n = size(tp, 1)
    return sum((fp[2:n] - fp[1:n-1]) .* (tp[2:n] + tp[1:n-1]))/2
end

end # module
