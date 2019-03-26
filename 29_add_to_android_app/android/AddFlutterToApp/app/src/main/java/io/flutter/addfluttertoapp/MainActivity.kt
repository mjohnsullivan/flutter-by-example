package io.flutter.addfluttertoapp

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.google.android.material.bottomnavigation.BottomNavigationView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import kotlinx.android.synthetic.main.activity_main.*
import io.flutter.facade.Flutter



class MainActivity : AppCompatActivity() {

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        removeAllFragments()
        when (item.itemId) {
            R.id.navigation_home -> {
                addFragment(null, "I am an Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_dashboard -> {
                addFragment(null, "I am a second Android Fragment!!!")
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_notifications -> {
                // addFragment(null, "I am a Flutter Fragment!!!")
                addFlutterFragment()
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        addFragment(null, "I am an Android Fragment!!!")
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

    private fun addFragment(savedInstanceState: Bundle?, text: String) {
        if (savedInstanceState == null) {
            supportFragmentManager
                .beginTransaction()
                .add(R.id.fragment_container,
                     AndroidFragment.newInstance(text),
                    "mainFragment")
                .commit()
        }
    }

    private fun removeAllFragments() {
        for (fragment in supportFragmentManager.fragments) {
            supportFragmentManager.beginTransaction().remove(fragment).commit()
        }
    }


    private fun addFlutterFragment() {
        supportFragmentManager.beginTransaction()
        .add(R.id.fragment_container,
             Flutter.createFragment("flutterFragment"),
             "flutterFragment")
        .commit()
    }


}


class AndroidFragment : Fragment() {

    companion object {
        fun newInstance(text: String): AndroidFragment {
            val fragment = AndroidFragment()
            val args = Bundle()
            args.putString("text", text)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_main, container, false)
        arguments?.getString("text").let {
            view.findViewById<TextView>(R.id.fragment_message).setText(it)
        }
        return view
    }
}