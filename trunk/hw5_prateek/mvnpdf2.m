function p = mvnpdf2(X, mu, sigma)
    [R, err] = cholcov(sigma, 0);

    if err
        error('%s', 'sigma is not both symmetric and positive definite');
    end

    X0 = bsxfun(@minus, X, mu) / R;
    d = min(size(X));
    slogdet = sum(log(diag(R)));
    p = exp(-0.5 * sum(X0 .^ 2, 2) - slogdet - 0.5 * d * log(2 * pi));
end