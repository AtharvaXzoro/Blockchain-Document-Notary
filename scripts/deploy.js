async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Notary = await ethers.getContractFactory("Notary");
  const notary = await Notary.deploy();

  await notary.deployed();

  console.log("Notary deployed to:", notary.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
