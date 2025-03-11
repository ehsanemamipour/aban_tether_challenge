import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_bloc.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_event.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_state.dart';
import 'package:aban_tether_challenge/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch an event to fetch coins when the screen is loaded.
    // Make sure that CoinsBloc is provided in the widget tree.
    // context.read<CoinsBloc>().add(FetchCoinsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Coins', style: appTheme.medium20),
        backgroundColor: appTheme.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: appTheme.white),
            onPressed: () => context.go('/coinPage/profilePage'),
          ),
        ],
      ),
      backgroundColor: appTheme.black,
      body: BlocProvider(
             create: (_) => serviceLocator<CoinBloc>(),
        child: BlocConsumer<CoinBloc, CoinState>(
          listener: (context, state) {
            if (state is CoinError) {
              // Optionally show an error message using a snackbar.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is CoinLoading) {
              return Center(
                child: CircularProgressIndicator(color: appTheme.white),
              );
            } else if (state is CoinLoaded) {
              final coins = state.coin;
              return ListView.separated(
                itemCount: coins.length,
                separatorBuilder: (_, __) => Divider(
                  color: appTheme.gray500,
                ),
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  return ListTile(
                    leading: Image.network(
                      coin.iconUrl,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(
                      coin.name,
                      style: appTheme.medium16.copyWith(color: appTheme.white),
                    ),
                    subtitle: Text(
                      '${coin.symbol} • \$${coin.price.toStringAsFixed(2)}',
                      style: appTheme.medium16.copyWith(color: appTheme.white70),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        coin.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: coin.isFavorite ? Colors.red : appTheme.white,
                      ),
                      onPressed: () {
                        // Toggle favorite status using respective events.
                        if (coin.isFavorite) {
                          context.read<CoinBloc>().add(RemoveFavoriteEvent(coinId: coin.id));
                        } else {
                          context.read<CoinBloc>().add(AddFavoriteEvent(coinId: coin.id));
                        }
                      },
                    ),
                  );
                },
              );
            } else if (state is CoinError) {
              return Center(
                child: Text(
                  state.message,
                  style: appTheme.medium16.copyWith(color: Colors.red),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
