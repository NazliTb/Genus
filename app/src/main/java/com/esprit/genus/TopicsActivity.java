package com.esprit.genus;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.DialogFragment;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;


import com.esprit.genus.Adapter.TopicAdapter;
import com.esprit.genus.Model.Chat;
import com.esprit.genus.Retrofit.INodeJS;
import com.mancj.materialsearchbar.MaterialSearchBar;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class TopicsActivity extends Fragment {
    INodeJS myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    RecyclerView recycler_chats;
    LinearLayoutManager layoutManager;
    TopicAdapter adapter;
    MaterialSearchBar materialSearchBar;
    List<String> suggestList = new ArrayList<>();
    protected View mView;
    ImageButton addTopic;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable final Bundle savedInstanceState) {

        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.gametopics_layout, container, false);
        this.mView = view;

        addTopic= (ImageButton) mView.findViewById(R.id.addTopic);


        addTopic.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Dialog dialog = new Dialog(getContext());
                dialog.setContentView(R.layout.addtopic_popup_layout);
                dialog.setTitle("Add Topic");
                dialog.setCancelable(true);

                dialog.show();
            }
        });

        //Get userID
        String getidUser = this.getArguments().getString("idUser");
        final String username = this.getArguments().getString("username");
        int idUser = 0;
        try {
            idUser=Integer.parseInt(getidUser);
        } catch (NumberFormatException e) {
            Toast.makeText(getContext(), "No user logged in", Toast.LENGTH_SHORT).show();
        }

        //Init API


        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        myAPI = retrofit.create((INodeJS.class));
        final Call<List<Chat>> listChats = myAPI.GetChatList();



        //View for topicList
        recycler_chats = (RecyclerView) mView.findViewById(R.id.recyclerViewTopics);
        recycler_chats.setHasFixedSize(true);
        layoutManager = new LinearLayoutManager(getContext());
        recycler_chats.setLayoutManager(layoutManager);
        recycler_chats.addItemDecoration(new DividerItemDecoration(getContext(), layoutManager.getOrientation()));


        materialSearchBar = (MaterialSearchBar) mView.findViewById(R.id.search_bar);
        materialSearchBar.setCardViewElevation(10);

        //Add Suggest List
        addSuggestList();

        //Display elements on suggest list
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

        //Display search result
        //final int finalIdUser = idUser;
        materialSearchBar.setOnSearchActionListener(new MaterialSearchBar.OnSearchActionListener() {
            @Override
            public void onSearchStateChanged(boolean enabled) {
                if (!enabled) {
                    //getAllGames(finalIdUser);

                    listChats.enqueue(new Callback<List<Chat>>() {
                        @Override
                        public void onResponse(Call<List<Chat>> call, Response<List<Chat>> response) {
                            if (!response.isSuccessful()) {
                                return;
                            }
                            List<Chat> chats = response.body();
                            adapter = new TopicAdapter(getContext(),chats,username);
                            recycler_chats.setAdapter(adapter);
                        }
                        @Override
                        public void onFailure(Call<List<Chat>> call, Throwable t) {
                            Toast.makeText(getContext(), "Not found", Toast.LENGTH_SHORT).show();
                        }
                    });
                }
            }

            @Override
            public void onSearchConfirmed(CharSequence text) {
                startSearch(text.toString());
            }

            @Override
            public void onButtonClicked(int buttonCode) {

            }
        });

        //getAllGames(idUser);

        //Method to call games list
        listChats.enqueue(new Callback<List<Chat>>() {
            @Override
            public void onResponse(Call<List<Chat>> call, Response<List<Chat>> response) {
                if (!response.isSuccessful()) {
                    return;
                }
                List<Chat> Chats = response.body();
                adapter = new TopicAdapter(getContext(),Chats,username);
                recycler_chats.setAdapter(adapter);
            }
            @Override
            public void onFailure(Call<List<Chat>> call, Throwable t) {
                Toast.makeText(getContext(), "Not found", Toast.LENGTH_SHORT).show();
            }
        });


        return view;
    }

    private void startSearch(String query) {
        compositeDisposable.add(myAPI.searchChats(query)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<List<Chat>>() {
                    @Override
                    public void accept(List<Chat> chats) throws Exception {
                     //   adapter = new ChatAdapter(getContext(),chats,username);
                      //  recycler_chats.setAdapter(adapter);

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
