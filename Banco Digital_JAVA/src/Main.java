import Entidades.Cliente;
import Entidades.Conta;
import Entidades.ContaCorrente;
import Entidades.ContaPoupanca;

public class Main {
    public static void main(String[] args) {
        Cliente ana = new Cliente();
        ana.setNome("Ana");

        ContaCorrente cc = new ContaCorrente(ana);
        ContaPoupanca poupanca = new ContaPoupanca(ana);


        cc.depositar(100);
        cc.transferir(100, poupanca);

        cc.imprimirInfosComuns();
        poupanca.imprimirInfosComuns();
    }
}