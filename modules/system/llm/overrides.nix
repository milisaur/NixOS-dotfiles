{
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (python-final: python-prev: {
            fpdf2 = python-prev.fpdf2.overridePythonAttrs (old: {
              disabledTests =
                (old.disabledTests or [])
                ++ [
                  "test_image_with_explicit_dimensions"
                ];
            });
          })
        ];
    })
  ];
}
