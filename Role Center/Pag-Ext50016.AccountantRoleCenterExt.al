pageextension 50016 "Accountant RoleCenter Ext" extends "Accountant Role Center"
{
    layout
    {
        addfirst(RoleCenter)
        {
            part(Part1; "FOSA RoleCenter Headline")
            {
                ApplicationArea = All;
            }

            part(Part2; "FOSA Activities")
            {
                Caption = 'Members Analysis';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(BankAccountReconciliations)
        {
            Visible = false;
        }
        addbefore("Chart of Accounts")
        {
            action(RequestApproval)
            {
                Caption = 'Requests To Approve';
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;
            }
            group(Members)
            {
                Caption = 'Sacco Members';
                action(MembersIndividual)
                {
                    Caption = 'Individual Members';
                    RunObject = Page "Member List";
                    ApplicationArea = All;
                }
                action(MembersGroup)
                {
                    Caption = 'Groups';
                    RunObject = Page MemberListGroup;
                    ApplicationArea = All;
                }
                action(MembersJunior)
                {
                    Caption = 'Junior Members';
                    RunObject = Page MemberListJunior;
                    ApplicationArea = All;
                }
                action(MembersStaff)
                {
                    Caption = 'Staff';
                    RunObject = Page MemberListStaff;
                    ApplicationArea = All;
                }
                action(MembersBoard)
                {
                    Caption = 'Board';
                    RunObject = Page MemberListBoard;
                    ApplicationArea = All;
                }
            }
            group(PeriodicActivities)
            {
                Caption = 'Periodic Activities';
                action("CapitalizeInterest2")
                {
                    Caption = 'Run Monthly Interest';
                    ApplicationArea = All;
                    RunObject = report "Run Monthly Interest";
                }
                action(CapitalizeLedgerFee)
                {
                    Caption = 'Capitalize Ledger Fee';
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = report "Capitalize Ledger Fee";
                }
                action(CapitalizePenalty2)
                {
                    Caption = 'Run Monthly Penalty';
                    ApplicationArea = All;
                    RunObject = report "Run Monthly Penalty";
                }
                action(RecoverPenalty)
                {
                    Caption = 'Recover Penalty';
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = report "Recover Penalty Charges.";
                }
                action("Run Standing Order")
                {
                    Visible = false;
                    ApplicationArea = All;
                    RunObject = report "Run Standing Order";
                }
                action("Run Loan Recovery")
                {
                    ApplicationArea = All;
                    RunObject = report "Run Loan Recovery";
                }
                action(OverpaymentTransfer2)
                {
                    Caption = 'Overpayment Transfer';
                    RunObject = report "Overpayment Transfer";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Share Deposits")
                {
                    ApplicationArea = All;
                    RunObject = report "Share Capital End Month";
                }
                action("Benevolent Deposits")
                {
                    ApplicationArea = All;
                    RunObject = report "Benevolent  End Month";
                }

            }
            group(DividendProcessing)
            {
                Caption = 'Dividend Processing';
                action("New Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-New";
                }
                action("Pending Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Pending";
                }
                action("Approved Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Approved";
                }
                action("Posted Dividend")
                {
                    ApplicationArea = All;
                    RunObject = page "Dividends List-Posted";
                }

            }
            group(ExitManagement)
            {
                Caption = 'Exit Management';
                group(ExitProcessing)
                {
                    Caption = 'Exit Processing';
                    action("New Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-New";
                    }
                    action("Pending Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Pending";
                    }
                    action("Approved Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Approved";
                    }
                    action("Posted Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Posted";
                    }
                    action("Rejected Member Exit")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Exit List-Rejected";
                    }
                }
            }
            group(SavingsWithManagement)
            {
                Caption = 'Savings Withdrawal';
                action("New Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "Member Savings With List-New";

                }
                action("Pending Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Pending";

                }
                action("Approved Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Pending";

                }
                action("Posted Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Posted";

                }
                action("Rejected Member Savings Withdrawal")
                {
                    ApplicationArea = All;
                    RunObject = page "MemberSavings WithList-Rejectd";

                }
            }
            group(ArchiveManagement)
            {
                Caption = 'Archive Management';
                group(ArchiveProcessing)
                {
                    Caption = 'Archive Processing';
                    action("New Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-New";

                    }
                    action("Pending Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Pending";

                    }
                    action("Approved Member Archive")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Approved";

                    }
                    action("Archived Members")
                    {
                        ApplicationArea = All;
                        RunObject = page "Member Achive List-Posted";

                    }
                }
            }
        }
        addafter(PaymentJournals)
        {
            group(BoardPaymentVouchers)
            {
                Caption = 'Board Members Payment Vouchers';
                Visible = true;
                action(NewBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board Payment Voucher List-New";
                    ToolTip = 'New Board Payment Voucher List stage';
                }
                action(PendingBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Pending";
                    ToolTip = 'Pending Board Payment Voucher List stage';
                }
                action(ApprovedBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Approved";
                    ToolTip = 'Approved Board Payment Voucher stage';

                }
                action(PostedBoardPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Board Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Board PaymentV List-Posted";
                    ToolTip = 'Posted Board Payment Voucher stage';
                }
            }

            group(PaymentVouchers)
            {
                Caption = 'Payments Vouchers';

                action(NewPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Voucher List-New";
                    ToolTip = 'Reconcile all Payment Voucher List stage';
                }
                action(PendingPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "Payment Voucher List-Pending";
                    ToolTip = 'Reconcile all Payment Voucher List stage';
                }
                action(ApprovedPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "Payment Voucher List-Approved";
                    ToolTip = 'Reconcile all Approved Payment Voucher stage';

                }
                action(PostedPaymentVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Payment Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Payment Voucher List-Posted";
                    ToolTip = 'Reconcile all Posted Payment Voucher stage';
                }
            }
            group(PettyCashVouchers)
            {
                Caption = 'PettyCash Vouchers';
                Visible = false;

                action(NewPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash Voucher List-New";
                    ToolTip = 'Reconcile all PettyCash Voucher List stage';
                }
                action(PendingPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash Voucher List-Pending";
                    ToolTip = 'Reconcile all PettyCash Voucher List stage';
                }
                action(ApprovedPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash V. List-Approved";
                    ToolTip = 'Reconcile all Approved PettyCash Voucher stage';

                }
                action(PostedPettyCashVoucherlist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted PettyCash Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "PettyCash V. List-Posted";
                    ToolTip = 'Reconcile all Posted PettyCash Voucher stage';
                }
            }
            group(ReceiptVouchers)
            {
                Caption = 'Receipt Vouchers';
                action(NewReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipt Voucher List-New";
                    ToolTip = 'Reconcile all Receipt Voucher List stage';

                }
                action(PostedReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Receipt Voucher List-Posted";
                    ToolTip = 'Reconcile all Posted Receipt Voucher List stage';

                }
            }
            group(CheckoffReceiptVouchers)
            {
                Caption = 'Checkoff Receipt Vouchers';
                action(NewCheckoffReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Checkoff Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Rct. Voucher List-New";
                    ToolTip = 'Reconcile all Checkoff Receipt Voucher List stage';

                }
                action(PostedCheckoffReceiptVoucher)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Checkoff Receipt Vouchers';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff Rcpt V. List-Posted";
                    ToolTip = 'Reconcile all Posted Checkoff Receipt Voucher List stage';

                }
            }
            group(Checkoff)
            {
                Caption = 'Checkoff';
                Visible = false;
                action(NewCheckoff)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Checkoffs';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff List-New";
                    ToolTip = 'Reconcile all Checkoffs List stage';

                }
                action(PostedCheckoff)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Checkoffs';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Checkoff List-Posted";
                    ToolTip = 'Reconcile all Posted CheckoffsList stage';

                }


            }
            group(FundTransfer)
            {
                Caption = 'Fund Transfer';
                action("New Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-New";

                }
                action("Pending Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Pending";

                }
                action("Approved Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Approved";

                }
                action("Rejected Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Rejected";

                }
                action("Posted Fund Transfer")
                {
                    ApplicationArea = All;
                    RunObject = page "Fund Transfer List-Posted";

                }
            }
        }
        addafter(Currencies)
        {

        }
        addbefore(BankAccountReconciliations)
        {
            action(BankReconciliationNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Acc. Reconciliations';
                Image = CashFlowSetup;
                RunObject = Page "Bank Acc Reconc. List New";
                ToolTip = 'Bank Account Reconciliations';
            }
        }
        //addbefore(inv)
    }
}
