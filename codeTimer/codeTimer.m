% =============================================================================
function codeTimer( sampleSize, varargin )

  numFunctions = length( varargin );

  param = 3e7;

  % times
  t = zeros(numFunctions,1);

  for i = 1:sampleSize
      fprintf( 'Sample %d...', i );
      for codeIndex = 1:numFunctions
          time = varargin{codeIndex}( param );
          t(codeIndex) = t(codeIndex) + time;
      end
      fprintf( 'done.\n' );
  end

  averageT = t/sampleSize;

  fprintf( '\n\n' );
  for codeIndex = 1:numFunctions
     fprintf( 'Code piece %d: %d s\n\n', codeIndex, averageT(codeIndex) );
  end
end
% =============================================================================