report 50472 "Employer's Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report/BOSA/Employer Advice.rdl';

    dataset
    {
        dataitem(Member; Member)
        {
            RequestFilterFields = "Checkoff Company Code";
            column(ConsolidatedPrinciple; Amount[1])
            {
            }
            column(ConsolidatedInt; Amount[11])
            {
            }
            column(NormalPrinciple; Amount[2])
            {
            }
            column(NormalInt; Amount[21])
            {
            }
            column(ProductPrinciple; Amount[3])
            {
            }
            column(ProductInt; Amount[31])
            {
            }
            column(SchPrinciple; Amount[4])
            {
            }
            column(SchInt; Amount[41])
            {
            }
            column(EmergPrinciple; Amount[5])
            {
            }
            column(EmergInt; Amount[51])
            {
            }
            column(ChristPrinciple; Amount[6])
            {
            }
            column(ChristInt; Amount[61])
            {
            }
            column(ShortPrinciple; Amount[7])
            {
            }
            column(ShortInt; Amount[71])
            {
            }
            column(TopPrinciple; Amount[8])
            {
            }
            column(TopInt; Amount[81])
            {
            }
            column(FullName_Member; Member."Full Name")
            {
            }
            column(OldMemberNo_Member; Member."Payroll No.")
            {
            }
            column(Date; Date)
            {
            }
            column(Deposit; Deposit)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(Employer; Employer)
            {
            }
            column(PayrollNo_Member; Member."Payroll No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Employer := Member."Checkoff Company Code";
                TotalLoans := 0;
                Amount[1] := 0;
                Amount[11] := 0;
                Amount[2] := 0;
                Amount[21] := 0;
                Amount[3] := 0;
                Amount[31] := 0;
                Amount[4] := 0;
                Amount[41] := 0;
                Amount[5] := 0;
                Amount[51] := 0;
                Amount[6] := 0;
                Amount[61] := 0;
                Amount[7] := 0;
                Amount[71] := 0;
                Amount[8] := 0;
                Amount[81] := 0;
                Deposit := 3000;

                Loans.RESET;
                Loans.SETRANGE(Loans."Member No.", "No.");
                Loans.SETFILTER(Loans."Next Due Date", '<=%1', Date);
                if Loans.FINDSET then begin
                    repeat
                        // LProduct.GET;
                        Loans.CALCFIELDS("Outstanding Balance");
                        if Loans."Outstanding Balance" > 0 then begin
                            if Loans."Loan Product Type" = 'DEV' then begin
                                //Amount[1] := Loans."Monthly Repayment";
                                Amount[11] := ROUND(Loans."Outstanding Balance" * Loans."Interest Rate" / 1200, 0.5, '>');
                            end;
                            if Loans."Loan Product Type" = 'EDU' then begin
                                //Amount[2] := Loans."Monthly Repayment";
                                Amount[21] := ROUND(Loans."Outstanding Balance" * Loans."Interest Rate" / 1200, 0.5, '>');
                            end;
                            if Loans."Loan Product Type" = 'EL' then begin
                                //Amount[3] := Loans."Monthly Repayment";
                                Amount[31] := ROUND(Loans."Outstanding Balance" * Loans."Interest Rate" / 1200, 0.5, '>');
                            end;
                        end;
                    until Loans.NEXT = 0;
                    TotalLoans := Amount[1] + Amount[11] + Amount[2] + Amount[21] + Amount[3] + Amount[31] + Amount[4] + Amount[41] + Amount[5] + Amount[51] +
                                  Amount[6] + Amount[61] + Amount[7] + Amount[71] + Amount[8] + Amount[81];
                end;
            end;

            trigger OnPreDataItem();
            begin
                if Date = 0D then ERROR('Kindly Input Date');
                CompanyCode := Member.GETFILTER("Checkoff Company Code");
                if CompanyCode = '' then ERROR('Kindly Specify The Employer');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Date; Date)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInformation.GET
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        Loans: Record "Loan Application";
        Amount: array[10000] of Decimal;
        Date: Date;
        LProduct: Record "Loan Product Type";
        Total: array[10000] of Decimal;
        Deposit: Decimal;
        CompanyInformation: Record "Company Information";
        TotalLoans: Decimal;
        Employer: Text[100];
        CompanyCode: Code[20];
}

