function test_suite = test_omp
  initTestSuite;
end


function [A, x, b, k] = problem_1()
    m = 100;
    n = 1000;
    k = 4;
    A = SPX_SimpleDicts.gaussian_dict(m, n);
    gen = SPX_SparseSignalGenerator(n, k);
    % create a sparse vector
    x =  gen.biGaussian();
    b = A*x;
end

function [dict, reps, signals, k] = problem_2()
    m = 200;
    n = 1000;
    k = 10;
    s = 500;
    dict = SPX_SimpleDicts.gaussian_dict(m, n);
    gen = SPX_SparseSignalGenerator(n, k, s);
    % create a sparse vector
    reps =  gen.biGaussian();
    signals = dict*reps;
end



function test_naive_omp_1
    [A, x, b, k] = problem_1();
    solver = SPX_OrthogonalMatchingPursuit(A, k);
    result = solver.solve(b);
    cmpare = SPX_SparseSignalsComparison(x, result.z, k);
    %cmpare.summarize();
    assertTrue(cmpare.has_matching_supports(1.0));
end


function test_naive_omp_2
    [dict, reps, signals, k] = problem_2();
    solver = SPX_OrthogonalMatchingPursuit(dict, k);
    ns = size(signals, 2);
    dd = size(dict, 2);
    recovered = zeros(dd, ns);
    for s=1:ns
        signal = signals(:, s);
        result = solver.solve(signal);
        recovered(:, s) = result.z;
    end
    cmpare = SPX_SparseSignalsComparison(reps, recovered, k);
    % cmpare.summarize();
    assertTrue(cmpare.has_matching_supports(1.0));
end


function test_omp_qr_1
    [A, x, b, k] = problem_1();
    solver = SPX_OrthogonalMatchingPursuit(A, k);
    result = solver.solve_qr(b);
    cmpare = SPX_SparseSignalsComparison(x, result.z, k);
    %cmpare.summarize();
    assertTrue(cmpare.has_matching_supports(1.0));
end

function test_omp_qr_2
    [dict, reps, signals, k] = problem_2();
    solver = SPX_OrthogonalMatchingPursuit(dict, k);
    ns = size(signals, 2);
    dd = size(dict, 2);
    recovered = zeros(dd, ns);
    for s=1:ns
        signal = signals(:, s);
        result = solver.solve_qr(signal);
        recovered(:, s) = result.z;
    end
    cmpare = SPX_SparseSignalsComparison(reps, recovered, k);
    % cmpare.summarize();
    assertTrue(cmpare.has_matching_supports(1.0));
end
