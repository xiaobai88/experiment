clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_words.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_cats.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_offsets.mat;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute binary accuracy with topk ancestors
max_top1_accuracy=binary_accuracy_ancestor(ground_truth_words,max_top1_cats,max_top1_offsets);
max_top5_accuracy=binary_accuracy_ancestor(ground_truth_words,max_top5_cats,max_top5_offsets);
max_top10_accuracy=binary_accuracy_ancestor(ground_truth_words,max_top10_cats,max_top10_offsets);

avg0_top1_accuracy=binary_accuracy_ancestor(ground_truth_words,avg0_top1_cats,avg0_top1_offsets);
avg0_top5_accuracy=binary_accuracy_ancestor(ground_truth_words,avg0_top5_cats,avg0_top5_offsets);
avg0_top10_accuracy=binary_accuracy_ancestor(ground_truth_words,avg0_top10_cats,avg0_top10_offsets);

avg1_top1_accuracy=binary_accuracy_ancestor(ground_truth_words,avg1_top1_cats,avg1_top1_offsets);
avg1_top5_accuracy=binary_accuracy_ancestor(ground_truth_words,avg1_top5_cats,avg1_top5_offsets);
avg1_top10_accuracy=binary_accuracy_ancestor(ground_truth_words,avg1_top10_cats,avg1_top10_offsets);

accuracy_with_ancestors = [max_top1_accuracy, max_top5_accuracy, max_top10_accuracy;
                    avg0_top1_accuracy, avg0_top5_accuracy, avg0_top10_accuracy;
                    avg1_top1_accuracy, avg1_top5_accuracy, avg1_top10_accuracy];
save /home/hxu1/lsda/youtube_experiment/code/our_ground_truth_accuracy/topk_ancestors_accuracy_result/accuracy_with_ancestors_words.mat accuracy_with_ancestors

fprintf('\ncompute our ground truth binary accuracy with topk ancestors:');
fprintf('\nmax_top1_accuracy: %.3f',max_top1_accuracy);
fprintf('\nmax_top5_accuracy: %.3f',max_top5_accuracy);
fprintf('\nmax_top10_accuracy: %.3f',max_top10_accuracy);
fprintf('\n\navg0_top1_accuracy: %.3f',avg0_top1_accuracy);
fprintf('\navg0_top5_accuracy: %.3f',avg0_top5_accuracy);
fprintf('\navg0_top10_accuracy: %.3f',avg0_top10_accuracy);
fprintf('\n\navg1_top1_accuracy: %.3f',avg1_top1_accuracy);
fprintf('\navg1_top5_accuracy: %.3f',avg1_top5_accuracy);
fprintf('\navg1_top10_accuracy: %.3f\n\n',avg1_top10_accuracy);