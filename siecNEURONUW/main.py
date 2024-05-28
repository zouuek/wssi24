import numpy as np
import matplotlib.pyplot as plt
import networkx as nx


class Neuron:
    def __init__(self, n_inputs, bias=0., weights=None):
        self.b = bias
        if weights:
            self.ws = np.array(weights)
        else:
            self.ws = np.random.rand(n_inputs)

    def _f(self, x):  # activation function (leaky_relu)
        return max(x * .1, x)

    def __call__(self, xs):
        return self._f(xs @ self.ws + self.b)


class NeuralNetwork:
    def __init__(self, input_size, hidden_sizes, output_size):
        self.input_layer = [Neuron(1) for _ in range(input_size)]
        self.hidden_layer1 = [Neuron(input_size) for _ in range(hidden_sizes[0])]
        self.hidden_layer2 = [Neuron(hidden_sizes[0]) for _ in range(hidden_sizes[1])]
        self.output_neuron = Neuron(hidden_sizes[1])

    def przekaz(self, input_data):
        hidden1_outputs = [neuron(input_data) for neuron in self.hidden_layer1]
        hidden2_outputs = [neuron(hidden1_outputs) for neuron in self.hidden_layer2]
        output = self.output_neuron(hidden2_outputs)
        return output


def wyswietl():
    G = nx.DiGraph()

    input_nodes = ['Input 1', 'Input 2', 'Input 3']
    hidden1_nodes = ['Hidden 1-1', 'Hidden 1-2', 'Hidden 1-3', 'Hidden 1-4']
    hidden2_nodes = ['Hidden 2-1', 'Hidden 2-2', 'Hidden 2-3', 'Hidden 2-4']
    output_node = ['Output']

    # dodawanie do grafa
    G.add_nodes_from(input_nodes)
    G.add_nodes_from(hidden1_nodes)
    G.add_nodes_from(hidden2_nodes)
    G.add_nodes_from(output_node)

    # polaczenia
    for input_node in input_nodes:
        for hidden1_node in hidden1_nodes:
            G.add_edge(input_node, hidden1_node)
    for hidden1_node in hidden1_nodes:
        for hidden2_node in hidden2_nodes:
            G.add_edge(hidden1_node, hidden2_node)
    for hidden2_node in hidden2_nodes:
        G.add_edge(hidden2_node, output_node[0])

    # pozycjoning
    pos = {
        'Input 1': (0, 2.5), 'Input 2': (0, 1.75), 'Input 3': (0, 1),
        'Hidden 1-1': (1.5, 3), 'Hidden 1-2': (1.5, 2.25), 'Hidden 1-3': (1.5, 1.5), 'Hidden 1-4': (1.5, 0.75),
        'Hidden 2-1': (3, 3), 'Hidden 2-2': (3, 2.25), 'Hidden 2-3': (3, 1.5), 'Hidden 2-4': (3, 0.75),
        'Output': (4.5, 1.75)
    }

    # rysowanie
    nx.draw(
        G,
        pos,
        with_labels=True,
        node_size=2000,
        node_color='lightblue',
        font_size=10,
        font_color='black',
        edge_color='gray'
    )

    # dodawanie labeli do wasts
    layer_labels = ['Input Layer', 'Hidden Layer 1', 'Hidden Layer 2', 'Output Layer']
    for i, (layer, label) in enumerate(zip([input_nodes, hidden1_nodes, hidden2_nodes, output_node], layer_labels)):
        x = pos[layer[0]][0] - 0.5
        y = max(pos[node][1] for node in layer) + 0.5
        plt.text(x, y, label, fontsize=12, bbox=dict(facecolor='white', edgecolor='black', boxstyle='round,pad=0.3'))

    plt.xlim(-1, 5)
    plt.ylim(0, 4)
    plt.axis('off')
    plt.show()


# inicjalizacja dla roznych sizuw
input_size = 3
hidden_sizes = [4, 4]
output_size = 1

network = NeuralNetwork(input_size, hidden_sizes, output_size)
print("UWAGA wyswietlam")
wyswietl()
