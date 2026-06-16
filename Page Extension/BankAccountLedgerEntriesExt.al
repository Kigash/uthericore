pageextension 50003 BankAccountLedgerEntriesExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            { }
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify(Reversed)
        {
            Visible = true;
        }
        addafter("Credit Amount")
        {
            field("Running Balance"; Rec."Running Balance")
            {
                Caption = 'Running Balance';
            }
        }

    }

    actions
    {
        modify("Reverse Transaction")
        {
            Visible = false;
        }

        addafter("Reverse Transaction")
        {
            // group(main)
            // {
            //     action(Reverse)
            //     {
            //         Caption = 'Reverse Transaction';
            //         Image = ReverseLines;
            //         Visible = true;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ApplicationArea = Basic, Suite;

            //         trigger OnAction()
            //         var
            //             GLEntry: Record "G/L Entry";
            //             ReversalEntry: Record "Reversal Entry";
            //             VendLE: Record "Vendor Ledger Entry";
            //             vendNo: Code[20];
            //             ReversalAmount: Decimal;
            //         begin
            //             if Reversed then
            //                 ReversalEntry.AlreadyReversedEntry(TableCaption, "Entry No.");
            //             if "Journal Batch Name" = '' then
            //                 ReversalEntry.TestFieldError;
            //             TestField("Transaction No.");

            //             GLEntry.Reset();
            //             GLEntry.SetRange("Document No.", "Document No.");
            //             GLEntry.SetRange("Transaction No.", "Transaction No.");
            //             GLEntry.SetRange(Reversed, false);

            //             if GLEntry.FindSet() then begin
            //                 repeat
            //                     ReversalAmount := GLEntry.Amount;

            //                     VendLE.Reset();
            //                     VendLE.SetRange("Document No.", GLEntry."Document No.");
            //                     VendLE.SetRange("Transaction No.", GLEntry."Transaction No.");
            //                     if VendLE.FindFirst() then begin
            //                         vendNo := VendLE."Vendor No.";
            //                         Description := VendLE.Description;
            //                     end;

            //                     ReversalEntry.SetHideWarningDialogs();
            //                     ReversalEntry.SetHideDialog(true);
            //                     ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");

            //                     descriptionFilterText := COPYSTR(Description, 1, 35);
            //                     if descriptionFilterText = 'Agency Banking deposit - Member No-' then begin
            //                         accTypeCode := CopyStr(vendNo, StrLen(vendNo) - 1, 2);
            //                         if accTypeCode = '04' then begin
            //                             CLEAR(SMSText);
            //                             SMSText.ADDTEXT(STRSUBSTNO(
            //                                 'Dear %1, your deposit transaction worth KSh.%2 has been reversed at %3',
            //                                 fnGetMemberName(vendNo),
            //                                 Format(ReversalAmount),
            //                                 Format(Time)
            //                             ));
            //                             GlobalM.CreateSMSEntry(fnGetMemberTellNo(vendNo), SMSText, 'REVERSAL');
            //                         end;
            //                     end;
            //                 until GLEntry.Next() = 0;
            //             end;
            //         end;
            //     }
            // }
            group(main)
            {
                action(Reverse)
                {
                    Caption = 'Reverse Transaction';
                    Image = ReverseLines;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        GLEntry: Record "G/L Entry";
                        ReversalEntry: Record "Reversal Entry";
                        VendLE: Record "Vendor Ledger Entry";
                        vendNo: Code[20];
                        ReversalAmount: Decimal;
                        Vend: Record Vendor;
                    begin
                        if Reversed then
                            ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, Rec."Entry No.");
                        if Rec."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError;
                        Rec.TestField("Transaction No.");

                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", Rec."Document No.");
                        GLEntry.SetRange("Transaction No.", Rec."Transaction No.");
                        GLEntry.SetRange(Reversed, false);

                        if GLEntry.FindSet() then begin
                            repeat
                                ReversalAmount := GLEntry.Amount;

                                ReversalEntry.SetHideWarningDialogs();
                                ReversalEntry.SetHideDialog(true);
                                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");

                                VendLE.Reset();
                                VendLE.SetRange("Document No.", GLEntry."Document No.");
                                VendLE.SetRange("Transaction No.", GLEntry."Transaction No.");
                                if VendLE.FindFirst() then begin
                                    vendNo := VendLE."Vendor No.";
                                    ReversalDescription := VendLE.Description;
                                    Vend.Get(vendNo);
                                    If (Vend."Account Type" = '04') and (STRPOS(ReversalDescription, 'Agency Banking deposit - Member No') > 0) then begin
                                        CLEAR(SMSText);
                                        SMSText.ADDTEXT(STRSUBSTNO(
                                            'Dear %1, your deposit transaction worth KSh.%2 has been reversed at %3',
                                             Vend."Member Name",
                                            Format(ReversalAmount),
                                            Format(Time)));
                                        GlobalM.CreateSMSEntry(fnGetMemberTellNo(vendNo), SMSText, 'REVERSAL');
                                    end;
                                end;
                            until GLEntry.Next() = 0;
                        end;
                        Message('Transaction reversed successfully');
                    end;
                }
            }


        }
    }

    trigger OnOpenPage()
    begin
        FnUpdateRemainingBal(Rec.GETFILTER("Bank Account No."));
    end;

    procedure FnUpdateRemainingBal(BLAccount: Code[50])
    var
        ObjBank: Record "Bank Account";
        ObjBL: Record "Bank Account Ledger Entry";
    begin
        ObjBank.RESET;
        ObjBank.SETRANGE("No.", BLAccount);
        IF ObjBank.FINDFIRST THEN BEGIN
            RunningBalance := 0;
            ObjBL.RESET;
            ObjBL.SETCURRENTKEY("Posting Date", "Entry No.");
            ObjBL.ASCENDING();
            ObjBL.SETRANGE(ObjBL."Bank Account No.", ObjBank."No.");
            IF ObjBL.FINDSET(TRUE) THEN BEGIN
                REPEAT
                    RunningBalance := ObjBL.Amount + RunningBalance;
                    ObjBL."Running Balance" := RunningBalance;
                    ObjBL.MODIFY;
                UNTIL ObjBL.NEXT = 0;
            END;
        END;
    end;

    local procedure fnGetMemberName(vendNo: Code[34]) fullName: Text[200]
    var
        vend: Record Vendor;
        memb: Record Member;
    begin
        vend.Reset();
        vend.SetRange("No.", vendNo);
        if vend.Find('-') then begin
            memb.Reset();
            memb.SetRange("No.", vend."Member No.");
            if memb.Find('-') then
                fullName := memb."Full Name";
            exit(fullName);
        end;
    end;

    local procedure fnGetMemberTellNo(vendNo: Code[34]) cellNo: Text[15]
    var
        vend: Record Vendor;
        memb: Record Member;
    begin
        vend.Reset();
        vend.SetRange("No.", vendNo);
        if vend.Find('-') then begin
            memb.Reset();
            memb.SetRange("No.", vend."Member No.");
            if memb.Find('-') then
                cellNo := memb."Phone No.";
            exit(cellNo);
        end;
    end;

    var
        BankL: Record "Bank Account Ledger Entry";
        RunningBalance: Decimal;
        ReversalDescription: Text;
        Reversed: Boolean;
        ExternalDocNo: Code[150];
        accTypeCode: Code[10];
        SMSText: BigText;
        GlobalM: Codeunit "Global Management";
        descriptionFilterText: Text[200];
}
