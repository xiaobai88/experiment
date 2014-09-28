clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_words.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_voting/topk_cats.mat;

% compute binary accuracy
max_top1_accuracy=binary_accuracy(ground_truth_words,max_top1_cats);
max_top5_accuracy=binary_accuracy(ground_truth_words,max_top5_cats);
max_top10_accuracy=binary_accuracy(ground_truth_words,max_top10_cats);



fprintf('\nmax_top1_accuracy: %.3f',max_top1_accuracy);
fprintf('\nmax_top5_accuracy: %.3f',max_top5_accuracy);
fprintf('\nmax_top10_accuracy: %.3f\n',max_top10_accuracy);
