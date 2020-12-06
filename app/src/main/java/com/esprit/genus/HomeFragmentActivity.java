package com.esprit.genus;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.esprit.genus.Adapter.GameAdapter;
import com.esprit.genus.Model.Game;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;
import com.mancj.materialsearchbar.MaterialSearchBar;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class HomeFragmentActivity extends Fragment {

    INodeJS myAPI, myAPI1;
    CompositeDisposable compositeDisposable = new CompositeDisposable();

    RecyclerView recycler_games, recycler_fav;
    LinearLayoutManager layoutManager, layoutManagerFav;
    GameAdapter adapter;
    MaterialSearchBar materialSearchBar;
    List<String> suggestList = new ArrayList<>();
    protected View mView;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.fragment_gamelist, container, false);
        this.mView = view;

        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        Retrofit retrofit1 = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        myAPI1 = retrofit1.create((INodeJS.class));
        final Call<List<Game>> topPicksGames = myAPI1.GetTopPicksGames();
        final Call<List<Game>> bestRateGames = myAPI1.GetTopPicksGames();
        final Call<List<Game>> trendingGames = myAPI1.GetTopPicksGames();

        return view;
    }

    private void startSearch(String query) {
        compositeDisposable.add(myAPI.searchGames(query)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<List<Game>>() {
                    @Override
                    public void accept(List<Game> games) throws Exception {
                        adapter = new GameAdapter(games);
                        recycler_games.setAdapter(adapter);

                    }
                }, new Consumer<Throwable>() {
                    @Override
                    public void accept(Throwable throwable) throws Exception {
                        Toast.makeText(getContext(), "Not found", Toast.LENGTH_SHORT).show();
                    }
                }));
    }

    private void addSuggestList() {
        //load items manually for suggest list
        suggestList.add("League of legends");
        suggestList.add("World of warcraft");
        suggestList.add("Dota 2");
        suggestList.add("Counter Strike");
        suggestList.add("GTA");

        materialSearchBar.setLastSuggestions(suggestList);
    }
}