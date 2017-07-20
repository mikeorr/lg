function m = splice_mat(xx, yy, zz)
    ## `splice_mat' merges matrices XX, YY, and ZZ into matrix M so that
    ## M can be used in a call to `gsplot' when Gnuplot is in parametric
    ## mode.  Matrices XX and YY usually have been generated by a call
    ## to `meshgrid', and ZZ = some_function(XX, YY).

    if any(size(xx) != size(yy))
        error("Matrices XX and YY have incompatible sizes.");
    endif
    if any(size(xx) != size(zz))
        error("Matrices XX and ZZ have incompatible sizes.");
    endif

    [rows, cols] = size(xx);
    m = zeros(rows, 3*cols);

    for i = 1 : cols
        m(:, 3*i - 2) = xx(:, i);
        m(:, 3*i - 1) = yy(:, i);
        m(:, 3*i    ) = zz(:, i);
    endfor
endfunction
