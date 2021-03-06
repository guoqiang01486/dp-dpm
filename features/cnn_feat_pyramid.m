function pyra = cnn_feat_pyramid(im, model, padx, pady, image_id)

if ~exist('padx', 'var') || isempty(padx) || ...
   ~exist('pady', 'var') || isempty(pady)
  [padx, pady] = getpadding(model);
end

if exist('image_id', 'var') || ~isempty(image_id)
  cache_dir = get_feat_cache_dir();
  cache_opts.cache_file = [cache_dir '/' image_id '.mat'];
  cache_opts.write_on_miss = true;
end
cache_opts.debug = false;
pyra = deep_pyramid_cache_wrapper(im, model.cnn, cache_opts);
pyra = deep_pyramid_add_padding(pyra, padx, pady, false);

feat_scale = 1/50;
for i = 1:pyra.num_levels
  pyra.feat{i} = feat_scale * pyra.feat{i};
end
