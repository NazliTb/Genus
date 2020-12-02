package com.esprit.genus;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.esprit.genus.Adapter.GameAdapter;
import com.esprit.genus.Model.Game;
import com.esprit.genus.Retrofit.INodeJS;
import com.mancj.materialsearchbar.MaterialSearchBar;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;

public class GamelistActivity extends Fragment {

    INodeJS myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();

    RecyclerView recycler_games;
    LinearLayoutManager layoutManager;
    GameAdapter adapter;
    MaterialSearchBar materialSearchBar;
    List<String> suggestList = new ArrayList<>();

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        //Get userID
        final int idUser = Integer.parseInt(this.getArguments().getString("idUser"));

        //Add Suggest List
        addSuggestList();

        //View
        recycler_games = (RecyclerView) getView().findViewById(R.id.recyclerViewGames);
        recycler_games.setHasFixedSize(true);
        layoutManager = new LinearLayoutManager(getContext());
        recycler_games.addItemDecoration(new DividerItemDecoration(getContext(), layoutManager.getOrientation()));

        materialSearchBar = (MaterialSearchBar) getView().findViewById(R.id.search_bar);
        materialSearchBar.setCardViewElevation(10);
        materialSearchBar.addTextChangeListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                List<String> suggest = new ArrayList<>();
                for (String search_term:suggestList) {
                    if (search_term.toLowerCase().contains(materialSearchBar.getText().toLowerCase())) {
                        suggest.add(search_term);
                    }
                }
                materialSearchBar.setLastSuggestions(suggest);

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
        materialSearchBar.setOnSearchActionListener(new MaterialSearchBar.OnSearchActionListener() {
            @Override
            public void onSearchStateChanged(boolean enabled) {
                if (!enabled) { getAllGames(idUser); }
            }

            @Override
            public void onSearchConfirmed(CharSequence text) {
                startSearch(text.toString());
            }

            @Override
            public void onButtonClicked(int buttonCode) {

            }
        });

        getAllGames(idUser);

        return inflater.inflate(R.layout.fragment_gamelist, container, false);
    }

    private void startSearch(String query) {
        

    }

    private void getAllGames(int idUser) {
        compositeDisposable.add(myAPI.GetGameList(idUser)
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
    }
}