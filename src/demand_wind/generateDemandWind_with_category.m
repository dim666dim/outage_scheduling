function  [demand_with_category,wind_with_category] = generateDemandWind_with_category(time_vector,params,state,isStochastic,category_num)
% draw a daily factor and inflate demand, deflate wind with that factor
run('get_global_constants.m');

categories = [1,3,5.5];

if(nargin>4) %deterministic or random choice of daily profile
    i_category = categories(1+mod(category_num-1,length(categories)));
else
    i_category = randsample(categories,1); 
end
% num_categories = 5;
% i_category=3; %TODO: when we see the overall program works well, we can change the category to be sampled from num_categories

base_demand_factor = 0.15;

demand = generateDemand(time_vector,params,state,isStochastic);
base_demand = demand*base_demand_factor;
deviation_factor = -1.9*(i_category-1);
demand_with_category = base_demand*(1-deviation_factor);

wind =  generateWind(time_vector, params, state, isStochastic);
% wind_with_category = wind*(1+deviation_factor);
% wind_with_category = max(wind_with_category,0);
wind_with_category = wind;
